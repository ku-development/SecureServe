
initialize_blacklists_weapon = LPH_JIT_MAX(function()
    Citizen.CreateThread(function()
    while (true) do
     Wait(9000)

        local player = PlayerPedId()
        local weapon = GetSelectedPedWeapon(player)
        local weapon_name = nil

        for k,v in pairs(SecureServe.Protection.BlacklistedWeapons) do
            if (weapon == GetHashKey(v.name)) then
                RemoveWeaponFromPed(player, weapon)
            end
        end
    end
end)
end)
