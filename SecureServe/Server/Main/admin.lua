
local admins = {}
AddEventHandler("txAdmin:events:adminAuth",function (data)
    if data.isAdmin then
        table.insert(admins, data.netid)
        admins[data.netid] = true
        print(('^7[^4 AUTH ^7] ✅ Admin [%s] %s (%s) has been authenticated using txAdmin!'):format(data.netid,GetPlayerName(data.netid),data.username))
    end
end)

Isadmin = function(pl)
    return SecureServe.IsAdmin(source) or admins[pl] == true
end

RegisterNetEvent("SecureServe:Server_Callbacks:Protections:IsAdmin2", function (player)
    TriggerClientEvent('isAdminResult', source, Isadmin(source))
end)

RegisterServerCallback {
    eventName = 'SecureServe:Server_Callbacks:Protections:IsAdmin',
    eventCallback = function(source)
        return SecureServe.IsAdmin(source)
    end
}