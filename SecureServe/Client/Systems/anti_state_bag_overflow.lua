
initialize_protections_state_bag_overflow = LPH_JIT_MAX(function()
    AddStateBagChangeHandler(nil, nil, function(bagName, key, value) 
        if #key > 131072 then
            if Anti_State_Bag_Overflow_enabled then
                TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti State Bag Overflow", Anti_State_Bag_Overflow_webhook, Anti_State_Bag_Overflow_time)
            end
        end
    end)
end)