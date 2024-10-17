

initialize_server_protections_anti_resource = LPH_JIT_MAX(function()
    local stoppedResources = {}
    local startedResources = {}
    local restarted = {}
    local restarteda = false
    AddEventHandler('onResourceStart', function(resourceName)
        stoppedResources[resourceName] = nil
        startedResources[resourceName] = true
    end)

    AddEventHandler('onResourceStop', function(resourceName)
        stoppedResources[resourceName] = true
        startedResources[resourceName] = nil
    end)
    
    RegisterServerCallback {
        eventName = 'SecureServe:Server_Callbacks:Protections:GetResourceStatus',
        eventCallback = function(source, resourceName)
            Wait(1000)
            if stoppedResources[resourceName] == startedResources[resourceName] then
                restarteda = true
            else
                restarteda = false
            end
            return stoppedResources[resourceName], startedResources[resourceName], restarteda
        end
    }
end)
