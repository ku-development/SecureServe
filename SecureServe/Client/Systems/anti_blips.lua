

initialize_protections_player_blips = LPH_JIT_MAX(function()
    if Anti_Player_Blips_enabled then
        Citizen.CreateThread(function()
            while (true) do
                local pid = PlayerId()
                local active_players = GetActivePlayers()

                for i = 1, #active_players do
                    if i ~= pid then
                        local player_ped = GetPlayerPed(i)
                        local blip = GetBlipFromEntity(player_ped)

                        if DoesBlipExist(blip) then
                            if not IsAdmin(GetPlayerServerId(PlayerId())) then
                                TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Player Blips", webhook, time)
                            end
                        end
                    end
                end

                Citizen.Wait(15000)
            end
        end)
    end
end)
