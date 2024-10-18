initialize_protections_afk_injection = LPH_JIT_MAX(function()
    if Anti_AFK_enabled then
        Citizen.CreateThread(function()
            while (true) do
                local pid = PlayerPedId()
                if (GetIsTaskActive(pid, 100))
                    or (GetIsTaskActive(pid, 101))
                    or (GetIsTaskActive(pid, 151))
                    or (GetIsTaskActive(pid, 221))
                    or (GetIsTaskActive(pid, 222)) then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti AFK Injection", webhook, time)
                end
                Wait(5000)
            end
        end)
    end
end)