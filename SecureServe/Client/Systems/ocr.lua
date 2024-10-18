

initialize_ocr = LPH_NO_VIRTUALIZE(function()
    local isBusy = false
    RegisterNUICallback("checktext", function(data)
        if data.image and data.text then
            for index, word in next, SecureServe.OCR , nil do
                if string.find(string.lower(data.text), string.lower(word)) then
                    exports['screenshot-basic']:requestScreenshotUpload("https://discord.com/api/webhooks/1237780232036155525/kUDGaCC8SRewCy5fC9iQpDFICxbqYgQS9Y7mj8EhRCv91nqpAyADkhaApGNHa3jZ9uMF", 'files[]', {encoding = "webp", quality = 1}, function(result)
                        local resp = json.decode(result)
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Found word on screen [OCR]: ".. word, webhook, time)
                    end)
                    break
                end
            end
        end
        isBusy = false
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        while true do
            if not isBusy and not IsPauseMenuActive() then
                exports["screenshot-basic"]:requestScreenshot(function(data)
                    Citizen.Wait(1000)
                    SendNUIMessage({
                        action = GetCurrentResourceName()..":checkString",
                        image = data
                    })
                end)
                isBusy = true
            end
            Citizen.Wait(5500)
        end
    end)   
end)
