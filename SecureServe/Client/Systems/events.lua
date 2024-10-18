
local function isWhitelisted(event_name)
    for _, whitelisted_event in ipairs(SecureServe.EventWhitelist) do
        if event_name == whitelisted_event then
            return true
        end
    end
    return false
end

exports('IsEventWhitelistedClient', LPH_NO_VIRTUALIZE(function(event_name)
    return isWhitelisted(event_name)
end))

exports('GetEventWhitelist', LPH_NO_VIRTUALIZE(function()
    return SecureServe.EventWhitelist
end))

exports('TriggeredEvent', function(event, time)
    if not time then print('banned', GetPlayerServerId(PlayerId())) end
    TriggerServerEvent('TriggerdServerEventCheck', event, time)
end)
