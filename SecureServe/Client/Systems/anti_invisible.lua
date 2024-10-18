initialize_protections_invisible = LPH_JIT_MAX(function()
    if Anti_Invisible_enabled then
        local warns = 0
        Citizen.CreateThread(function()
            while (true) do
                local ped = PlayerPedId()
                if GetGameTimer() - 120000  > 0 then
                    if (not IsEntityVisible(ped) and not IsEntityVisibleToScript(ped))
                    or (GetEntityAlpha(ped) <= 150 and GetEntityAlpha(ped) ~= 0) then
                        SetEntityVisible(GetPlayerPed(-1), true, false)
                        warns = warns + 1
                        if not IsAdmin(GetPlayerServerId(PlayerId())) and warns > 3 then
                            TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Invisibility", webhook, time)
                        end
                    end
                end
    
                Citizen.Wait(1500)
            end
        end)
    end
end)
