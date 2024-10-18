
initialize_protections_god_mode = LPH_JIT_MAX(function()
    local playerSpawnTime = GetGameTimer()

    local function HasPlayerSpawnedLongerThan(seconds)
        local currentTime = GetGameTimer()
        return (currentTime - playerSpawnTime) > (seconds * 1000)
    end
    if Anti_God_Mode_enabled and not IsAdmin(GetPlayerServerId(PlayerId())) then
        local playerFlags = 0
        AddEventHandler("gameEventTriggered", function(name, data)
            if name == "CEventNetworkEntityDamage" then
                local victim = data[1]
                local attacker = data[2]
                local victimHealth = GetEntityHealth(victim)
                if attacker == -1 and (victimHealth == 199 or victimHealth == 0 and not IsPedDeadOrDying(victim)) and victim == PlayerPedId() and not IsAdmin(GetPlayerServerId(PlayerId())) then
                    playerFlags += 1
                    if playerFlags >= 15 then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Semi Godmode [Semi goddmode]", webhook, time)
                    end
                end
            end
        end)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(5000)

                local curPed = PlayerPedId()

                if not IsAdmin(GetPlayerServerId(PlayerId())) and not IsNuiFocused() and HasPlayerSpawnedLongerThan(50) then
                    if GetPlayerInvincible_2(PlayerId()) and not IsEntityVisible(curPed) and not IsEntityVisibleToScript(curPed) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Godmode", webhook, time)
                    end
                end

                if GetEntityModel(curPed) == `mp_m_freemode_01` then
                    if GetEntityHealth(curPed) > 200 then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Godmode [Health]", webhook, time)
                    end
                end

                if GetEntityModel(curPed) == `mp_f_freemode_01` then
                    if GetEntityHealth(curPed) > 100 then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Godmode [Health]", webhook, time)
                    end
                end

                if GetPedArmour(curPed) > 100 then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Godmode [Armour]", webhook, time)
                end

                local _, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof = GetEntityProofs(curPed)
                if bulletProof == 1
                    and fireProof == 1
                    and explosionProof == 1
                    and collisionProof == 1
                    and meleeProof == 1
                    and steamProof == 1
                    and p7 == 1
                    and drownProof == 1
                then
                    -- TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Triggered Protection Godmode [Proofs]", webhook, time)
                end
            end
        end)
    end
end)