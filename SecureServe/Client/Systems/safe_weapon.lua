
initialize_protections_weapon = LPH_JIT_MAX(function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(3)
                local playerPed = PlayerPedId()
                local weapon = GetSelectedPedWeapon(playerPed)
                if weapon == GetHashKey('WEAPON_UNARMED') then
                    if IsPedShooting(playerPed) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Player tried to spawn a Safe Weapon with an Executor" .. weapon, webhook, time)
                        break
                    end
                else
                Citizen.Wait(10000)
            end
        end
    end)
end)