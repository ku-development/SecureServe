
initialize_protections_explosions = LPH_JIT_MAX(function()
    local explosions = {}
    local detected = {}
    local false_explosions = {
        [11] = true,
        [12] = true,
        [13] = true,
        [24] = true,
        [30] = true,
    }

    AddEventHandler('explosionEvent', function(sender, ev)
        explosions[sender] = explosions[sender] or {}

        for k, v in pairs(SecureServe.Protection.BlacklistedExplosions) do
            if ev.explosionType == v.id then
                local explosionInfo = string.format("Explosion Type: %d, Position: (%.2f, %.2f, %.2f)", ev.explosionType, ev.posX, ev.posY, ev.posZ)

                if v.limit and explosions[sender][v.id] and explosions[sender][v.id] >= v.limit then
                    punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                explosions[sender][v.id] = (explosions[sender][v.id] or 0) + 1

                if v.limit and explosions[sender][v.id] > v.limit then
                    punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.limit then
                    if explosions[sender][v.id] > v.limit then
                        if false_explosions[ev.explosionType] then return end
                        if not detected[sender] then
                            detected[sender] = true
                            CancelEvent()
                            punish_player(sender, "Exceeded explosion limit at explosion: " .. v.id .. ". " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                        end
                    end
                end

                if v.audio and ev.isAudible == false then
                    punish_player(sender, "Used inaudible explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.invisible and ev.isInvisible == true then
                    punish_player(sender, "Used invisible explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if v.damageScale and ev.damageScale > 1.0 then
                    punish_player(sender, "Used boosted explosion. " .. explosionInfo, v.webhook or SecureServe.Webhooks.BlacklistedExplosions or "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0", v.time)
                    return
                end

                if SecureServe.Protection.CancelOtherExplosions then
                    for k, v in pairs(SecureServe.Protection.BlacklistedExplosions) do
                        if ev.explosionType ~= v.id then
                            CancelEvent()
                        end
                    end
                end
            end
        end

        if ev.ownerNetId == 0 then
            CancelEvent()
        end
    end)

    AddEventHandler('explosionEvent', function(sender, ev)
        if ev.explosionType == 7 then
            local checkRadius = 27.0 

            local explosionCoords = vector3(ev.posX, ev.posY, ev.posZ)
            local sourcePlayer = sender
            local playerCoords = GetEntityCoords(GetPlayerPed(sourcePlayer))

            local distanceToPlayer = #(explosionCoords - playerCoords)

            if distanceToPlayer > checkRadius then
                punish_player(sourcePlayer, "Banned for causing an explosion with no vehicle present and being too far from the explosion. [Beta please report false bans]")
            end
        end
    end)
end)
