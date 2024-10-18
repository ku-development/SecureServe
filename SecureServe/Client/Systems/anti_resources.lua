
initialize_protections_resources = LPH_JIT_MAX(function()
    if Anti_Resource_Starter_enabled then
        AddEventHandler('onClientResourceStart', function(resourceName)
            TriggerServerCallback {
                eventName = 'SecureServe:Server_Callbacks:Protections:GetResourceStatus',
                args = {},
                callback = function(stoppedByServer, startedResources, restarted)
                    if not stoppedByServer and not startedResources and not restarted then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Start Resource ".. resourceName, Anti_Resource_Starter_webhook, Anti_Resource_Starter_time)
                    end
                end
                }
        end)
    end

    if Anti_Resource_Stopper_enabled then
        AddEventHandler('onClientResourceStop', function(resourceName)
            TriggerServerCallback {
            eventName = 'SecureServe:Server_Callbacks:Protections:GetResourceStatus',
            args = {},
            callback = function(stoppedByServer, startedResources, restarted)
                if not stoppedByServer and not restarted and not startedResources then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Stop Resource ".. resourceName, Anti_Resource_Stopper_webhook, Anti_Resource_Stopper_time)
                end
            end
            }
        end)
    end
end)