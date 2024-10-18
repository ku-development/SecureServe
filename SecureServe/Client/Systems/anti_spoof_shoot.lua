
initialize_protections_spoof_shot = LPH_JIT_MAX(function()
    AddEventHandler("gameEventTriggered", function(name, data)
        if name == "CEventNetworkEntityDamage" then
            local victim = data[1]
            local attacker = data[2]
            local hash = data[5]
            local dist = #(GetEntityCoords(victim) - GetEntityCoords(attacker))
            local weapon = GetSelectedPedWeapon(attacker)
            local ped = PlayerPedId()
            if hash ~= weapon and weapon == GetHashKey('WEAPON_UNARMED') and hash ~= GetHashKey('WEAPON_UNARMED') then
                if attacker == ped and not IsPedInAnyVehicle(ped, false) and not attacker == victim and IsPedStill(ped) then
                    if dist >= 10.0 then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Spoof shot", webhook, time)
                    end
                end
            end
        end
    end)
end)
