
RegisterNetEvent('requestConfig', function()
    local src = source
    TriggerClientEvent('receiveConfig', src, SecureServe)
end)

GlobalState.SecureServe_events = math.random(1, 99999);

local function setTimeState()
    GlobalState.SecureServe = os.time()
end

Citizen.CreateThread(LPH_JIT_MAX(function()
    while true do
        setTimeState()  
        Citizen.Wait(760)
    end
end))

local playerStates = {}

RegisterNetEvent('playerLoaded', function()
    local src = source
    playerStates[src] = { loaded = true, loadTime = GetGameTimer() }
end)

local events = {}

RegisterNetEvent("TriggerdServerEventCheck", function(event, time)
    events[event] = time
end)

exports('CheckTime', function(event ,time, source)
    Wait(1000)
    local playerState = playerStates[source]
    if playerState and playerState.loaded then
        if events[event] == nil then
            Wait(500)
            if events[event] == nil then
                Wait(500)
                if events[event] == nil then
                    punish_player(source, "Trigger Event with an excutor ".. event, webhook, time)
                end
            end
        else
            local eventTime = events[event]
            local currentTime = time
            if not (math.abs(currentTime - eventTime) < 10) then
                if source and GetPlayerPing(source) > 0 then
                    punish_player(source, "Exceeded time stamp at trigger: ".. event .. " time: ".. currentTime - eventTime, webhook, time)
                    -- print("banned", event, "time", source, currentTime - eventTime)
                end
            end
        end
    end
end)



--> [EVENTS] <--
local function isWhitelisted(event_name)
    for _, whitelisted_event in ipairs(SecureServe.EventWhitelist) do
        if event_name == whitelisted_event then
            return true
        end
    end
    return false
end

exports('IsEventWhitelisted', LPH_NO_VIRTUALIZE(function(event_name)
    return isWhitelisted(event_name)
end))


RegisterNetEvent("serverwhitels", function (entity)
    TriggerClientEvent('addtowhitelist', -1, entity)
end)