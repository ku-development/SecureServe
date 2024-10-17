
AddEventHandler('weaponDamageEvent', function(sender, data)
    local getWeapon = data.weaponType
    if getWeapon == `WEAPON_STUNGUN` then
        TriggerClientEvent('SecureServe:checkTaze', sender)
    end
    end)