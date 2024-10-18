
initialize_protections_no_reload = LPH_NO_VIRTUALIZE(function()
    if Anti_No_Reload_enabled then
        Citizen.CreateThread(function()
            local lastAmmoCount = nil
            local lastWeapon = nil
            local warns = 0
            local playerPed = PlayerPedId()
        
            while true do
                Citizen.Wait(0)
                local weaponHash = GetSelectedPedWeapon(playerPed)
                local weaponGroup = GetWeapontypeGroup(weaponHash)
        
                -- Check if player is unarmed
                if weaponHash == `WEAPON_UNARMED` then
                    Citizen.Wait(2500)
                else
                    -- Only proceed if the weapon is not a melee weapon and is ready to shoot
                    if weaponGroup ~= `WEAPON_GROUP_MELEE` and IsPedWeaponReadyToShoot(playerPed) then
                        if IsPedShooting(playerPed) then
                            local currentAmmoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
                            
                            if lastAmmoCount and lastAmmoCount == currentAmmoCount then
                                warns = warns + 1
                                if warns > 7 then
                                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Player tried to NoReload/infinite ammo", webhook, time)
                                end
                            end
        
                            lastAmmoCount = currentAmmoCount
                            lastWeapon = weaponHash
                        end
        
                        if lastWeapon and GetAmmoInClip(playerPed, lastWeapon) == 0 then
                            Citizen.Wait(2000)
        
                            local currentAmmoCount = GetAmmoInPedWeapon(playerPed, lastWeapon)
                            if lastAmmoCount and lastAmmoCount == currentAmmoCount then
                                TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Player tried to No Reload", webhook, time)
                            end
        
                            lastAmmoCount = nil
                            lastWeapon = nil
                        end
                    else
                        -- Reset if weapon is melee or not ready to shoot
                        lastAmmoCount = nil
                        lastWeapon = nil
                        warns = 0
                    end
                end
            end
        end)
        
    end
end)