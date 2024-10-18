
RegisterNetEvent('clearall', function()
    for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
    end
    for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
    end
    for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
    end
end)

function clear()
    for i, obj in pairs(GetAllObjects()) do
        DeleteEntity(obj)
    end
    for i, ped in pairs(GetAllPeds()) do
        DeleteEntity(ped)
    end
    for i, veh in pairs(GetAllVehicles()) do
        DeleteEntity(veh)
    end
end

initialize_protections_entity_spam = LPH_JIT_MAX(function()
    local SV_VEHICLES = {}
    local SV_PEDS = {}
    local SV_OBJECT = {}
    local SV_Userver = {}


    AddEventHandler('entityCreated', function (entity)
        if DoesEntityExist(entity) then
            local POPULATION = GetEntityPopulationType(entity)
            if POPULATION == 7 or POPULATION == 0 then
                TriggerClientEvent('checkMe', -1)
            end
        end
    end)

    AddEventHandler("entityCreated", function(ENTITY)
        if DoesEntityExist(ENTITY) then
            local TYPE       = GetEntityType(ENTITY)
            local OWNER      = NetworkGetFirstEntityOwner(ENTITY)
            local POPULATION = GetEntityPopulationType(ENTITY)
            local MODEL      = GetEntityModel(ENTITY)
            local HWID       = GetPlayerToken(OWNER, 0)
            if TYPE == 2 and POPULATION == 7 then
                if SV_VEHICLES[HWID] ~= nil then
                    SV_VEHICLES[HWID].COUNT = SV_VEHICLES[HWID].COUNT + 1
                    if os.time() - SV_VEHICLES[HWID].TIME >= 10 then
                        SV_VEHICLES[HWID] = nil
                    else
                        if SV_VEHICLES[HWID].COUNT >= SecureServe.maxVehicle then
                            for _, vehilce in ipairs(GetAllVehicles()) do
                                local ENO = NetworkGetFirstEntityOwner(vehilce)
                                if ENO == OWNER then
                                    if DoesEntityExist(vehilce) then
                                        DeleteEntity(vehilce)
                                    end
                                end
                            end
                            if not SV_Userver[HWID] then
                            SV_Userver[HWID] = true
                                clear()
                                punish_player(OWNER, "Try To Spam Vehicles: ".. SV_VEHICLES[HWID].COUNT, webhook, time)
                                CancelEvent()
                            end
                        end
                    end
                else
                    SV_VEHICLES[HWID] = {
                        COUNT = 1,
                        TIME  = os.time()
                    }
                end
            elseif TYPE == 1 and POPULATION == 7 then
                if SV_PEDS[HWID] ~= nil then
                    SV_PEDS[HWID].COUNT = SV_PEDS[HWID].COUNT + 1
                    if os.time() - SV_PEDS[HWID].TIME >= 10 then
                        SV_PEDS[HWID] = nil
                    else
                        for _, peds in ipairs(GetAllPeds()) do
                            local ENO = NetworkGetFirstEntityOwner(peds)
                            if ENO == OWNER then
                                if DoesEntityExist(peds) then
                                    DeleteEntity(peds)
                                end
                            end
                        end
                        if SV_PEDS[HWID].COUNT >= SecureServe.maxPed then
                            if not SV_Userver[HWID] then
                            clear()
                            punish_player(OWNER, "Try To Spam Peds: ".. SV_PEDS[HWID].COUNT, webhook, time)
                            CancelEvent()
                            SV_Userver[HWID] = true
                            end
                        end
                    end
                else
                    SV_PEDS[HWID] = {
                        COUNT = 1,
                        TIME  = os.time()
                    }
                    
                end
            elseif TYPE == 3 and POPULATION == 7 then
                HandleAntiSpamObjects(HWID, OWNER)
            end
        end
    end)

    local COOLDOWN_TIME = 10
    function HandleAntiSpamObjects(HWID, OWNER)
    
        if SV_OBJECT[HWID] ~= nil then
            SV_OBJECT[HWID].COUNT = SV_OBJECT[HWID].COUNT + 1
            if os.time() - SV_OBJECT[HWID].TIME >= COOLDOWN_TIME then
                SV_OBJECT[HWID] = nil
            else
                if SV_OBJECT[HWID].COUNT >= SecureServe.maxObject then
                    for _, objects in ipairs(GetAllObjects()) do
                        local ENO = NetworkGetFirstEntityOwner(objects)
                        if ENO == OWNER and DoesEntityExist(objects) then
                            DeleteEntity(objects)
                        end
                    end
                    if not SV_Userver[HWID] then
                        SV_Userver[HWID] = true
                        clear()
                        punish_player(OWNER, "Try To Spam Objects: ".. SV_OBJECT[HWID].COUNT, webhook, time)
                        CancelEvent()
                    end
                end
            end
        else
            SV_OBJECT[HWID] = {
                COUNT = 1,
                TIME = os.time()
            }
        end
    end
    ECount = {}
end)

