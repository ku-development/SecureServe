
initialize_protections_no_recoil = LPH_JIT_MAX(function()
    local spawnTime = GetGameTimer()
    if Anti_No_Recoil_enabled then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(2500)

                local pid = PlayerPedId()
                local playerPed = GetPlayerPed(-1)
                local weapon_hash = GetSelectedPedWeapon(pid)
                local recoil = GetWeaponRecoilShakeAmplitude(weapon_hash)
                local focused = IsNuiFocused()

                local hasBeenSpawnedLongEnough = spawnTime and (GetGameTimer() - spawnTime) > 30000
                
                if hasBeenSpawnedLongEnough and weapon_hash and weapon_hash ~= GetHashKey("weapon_unarmed") and not IsPedInAnyVehicle(pid, false) then
                    if recoil <= 0.0 
                    and GetGameplayCamRelativePitch() == 0.0 
                    and playerPed ~= nil 
                    and weapon_hash ~= -1569615261 
                    and not focused 
                    and not IsPedArmed(playerPed, 1) 
                    and not IsPauseMenuActive() 
                    and IsPedShooting(playerPed) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti No Recoil", webhook, time)
                    end
                end
            end
        end)
    end
end)

