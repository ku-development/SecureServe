AddEventHandler('entityCreating', function(entity)
    local model
    local owner
    local entityType
  
    if not DoesEntityExist(entity) then
      CancelEvent()
      return
    end
  
    if DoesEntityExist(entity) then
      model = GetEntityModel(entity)
      entityType = GetEntityType(entity)
      owner = NetworkGetEntityOwner(entity)
    end
    if entityType == 2 and DoesEntityExist(entity) then
        local src = NetworkGetEntityOwner(entity)
        local entityPopulationType = GetEntityPopulationType(entity)
    
        if src == nil or owner == nil then
          CancelEvent()
        end

        for k, v in pairs(SecureServe.Protection.BlacklistedVehicles) do
            if model == GetHashKey(v.name) then
                    punish_player(source, "Blacklisted Vehicle (" .. v.name .. ")", webhook, time)
            CancelEvent()
            end
        end
    end
end)  