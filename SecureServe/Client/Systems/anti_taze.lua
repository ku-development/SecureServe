
RegisterNetEvent('SecureServe:checkTaze', function()
    if not HasPedGotWeapon(PlayerPedId(), `WEAPON_STUNGUN`, false) then
        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Tried To taze through menu", webhook, 2147483647)
    end
end)

AddEventHandler("gameEventTriggered", function(name, args)
    if name == 'CEventNetworkPlayerCollectedPickup' then
        CancelEvent()
    end
end)


