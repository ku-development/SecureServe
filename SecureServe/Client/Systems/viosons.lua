
initialize_protections_visions = LPH_JIT_MAX(function()
    if not Anti_Thermal_Vision_enabled and not Anti_Night_Vision_enabled then return end
    Citizen.CreateThread(function()
        while (true) do
            Wait(6500)
            if Anti_Thermal_Vision_enabled then
                if (GetUsingseethrough()) then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Thermal Vision", webhook, time)
                end
            end
            if Anti_Night_Vision_enabled then
                if (GetUsingnightvision()) then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Night Vision", webhook, time)
                end
            end
        end
    end)
end)