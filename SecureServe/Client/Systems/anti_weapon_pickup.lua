
initialize_protections_weapon_pickup = LPH_JIT_MAX(function()
    if Anti_Weapon_Pickup_enabled then
        Citizen.CreateThread(function()
            while (true) do
                Wait(1750)

                RemoveAllPickupsOfType(GetHashKey("PICKUP_ARMOUR_STANDARD"))
                RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_ARMOUR_STANDARD"))
                RemoveAllPickupsOfType(GetHashKey("PICKUP_HEALTH_SNACK"))
                RemoveAllPickupsOfType(GetHashKey("PICKUP_HEALTH_STANDARD"))
                RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_HEALTH_STANDARD"))
                RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW"))
            end
        end)
    end
end)