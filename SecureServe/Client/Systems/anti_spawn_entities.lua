
--> [Methoods] <--
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}


local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = { handle = iter, destructor = disposeFunc }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetAllEnumerators()
    return { vehicles = EnumerateVehicles, objects = EnumerateObjects, peds = EnumeratePeds, pickups = EnumeratePickups }
end


local SafeGetEntityScript = LPH_NO_VIRTUALIZE(function (entity)
    local success, result = pcall(GetEntityScript, entity)
    
    if not success then
        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Created Suspicious Entity [Vehicle] with no script", webhook, time)
        return nil
    end
    
    if result then
        return result
    else
        return nil
    end
end)

initialize_protections_entity_security = LPH_NO_VIRTUALIZE(function()
    local entitySpawned = {}
    local entitySpawnedHashes = {}
    local whitelistedResources = {}

    for _, entry in ipairs(SecureServe.EntitySecurity) do
        whitelistedResources[entry.resource] = entry.whitelist
    end

    local function deleteAllObjects()
        for object in EnumerateObjects() do
            DeleteObject(object)
        end
    end

    RegisterNetEvent('entity2', function(hash)
        entitySpawnedHashes[hash] = true
        Wait(7500)
        entitySpawnedHashes[hash] = false
    end)

    RegisterNetEvent('entityCreatedByScriptClient', function(entity, resource)
        entitySpawned[entity] = true
    end)

    RegisterNetEvent("checkMe", function()
        Wait(450)
        for veh in EnumerateVehicles() do
            local pop = GetEntityPopulationType(veh)
            if not (pop == 0 or pop == 2 or pop == 4 or pop == 5 or pop == 6) then
                if not entitySpawned[veh] and not entitySpawnedHashes[GetEntityModel(veh)] and DoesEntityExist(veh) then
                    local script = SafeGetEntityScript(veh)
                    local isWhitelisted = whitelistedResources[script] or false 
                    if not isWhitelisted then
                        NetworkRegisterEntityAsNetworked(veh)
                        Citizen.Wait(100)
                        local creator = GetPlayerServerId(NetworkGetEntityOwner(veh))
                        if creator ~= 0 and creator == GetPlayerServerId(PlayerId()) and SafeGetEntityScript(veh) ~= '' and SafeGetEntityScript(veh) ~= ' ' and SafeGetEntityScript(veh) ~= nil then
                            TriggerServerEvent('clearall')
                            TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Created Suspicious Entity [Vehicle] at script: " .. script, webhook, time)
                            DeleteEntity(veh)
                        end
                    end
                end
            end
        end


        for ped in EnumeratePeds() do
            local pop = GetEntityPopulationType(ped)
            if not (pop == 0 or pop == 2 or pop == 4 or pop == 5 or pop == 6) then
                if not entitySpawned[ped] and not entitySpawnedHashes[GetEntityModel(ped)] and DoesEntityExist(ped) then
                    local script = SafeGetEntityScript(ped)
                    local isWhitelisted = whitelistedResources[script] or false 
                    local creator = GetPlayerServerId(NetworkGetEntityOwner(ped))
                    if not isWhitelisted and not IsPedAPlayer(ped) and creator == GetPlayerServerId(PlayerId()) and SafeGetEntityScript(ped) ~= '' and SafeGetEntityScript(ped) ~= ' ' and SafeGetEntityScript(ped) ~= nil then
                        if creator ~= 0 then
                            TriggerServerEvent('clearall')
                            TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Created Suspicious Entity [Ped]" .. script, webhook, time)
                            DeleteEntity(ped)
                        end
                    end
                end
            end
        end

        for object in EnumerateObjects() do
            local pop = GetEntityPopulationType(object)
            if not (pop == 0 or pop == 2 or pop == 4 or pop == 5 or pop == 6) then
                if not entitySpawned[object] and not entitySpawnedHashes[GetEntityModel(object)] and DoesEntityExist(object) then
                    local script = SafeGetEntityScript(object)
                    local isWhitelisted = whitelistedResources[script] or false 
                    if not isWhitelisted and SafeGetEntityScript(object) ~= 'ox_inventory' and DoesEntityExist(object) then
                        local creator = GetPlayerServerId(NetworkGetEntityOwner(object))
                        if creator ~= 0 and creator == GetPlayerServerId(PlayerId()) and SafeGetEntityScript(object) ~= '' and SafeGetEntityScript(object) ~= ' ' and SafeGetEntityScript(object) ~= nil then
                            TriggerServerEvent('clearall')
                            TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Created Suspicious Entity [Object] at script: " .. script, webhook, time)
                            DeleteEntity(object)
                            deleteAllObjects()
                        end
                    end
                end
            end
        end
    end)
end)
