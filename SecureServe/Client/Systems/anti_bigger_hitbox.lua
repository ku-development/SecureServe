
initialize_protections_bigger_hitbox = LPH_JIT_MAX(function()
    if Anti_Bigger_Hitbox_enabled then
        Citizen.CreateThread(function()
            while (true) do
                local id = PlayerPedId()
                local ped = GetEntityModel(id)

                if (ped == GetHashKey('mp_m_freemode_01') or ped == GetHashKey('mp_f_freemode_01')) then
                    local min, max = GetModelDimensions(ped)
                    if (min.x > -0.58)
                        or (min.x < -0.62)
                        or (min.y < -0.252)
                        or (min.y < -0.29)
                        or (max.z > 0.98) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Bigger Hit Box", webhook,
                            time)
                    end
                end

                Wait(15000)
            end
        end)
    end
end)