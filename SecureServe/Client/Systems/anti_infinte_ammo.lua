
initialize_protections_infinite_ammo = LPH_JIT_MAX(function()
    if Anti_Infinite_Ammo_enabled then
        Citizen.CreateThread(function()
            while (true) do
                Wait(5000)

                SetPedInfiniteAmmoClip(PlayerPedId(), false)
            end
        end)
    end
end)
