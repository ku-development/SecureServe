function LPH_JIT_MAX(func)
    return function(...)
        return func(...)
    end
end
function LPH_NO_VIRTUALIZE(func)
    return function(...)
        return func(...)
    end
end

--> [Callbacks] <--
local IS_SERVER = IsDuplicityVersion()
local table_unpack = table.unpack
-- from scheduler.lua
local debug = debug
local debug_getinfo = debug.getinfo
local msgpack = msgpack
local msgpack_pack = msgpack.pack
local msgpack_unpack = msgpack.unpack
local msgpack_pack_args = msgpack.pack_args
-- from deferred.lua
local PENDING = 0
local RESOLVING = 1
local REJECTING = 2
local RESOLVED = 3
local REJECTED = 4

-- custom function to check any type
    local ensure = LPH_NO_VIRTUALIZE(function (obj, typeof, opt_typeof, errMessage)
	local objtype = type(obj)
	local di = debug_getinfo(2)
	local errMessage = errMessage or (opt_typeof == nil and (di.name .. ' expected %s, but got %s') or (di.name .. ' expected %s or %s, but got %s'))
	if typeof ~= 'function' then
		if objtype ~= typeof and objtype ~= opt_typeof then
			error((errMessage):format(typeof, (opt_typeof == nil and objtype or opt_typeof), objtype))
		end
	else
		if objtype == 'table' and not rawget(obj, '__cfx_functionReference') then
			error((errMessage):format(typeof, (opt_typeof == nil and objtype or opt_typeof), objtype))
		end
	end
end)

