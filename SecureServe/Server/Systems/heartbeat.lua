local alive = {}
local allowedStop = {}
local failureCount = {}

-- Configuration
local checkInterval = 5000  -- Time between each check cycle (15 seconds)
local maxFailures = 40     -- Number of consecutive failures before dropping the player

Citizen.CreateThread(LPH_NO_VIRTUALIZE(function()
    while true do
        local players = GetPlayers()
        for _, playerId in ipairs(players) do
            alive[tonumber(playerId)] = false
            TriggerClientEvent('checkalive', tonumber(playerId))
        end

        Wait(checkInterval)

        for _, playerId in ipairs(players) do
            if not alive[tonumber(playerId)] and allowedStop[tonumber(playerId)] then
                failureCount[tonumber(playerId)] = (failureCount[tonumber(playerId)] or 0) + 1
                if failureCount[tonumber(playerId)] >= maxFailures then
                    punish_player(tonumber(playerId), 'You have been dropped for not responding to the server.', webhook, time)
                end
            else
                failureCount[tonumber(playerId)] = 0
            end
        end
    end
end))

RegisterNetEvent('addalive', LPH_NO_VIRTUALIZE(function()
    local src = source
    alive[tonumber(src)] = true
end))

RegisterNetEvent('allowedStop', LPH_NO_VIRTUALIZE(function()
    local src = source
    allowedStop[src] = true
end))

AddEventHandler('playerDropped', function()
    local src = source
    alive[src] = nil
    allowedStop[src] = nil
    failureCount[src] = nil
end)



local playerHeartbeats = {}

local function onPlayerDisconnected()
    local playerId = source
    playerHeartbeats[playerId] = nil
end
AddEventHandler("playerDropped", onPlayerDisconnected)

RegisterNetEvent("mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS", function(key)
    local playerId = source
    if string.len(key) < 15 or string.len(key) > 35 or key == nil then
        punish_player(playerId, "Tried to stop the anticheat", webhook, -1)
    else
        playerHeartbeats[playerId] = os.time()
    end
end)

Citizen.CreateThread(LPH_JIT_MAX(function()
    while true do
        Citizen.Wait(10 * 1000)
        for playerId, lastHeartbeatTime in pairs(playerHeartbeats) do
            if lastHeartbeatTime == nil then return end
            local currentTime = os.time()
            local timeSinceLastHeartbeat = currentTime - lastHeartbeatTime
            if timeSinceLastHeartbeat > 15 * 1000 then
                BetterPrint(
                    ("Player [%s] %s didn't sent any heartbeat to the server in required time. Last response: %s seconds ago")
                    :format(playerId, GetPlayerName(playerId), timeSinceLastHeartbeat), "info")
                punish_player(playerId, "Tried to stop the anticheat", webhook, -1)
                playerHeartbeats[playerId] = nil
            end
        end
    end
end))



