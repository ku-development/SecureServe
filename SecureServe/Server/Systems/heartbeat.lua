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