-- SERVER-SIDE
if IS_SERVER then
	--
	-- @table RegisterServerCallback
	--
	-- @string eventName - The name of the event to be registered
	-- @function eventCallback - The function to be executed when event is fired
	_G.RegisterServerCallback = function(args)
		ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.eventCallback, 'function')

		-- save the callback function on this call
		local eventCallback = args.eventCallback
		-- save the event name on this call
		local eventName = args.eventName
		-- save the event data to return
		local eventData = RegisterNetEvent('smp__server_callback:'..eventName, function(packed, src, cb)
			-- save the source on this call
			local source = tonumber(source)
			-- check if this is a simulated callback (TriggerServerCallback)
			if not source then
				-- return the simulated data
				cb( msgpack_pack_args( eventCallback(src, table_unpack(msgpack_unpack(packed)) ) ) )
			else
				-- return the data
				TriggerClientEvent(('smp__client_callback_response:%s:%s'):format(eventName, source), source, msgpack_pack_args( eventCallback(source, table_unpack(msgpack_unpack(packed)) ) ))
			end
		end)
		-- return the event data to UnregisterServerCallback
		return eventData
	end

	--
	-- @void UnregisterServerCallback
	--
	-- @table eventData - The data from the RegisterServerCallback
	_G.UnregisterServerCallback = function(eventData)
		RemoveEventHandler(eventData)
	end

	--
	-- @any TriggerClientCallback
	--
	-- @string/number source - The playerId to be triggered
	-- @string eventName - The name of the event to be fired
	-- @table args - The arguments to be sent with the event
	-- [@number timeout - Seconds to wait for response]
	-- [@function timedout - The function that will be executed if timeout is reached]
	-- [@function callback - Asynchronous response]
	_G.TriggerClientCallback = function(args)
		ensure(args, 'table'); ensure(args.source, 'string', 'number'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

		-- check if is a valid playerId [1-...]
		if tonumber(args.source) >= 0 then
			-- create a new ticket
			local ticket = tostring(args.source) .. 'x' .. tostring(GetGameTimer())
			-- create a new promise
			local prom = promise.new()
			-- save the callback function on this call
			local eventCallback = args.callback
			-- save the event data on this call
			local eventData = RegisterNetEvent(('smp__callback_retval:%s:%s:%s'):format(args.source, args.eventName, ticket), function(packed)
				-- check if this call was async
				-- & if promise wasn't rejected or resolved
				if eventCallback and prom.state == PENDING then eventCallback( table_unpack(msgpack_unpack(packed)) ) end
				prom:resolve( table_unpack(msgpack_unpack(packed)) )
			end)

			-- request the callback
			TriggerClientEvent(('smp__client_callback:%s'):format(args.eventName), args.source, msgpack_pack(args.args or {}), ticket)

			-- timeout response
			if args.timeout ~= nil and args.timedout then
				local timedout = args.timedout
				SetTimeout(args.timeout * 1000, function()
					-- check if promise wasn't resolved
					if
						prom.state == PENDING or
						prom.state == REJECTED or
						prom.state == REJECTING
					then
						-- call the timeout callback
						timedout(prom.state)
						-- reject the promise
						if prom.state == PENDING then prom:reject() end
						-- remove the event handler
						RemoveEventHandler(eventData)
					end
				end)
			end

			-- check if this call was async
			if not eventCallback then
				local result = Citizen.Await(prom)
				-- remove the event handler
				RemoveEventHandler(eventData)
				return result
			end
		else
			-- raise an error if source isn't valid
			error 'source should be equal too or higher than 0'
		end
	end

	--
	-- @any TriggerServerCallback
	-- Simulate a client callback
	--
	-- @string/number source - The simulated playerId that triggers
	-- @string eventName - The name of the event to be fired
	-- @table args - The arguments to be sent with the event
	-- [@number timeout - Seconds to wait for response]
	-- [@function timedout - The function that will be executed if timeout is reached]
	-- [@function callback - Asynchronous response]
	_G.TriggerServerCallback = function(args)
		ensure(args, 'table'); ensure(args.source, 'string', 'number'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

		-- create a new promise
		local prom = promise.new()
		-- save the callback on this call
		local eventCallback = args.callback
		-- save the event name on this call
		local eventName = args.eventName
		TriggerEvent('smp__server_callback:'..eventName, msgpack_pack(args.args or {}), args.source,
		function(packed)
			-- check if this call was async
			-- & if promise wasn't rejected or resolved
			if eventCallback and prom.state == PENDING then eventCallback( table_unpack(msgpack_unpack(packed)) ) end
			prom:resolve( table_unpack(msgpack_unpack(packed)) )
		end)

		-- timeout response
		if args.timeout ~= nil and args.timedout then
			local timedout = args.timedout
			SetTimeout(args.timeout * 1000, function()
				-- check if promise wasn't resolved
				if
					prom.state == PENDING or
					prom.state == REJECTED or
					prom.state == REJECTING
				then
					-- call timeout callback
					timedout(prom.state)
					-- reject the promise
					if prom.state == PENDING then prom:reject() end
				end
			end)
		end

		-- check if this call was async
		if not eventCallback then
			return Citizen.Await(prom)
		end
	end
end

-- CLIENT-SIDE
if not IS_SERVER then
	local SERVER_ID = GetPlayerServerId(PlayerId())

	--
	-- @table RegisterClientCallback
	--
	-- @string eventName - The name of the event to be fired
	-- @function eventCallback - The function to be executed when event is fired
	_G.RegisterClientCallback = function(args)
		ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.eventCallback, 'function')
		
		-- save the callback function on this call
		local eventCallback = args.eventCallback
		-- save the event name on this call
		local eventName = args.eventName
		-- save the event data to return
		local eventData = RegisterNetEvent('smp__client_callback:'..eventName, function(packed, ticket)
			-- check if this call is simulated (TriggerClientCallback)
			if type(ticket) == 'function' then
				-- return the data to the simulated call
				ticket( msgpack_pack_args( eventCallback( table_unpack(msgpack_unpack(packed)) ) ) )
			else
				-- return the data to the call
				TriggerServerEvent(('smp__callback_retval:%s:%s:%s'):format(SERVER_ID, eventName, ticket), msgpack_pack_args( eventCallback( table_unpack(msgpack_unpack(packed)) ) ))
			end
		end)
		-- return event data so you can UnregisterClientCallback
		return eventData
	end

	--
	-- @void UnregisterClientCallback
	--
	-- @table eventData - The data from RegisterClientCallback
	_G.UnregisterClientCallback = function(eventData)
		RemoveEventHandler(eventData)
	end

	--
	-- @any TriggerServerCallback
	--
	-- @string eventName - The name of the event to be fired
	-- @table args - The arguments passed with the event
	-- [@number timeout - Seconds to wait for response]
	-- [@function timedout - The function that will be executed if timeout is reached]
	-- [@function callback - Asynchronous response]
	_G.TriggerServerCallback = function(args)
		ensure(args, 'table'); ensure(args.args, 'table', 'nil'); ensure(args.eventName, 'string'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')
		
		-- create a new promise
		local prom = promise.new()
		-- save the callback function on this call
		local eventCallback = args.callback
		-- save the event data to remove it when resolved
		local eventData = RegisterNetEvent(('smp__client_callback_response:%s:%s'):format(args.eventName, SERVER_ID),
		function(packed)
			-- check if this call is async
			-- & the promise wasn't rejected or resolved
			if eventCallback and prom.state == PENDING then eventCallback( table_unpack(msgpack_unpack(packed)) ) end
			prom:resolve( table_unpack(msgpack_unpack(packed)) )

		end)

		-- fire the callback event
		TriggerServerEvent('smp__server_callback:'..args.eventName, msgpack_pack( args.args ))

		-- timeout response
		if args.timeout ~= nil and args.timedout then
			local timedout = args.timedout
			SetTimeout(args.timeout * 1000, function()
				-- check if the promise wasn't resolved yet
				if
					prom.state == PENDING or
					prom.state == REJECTED or
					prom.state == REJECTING
				then
					-- call the timeout callback
					timedout(prom.state)
					-- reject the promise if it wasn't rejected
					if prom.state == PENDING then prom:reject() end
					-- remove the event handler
					RemoveEventHandler(eventData)
				end
			end)
		end

		-- check if this call is async
		if not eventCallback then
			local result = Citizen.Await(prom)
			-- remove the event handler
			RemoveEventHandler(eventData)
			return result
		end
	end

	--
	-- @any TriggerClientCallback
	-- Simulate a server callback
	--
	-- @string eventName - The name of the event to be fired
	-- @table args - The arguments to be sent with the event
	-- [@number timeout - Seconds to wait for response]
	-- [@function timedout - The function that will be executed if timeout is reached]
	-- [@function callback - Asynchronous response]
	_G.TriggerClientCallback = function(args)
		ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

		-- create a new promise for this call
		local prom = promise.new()
		-- save the callback function on this call
		local eventCallback = args.callback
		-- save the event name on this call
		local eventName = args.eventName
		-- trigger the callback
		TriggerEvent('smp__client_callback:'..eventName, msgpack_pack(args.args or {}),
		function(packed)
			-- check if it was an async call
			-- & if the promise wasn't rejected or already resolved
			if eventCallback and prom.state == PENDING then eventCallback( table_unpack(msgpack_unpack(packed)) ) end
			prom:resolve( table_unpack(msgpack_unpack(packed)) )
		end)

		-- timeout response
		if args.timeout ~= nil and args.timedout then
			local timedout = args.timedout
			SetTimeout(args.timeout * 1000, function()
				-- check if the promise wasn't resolved
				if
					prom.state == PENDING or
					prom.state == REJECTED or
					prom.state == REJECTING
				then
					-- call timeout callback
					timedout(prom.state)
					-- check if it's pending and reject
					if prom.state == PENDING then prom:reject() end
				end
			end)
		end

		-- check if this call is async
		if not eventCallback then
			return Citizen.Await(prom)
		end
	end
end
 

if not IsDuplicityVersion() then
    TriggerEvent("SecureServe:Server:Loaded", -1)
end