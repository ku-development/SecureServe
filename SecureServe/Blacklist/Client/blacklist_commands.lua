initialize_blacklists_commands = LPH_JIT_MAX(function()
    Citizen.CreateThread(function()
        while (true) do
            local registered_commands = GetRegisteredCommands()
            for _, k in pairs(SecureServe.Protection.BlacklistedCommands) do
                for _, v in pairs(registered_commands) do
                    if k.command == v.name then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Blacklisted Command (" .. k.command .. ")", webhook, time)
                    end
                end
            end
            
            Citizen.Wait(7500)
        end
    end)
end)