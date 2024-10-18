
local banned = {}
function getBanID()
    local banID = 0
    local data = getBanList()
    for id, _ in pairs(data) do
        banID = math.max(banID, id)
    end
    return banID + 1
end

function BetterPrint(text,type)
    local types = {
        ["error"] = "^7[^1 ERROR ^7] ",
        ["warning"] = "^7[^3 WARNING ^7] ",
        ["config"] = "^7[^3 CONFIG WARNING ^7] ",
        ["info"] = "^7[^5 INFO ^7] ",
        ["success"] = "^7[^2 SUCCESS ^7] ",
    }
    return print("^7[^5 SecureServe ^7] "..types[string.lower(type)]..text)
  end

function getBanList()
    local path = GetResourcePath(GetCurrentResourceName()) .. "/bans.json"
    local file = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    if not file then
        return {}
    end
    local decoded = json.decode(file)
    if not decoded then
        return {}
    end
    return decoded
end

RegisterNetEvent('banPlayerAntiCheat', function(player, reason, webhook, raw_time)
    punish_player(player, reason, webhook, raw_time)
end)

function punish_player(player, reason, webhook, raw_time)
if not banned[player] then

    if IsPlayerAceAllowed(player, 'bypass') then return end
    if GetPlayerPing(player) < 1 then
        print("Player " .. player .. " is not in the server.")
        return
    end

    if type(raw_time) ~= "number" then
        time = SecureServe.BanTimes[raw_time]
    end

    local name = GetPlayerName(player)
    local steam = GetPlayerIdentifierByType(player, "steam") or "none"
    local license = GetPlayerIdentifierByType(player, "license") or "none"
    local license2 = GetPlayerIdentifierByType(player, "license2") or "none"
    local discord = GetPlayerIdentifierByType(player, "discord") or "none"
    local xbl = GetPlayerIdentifierByType(player, "xbl") or "none"
    local liveid = GetPlayerIdentifierByType(player, "liveid") or "none"
    local ip = GetPlayerIdentifierByType(player, "ip") or "none"
    local hwid1 = GetPlayerToken(player, 1) or "none"
    local hwid2 = GetPlayerToken(player, 2) or "none"
    local hwid3 = GetPlayerToken(player, 3) or "none"
    local hwid4 = GetPlayerToken(player, 4) or "none"
    local hwid5 = GetPlayerToken(player, 5) or "none"
    
    local currentTimestamp = os.time()
    local date = tostring(os.date("%Y-%m-%d %H:%M:%S", currentTimestamp))
    local expire_date = tostring(os.date("%Y-%m-%d %H:%M:%S", (currentTimestamp + time)))

    local id = getBanID()
    local data = getBanList()

    BetterPrint(("Player ^3%s^7 has been banned for ^3%s^7"):format(name,reason),"info")
    TriggerClientEvent('SecureServe:Server:Methods:GetScreenShot', player, reason, id, webhook, time)
    banned[player] = true
    local ban_info = {
        id = id,
        name = name,
        reason = reason,
        steam = steam,
        license = license,
        license2 = license2,
        discord = discord,
        xbl = xbl,
        liveid = liveid,
        ip = ip,
        hwid1 = hwid1,
        hwid2 = hwid2,
        hwid3 = hwid3,
        hwid4 = hwid4,
        hwid5 = hwid5,
        expire = expire_date
    }

    data[#data + 1] = ban_info
    SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(data, { indent = true }), -1)


    if webhook == nil then webhook = "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0" end
    send_log(
        webhook,
        "Punished Player - " .. name,
        "Player/Punishment Information\n----------------------------------------------------------------------------\nPlayer Name: `" .. name ..
        "`\nTime: `" .. raw_time ..
        "`\nReason: `" .. reason ..
        "`\nSteam: `" .. steam or "none" ..
        "`\nIPV4: `" .. ip ..
        "`\nRockstar License: `" .. license or "none"..
        "`\nRockstar License 2: `" .. license2 or "none" ..
        "`\nXbox: `" .. xbl or "none" ..
        "`\nXbox Live: `" .. liveid or "none" ..
        "`\nDiscord: `" .. discord or "none" ..
        "`\nHWID 1: `" .. hwid1 or "none"..
        "`\nHWID 2: `" .. hwid2 or "none"..  
        "`\nHWID 3: `" .. hwid3 or "none".. 
        "`\nHWID 4: `" .. hwid4 or "none".. 
        "`\nHWID 5: `" .. hwid5 or "none".. "`"
    )

    if time == 2147483647 then
        send_log(
            "https://discord.com/api/webhooks/1237077520210329672/PvyzM9Vr43oT3BbvBeLLeS-BQnCV4wSUQDhbKBAXr9g9JcjshPCzQ7DL1pG8sgjIqpK0",
            "A player has been banned for " .. reason
        )
    end
end
end


RegisterNetEvent('SecureServe:Server:Methods:Upload', function (screenshot, reason, id, time)
    local playername = GetPlayerName(source)
    local punish = "ban"
    local banID = id

    local HWID = GetPlayerToken(source, 1)
    local HWID2 = GetPlayerToken(source, 2)
    local HWID3 = GetPlayerToken(source, 3)
    local HWID4 = GetPlayerToken(source, 4)
    local HWID5 = GetPlayerToken(source, 5)
    if HWID5 == nil then HWID5 = "Not Found" end
    if HWID4 == nil then HWID4 = "Not Found" end
    if HWID3 == nil then HWID3 = "Not Found" end
    if HWID2 == nil then HWID2 = "Not Found" end
    if HWID == nil then HWID = "Not Found" end

    local steam = "Not Found"
    local ip = "Not Found"
    local discord = "Not Found"
    local license = "Not Found"
    local fivem = "Not Found"

    for k, v in pairs(GetPlayerIdentifiers(source)) do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steam = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
        fivem = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      end
    end
    
    steam = steam:gsub('steam:', '')
    discord = discord:gsub('discord:', '')
    license = license:gsub('license:', '')
    fivem = fivem:gsub('fivem:', '')
    ip = ip:gsub('ip:', '')
    
    local requestPayload = json.encode({
        steamhex = steam,
        license = license,
        discord = discord,
        token = HWID 
    })


    ScreenshotLog({license=license,discord=discord,steam=steam,ip=ip,fivem=fivem,hwid=HWID,image=screenshot,playerId=tostring(source)}, reason, punish, banID)
    
    banned[source] = true
    if reason ~= 'External Executor Detected (Player Usally Has (SkriptGG, HX, TZX)' then
    DropPlayer(source, "You have been punished from " .. SecureServe.ServerName .. 
    ".\nTo view more information please reconnect to the server.")
    end
    banned[source] = nil
end)

RegisterNetEvent('TEST', function()
    print('tes')
end)



RegisterNetEvent("SecureServe:Server:Methods:PunishPlayer" .. GlobalState.SecureServe_events, function(player, reason, webhook, time)
    if not player then player = source end
    punish_player(player, reason, webhook, time)
end)
