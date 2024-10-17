initialize_protections_entity_lockdown = function()
    Citizen.CreateThread(function ()
        SetConvar("sv_filterRequestControl", "4")
        SetConvar("sv_entityLockdown", SecureServe.EntityLockdownMode)
        SetConvar("onesync_distanceCullVehicles", "true")
    end)
end