RegisterNetEvent("serverwhitels", function (entity)
    TriggerClientEvent('addtowhitelist', -1, entity)
end)

initialize_protections_explosions = LPH_JIT_MAX(function()
    local explosions = {}
    local detected = {}
    local false_explosions = {
        [11] = true,
        [12] = true,
        [13] = true,
        [24] = true,
        [30] = true,
    }

    AddEventHandler('explosionEvent', function(sender, ev)
        explosions[sender] = explosions[sender] or {}

        for k, v in pairs(SecureServe.Protection.BlacklistedExplosions) do
            if ev.explosionType == v.id then
                local explosionInfo = string.format("Explosion Type: %d, Position: (%.2f, %.2f, %.2f)", ev.explosionType, ev.posX, ev.posY, ev.posZ)

                if v.limit and explosions[sender][v.id] and explosions[sender][v.id] >= v.limit then
                    punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                explosions[sender][v.id] = (explosions[sender][v.id] or 0) + 1

                if v.limit and explosions[sender][v.id] > v.limit then
                    punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.limit then
                    if explosions[sender][v.id] > v.limit then
                        if false_explosions[ev.explosionType] then return end
                        if not detected[sender] then
                            detected[sender] = true
                            CancelEvent()
                            punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                        end
                    end
                end

                if v.audio and ev.isAudible == false then
                    punish_player(sender, "Used inaudible explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.invisible and ev.isInvisible == true then
                    punish_player(sender, "Used invisible explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.damageScale and ev.damageScale > 1.0 then
                    punish_player(sender, "Used boosted explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if SecureServe.Protection.CancelOtherExplosions then
                    for k, v in pairs(SecureServe.Protection.BlacklistedExplosions) do
                        if ev.explosionType ~= v.id then
                            CancelEvent()
                        end
                    end
                end
            end
        end

        if ev.ownerNetId == 0 then
            CancelEvent()
        end
    end)

    AddEventHandler('explosionEvent', function(sender, ev)
        if ev.explosionType == 7 then
            local checkRadius = 27.0 

            local explosionCoords = vector3(ev.posX, ev.posY, ev.posZ)
            local sourcePlayer = sender
            local playerCoords = GetEntityCoords(GetPlayerPed(sourcePlayer))

            local distanceToPlayer = #(explosionCoords - playerCoords)

            if distanceToPlayer > checkRadius then
                punish_player(sourcePlayer, "Banned for causing an explosion with no vehicle present and being too far from the explosion. [Beta please report false bans]")
            end
        end
    end)
end)

AddEventHandler('entityCreating', function(entity)
    local model
    local owner
    local entityType

    if not DoesEntityExist(entity) then
        CancelEvent()
        return
    end

    if DoesEntityExist(entity) then
        model = GetEntityModel(entity)
        entityType = GetEntityType(entity)
        owner = NetworkGetEntityOwner(entity)
    end
    if entityType == 3 then
        for _, player in pairs(GetPlayers()) do
            local playerPed = GetPlayerPed(player)
            local playerCoords = GetEntityCoords(playerPed)
            local entityCoords = GetEntityCoords(entity)
            local distance = #(playerCoords - entityCoords)

            if distance < 5 then
                CancelEvent()
            end
        end
    end
end)