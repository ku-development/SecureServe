
send_log = LPH_JIT_MAX(function(webhook, title, message)
    local embed = {
        {
            ["color"] = "3447003",
            ["title"] = "SecureServe | " .. title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = "SecureServe | Secure Your Server Now",
                ["icon_url"] = "https://images-ext-1.discordapp.net/external/ATCidz-Uio1fj26KQZH1mmy20YnxQxQxv-sc0gBFGFw/%3Fformat%3Dwebp%26quality%3Dlossless/https/images-ext-1.discordapp.net/external/z9bSkH3p8iTlOClfnK7zVOEC9i5xcORJZfsuqlcf1XA/https/cdn.discordapp.com/icons/814390233898156063/c959fc0889d2436b87ccbf2f73d4f30e.png?format=webp&quality=lossless"
            },
        }
    }
    
    PerformHttpRequest(webhook, function(error, text, footer) end, "POST", json.encode({username = "SecureServe | Logging System", avatar_url = "https://images-ext-1.discordapp.net/external/ATCidz-Uio1fj26KQZH1mmy20YnxQxQxv-sc0gBFGFw/%3Fformat%3Dwebp%26quality%3Dlossless/https/images-ext-1.discordapp.net/external/z9bSkH3p8iTlOClfnK7zVOEC9i5xcORJZfsuqlcf1XA/https/cdn.discordapp.com/icons/814390233898156063/c959fc0889d2436b87ccbf2f73d4f30e.png?format=webp&quality=lossless", embeds = embed}), {["Content-Type"] = "application/json"})
end)

function ScreenshotLog(data, reason, punishment, banId, webhook)
  local steam = data.steam
  local discord = data.discord
  local license = data.license
  local ip = data.ip
  local HWID = data.hwid
  local playerId = data.playerId
  local steamDec = tonumber(steam:gsub("steam:", ""), 16)
  local steamprofile = steam == "Not Found" and "Steam profile not found" or ("[Steam Profile](https://steamcommunity.com/profiles/%s)"):format(steamDec)
  local discordping = "<@" .. discord:gsub('discord:', '') .. "> (".. discord:gsub('discord:', '') .. ")"

  local embed = {
      {
          color = 38880, 
          author = {
              name = "SecureServe Logs",
              icon_url = "https://images-ext-1.discordapp.net/external/ATCidz-Uio1fj26KQZH1mmy20YnxQxQxv-sc0gBFGFw/%3Fformat%3Dwebp%26quality%3Dlossless/https/images-ext-1.discordapp.net/external/z9bSkH3p8iTlOClfnK7zVOEC9i5xcORJZfsuqlcf1XA/https/cdn.discordapp.com/icons/814390233898156063/c959fc0889d2436b87ccbf2f73d4f30e.png?format=webp&quality=lossless"
          },
          title = "Player Detected",
          description = ("**Punishment Method:** %s\n**Reason:** %s\n**Ban ID:** %s"):format(punishment, reason, banId),
          fields = {
              { name = "Player", value = "[#" .. playerId .. "] " .. GetPlayerName(playerId), inline = true },
              { name = "Discord", value = discordping, inline = true },
              { name = "Steam", value = steamprofile, inline = true },
              { name = "License", value = license or "N/A", inline = true },
              { name = "HWID", value = HWID or "N/A", inline = true },
              { name = "IP Address", value = ("[Info](https://ipinfo.io/%s)"):format(ip:gsub('ip:', '')), inline = true },
          },
          image = { url = data.image },
          footer = {
              text = "SecureServe Anticheat - " .. os.date('%d.%m.%Y - %H:%M:%S'),
              icon_url = "https://images-ext-1.discordapp.net/external/ATCidz-Uio1fj26KQZH1mmy20YnxQxQxv-sc0gBFGFw/%3Fformat%3Dwebp%26quality%3Dlossless/https/images-ext-1.discordapp.net/external/z9bSkH3p8iTlOClfnK7zVOEC9i5xcORJZfsuqlcf1XA/https/cdn.discordapp.com/icons/814390233898156063/c959fc0889d2436b87ccbf2f73d4f30e.png?format=webp&quality=lossless"
          }
      }
  }

  PerformHttpRequest(SecureServe.Webhooks.Simple, function(err, text, headers) end, 'POST', json.encode({ username = "SecureServe Logs", avatar_url = "https://images-ext-1.discordapp.net/external/ATCidz-Uio1fj26KQZH1mmy20YnxQxQxv-sc0gBFGFw/%3Fformat%3Dwebp%26quality%3Dlossless/https/images-ext-1.discordapp.net/external/z9bSkH3p8iTlOClfnK7zVOEC9i5xcORJZfsuqlcf1XA/https/cdn.discordapp.com/icons/814390233898156063/c959fc0889d2436b87ccbf2f73d4f30e.png?format=webp&quality=lossless", embeds = embed }), { ['Content-Type'] = 'application/json' })
end
