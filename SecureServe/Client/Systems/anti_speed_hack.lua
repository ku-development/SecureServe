
initialize_protections_speed_hack = LPH_JIT_MAX(function()
    if Anti_Speed_Hack_enabled then
        Citizen.CreateThread(function()
            while (true) do
                Wait(2750)

                local ped = PlayerPedId()
                if (IsPedInAnyVehicle(ped, false)) then
                    local vehicle = GetVehiclePedIsIn(ped, 0)
                    if (GetVehicleTopSpeedModifier(vehicle) > -1.0) then
                        if GetVehiclePedIsIn(GetPlayerPed(-1), false) then return end

                        DeleteEntity(vehicle)
                        if not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedFalling(PlayerPedId()) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Speed Hack", webhook, time)
                        end
                    end

                    SetVehicleTyresCanBurst(vehicle, true)
                    SetEntityInvincible(vehicle, false)
                end
            end
        end)
    end
end)