
local spawnTime = nil

AddEventHandler('playerSpawned', function()
    spawnTime = GetGameTimer()
end)

initialize_protections_noclip = LPH_JIT_MAX(function()
    if Anti_Noclip_enabled then
        Citizen.CreateThread(function()
            local noclipwarns = 0
            while true do
                Wait(100)

                local ped = PlayerPedId()
                local posx, posy, posz = table.unpack(GetEntityCoords(ped, true))
                local still = IsPedStill(ped)
                local vel = GetEntitySpeed(ped)

                Wait(1500)

                local newx, newy, newz = table.unpack(GetEntityCoords(ped, true))
                local newPed = PlayerPedId()
                
                -- Check if the player has been spawned for more than 1 minute
                local hasBeenSpawnedLongEnough = spawnTime and (GetGameTimer() - spawnTime) > 60000

                if hasBeenSpawnedLongEnough and 
                    ((GetDistanceBetweenCoords(posx, posy, posz, newx, newy, newz) > 16) and
                    (still == IsPedStill(ped)) and
                    (vel == GetEntitySpeed(ped)) and
                    not (IsPedInParachuteFreeFall(ped)) and
                    not (IsPedJumpingOutOfVehicle(ped)) and
                    (ped == newPed)) and
                    not IsPedInVehicle(newPed) and
                    not IsPedJumping(newPed) and
                    not IsAdmin(GetPlayerServerId(PlayerId())) then
                    
                    if (not IsEntityAttached(ped) == 1 or not IsEntityAttached(ped) == true) and
                    not IsEntityPlayingAnim(ped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 3) and not IsEntityPlayingAnim(ped, 'amb@world_human_bum_slumped@male@laying_on_left_side@base', 'base', 3) and not IsEntityPlayingAnim(ped, 'nm', 'firemans_carry', 3) then
                        noclipwarns = noclipwarns + 1
                    end
                end
                if (noclipwarns > 12) then
                    noclipwarns = 0
                    if not IsAdmin(GetPlayerServerId(PlayerId())) then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Noclip", webhook, time)
                    end
                end
            end
        end)
    end
end)
