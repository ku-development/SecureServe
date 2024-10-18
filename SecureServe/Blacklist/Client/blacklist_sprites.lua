initialize_blacklists_sprites = LPH_JIT_MAX(function()
    Citizen.CreateThread(function()
        while (true) do
            for k,v in pairs(SecureServe.Protection.BlacklistedSprites) do
                if HasStreamedTextureDictLoaded(v.sprite) then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Blacklisted Sprite (" .. v.name .. ")", webhook, time)
                end
            end

            Citizen.Wait(5500)
        end
    end)
end)