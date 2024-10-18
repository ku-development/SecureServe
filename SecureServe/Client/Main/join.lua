
local connected = false

function RandomKey(length)
    local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString = ""

    for i = 1, length do
        local randomIndex = math.random(1, #characters)
        randomString = randomString .. characters:sub(randomIndex, randomIndex)
    end

    return randomString
end

AddEventHandler('playerSpawned', function()
    if connected then return end
    connected = true
    TriggerServerEvent("playerSpawneda")
    TriggerEvent('allowed')
end)

TriggerServerEvent('mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS', RandomKey(math.random(15, 35)))

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10 * 1000)
        TriggerServerEvent('mMkHcvct3uIg04STT16I:cbnF2cR9ZTt8NmNx2jQS', RandomKey(math.random(15, 35)))
    end
end)