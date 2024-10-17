
local playerProximitySpawns = {}
local proximityThreshold = 10.0 -- Distance in meters to consider an entity spawn "near" a player
local timeWindow = 60000 -- 60 seconds
local maxProximitySpawns = 15 -- Maximum allowed nearby spawns within the time window
local cooldownPeriod = 1000 -- 1 second cooldown between allowed spawns

local function initializePlayerData(playerId)
    playerProximitySpawns[playerId] = {
        spawns = {},
        lastSpawnTime = 0
    }
end

local function isEntityNearAnyPlayer(entity)
    local entityCoords = GetEntityCoords(entity)
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - entityCoords)
        if distance <= proximityThreshold then
            return true, playerId
        end
    end
    return false, nil
end

local function updateProximitySpawns(playerId, currentTime)
    local playerData = playerProximitySpawns[playerId]
    
    -- Remove old spawn entries
    for i = #playerData.spawns, 1, -1 do
        if currentTime - playerData.spawns[i] > timeWindow then
            table.remove(playerData.spawns, i)
        else
            break -- Assuming spawns are stored in chronological order
        end
    end
    
    -- Add new spawn
    table.insert(playerData.spawns, currentTime)
    
    return #playerData.spawns
end

AddEventHandler('entityCreating', function(entity)
    local ownerPlayerId = NetworkGetEntityOwner(entity)
    local isNearPlayer, nearestPlayerId = isEntityNearAnyPlayer(entity)
    
    if isNearPlayer then
        if not playerProximitySpawns[ownerPlayerId] then
            initializePlayerData(ownerPlayerId)
        end

        local playerData = playerProximitySpawns[ownerPlayerId]
        local currentTime = GetGameTimer()

        if currentTime - playerData.lastSpawnTime < cooldownPeriod then
            CancelEvent()
            print(ownerPlayerId, "Entity spawning too quickly near players", 'this is a beta funciton please update us if its not working corretely')
            return
        end

        local proximitySpawnCount = updateProximitySpawns(ownerPlayerId, currentTime)

        if proximitySpawnCount > maxProximitySpawns then
            CancelEvent()
            print(ownerPlayerId, "Excessive entity spawning near players detected: " .. proximitySpawnCount .. " spawns in " .. timeWindow/1000 .. " seconds", 'this is a beta funciton please update us if its not working corretely')
            return
        end

        playerData.lastSpawnTime = currentTime

        if proximitySpawnCount == maxProximitySpawns - 3 then
            print(ownerPlayerId, "You are approaching the entity spawn limit near players", 'this is a beta funciton please update us if its not working corretely')
        end

        if nearestPlayerId ~= ownerPlayerId then
            print(nearestPlayerId, "An entity was spawned near you by another player", 'this is a beta funciton please update us if its not working corretely')
        end
    end
end)


AddEventHandler('playerDropped', function()
    local playerId = source
    playerProximitySpawns[playerId] = nil
end)
