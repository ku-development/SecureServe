local isAdmin = false

function IsAdmin(player)

    TriggerServerEvent('SecureServe:Server_Callbacks:Protections:IsAdmin2', player)

    RegisterNetEvent('isAdminResult', function(result)
        isAdmin = result
    end)
    return isAdmin
end

function client_methods_notify(title, description)
    SendNUIMessage({
        type = 'notify',
        title = title,
        description = description
    })
end

RegisterNetEvent("SecureServe:Client:Methods:Notify")
AddEventHandler("SecureServe:Client:Methods:Notify", function(title, description)
    client_methods_notify(title, description)
end)

RegisterNetEvent('SecureServe:Server:Methods:GetScreenShot', function (reason, id, webhook, time)
    exports['screenshot-basic']:requestScreenshotUpload('https://canary.discord.com/api/webhooks/1237780232036155525/kUDGaCC8SRewCy5fC9iQpDFICxbqYgQS9Y7mj8EhRCv91nqpAyADkhaApGNHa3jZ9uMF', 'files[]', function(data)
        local dataa = {}
        local resp = json.decode(data)
        if resp ~= nil and resp.attachments ~= nil and resp.attachments[1] ~= nil and resp.attachments[1].proxy_url ~= nil then
            SCREENSHOT_URL = resp.attachments[1].proxy_url
            dataa.image = SCREENSHOT_URL
            TriggerServerEvent('SecureServe:Server:Methods:Upload', SCREENSHOT_URL, reason, id, webhook, time)
            if time ~= 0  then ForceSocialClubUpdate() end
        else
            TriggerServerEvent('SecureServe:Server:Methods:Upload', "https://media.discordapp.net/attachments/1234504751173865595/1237372961263190106/screenshot.jpg?ex=663b68df&is=663a175f&hm=52ec8f2d1e6e012e7a8282674b7decbd32344d85ba57577b12a136d34469ee9a&=&format=webp&width=810&height=456", reason, id, time)
            if time ~= 0  then ForceSocialClubUpdate() end
        end
    end)
end)