
AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    local tokens = {}
    for i = 1, 5 do
        table.insert(tokens, GetPlayerToken(src, i))
    end
    deferrals.defer()
    local hwid_2 = GetPlayerToken(source, 1)
    Citizen.Wait(0)

    local data = getBanList()
    local identifiers = GetPlayerIdentifiers(src)
    local isBanned = false

    for _, identifier in ipairs(identifiers) do
        for _, ban in ipairs(data) do
            for k, v in pairs(ban) do
                if v == identifier then
                    isBanned = true
                    local id = ban.id or "Unknown Id"
                    local reason = ban.reason or "Unknown Reason"
                    local expire = ban.expire or "Unknown Expiry"
                    local updated = false

                    for i, token in ipairs(tokens) do
                        if ban["hwid" .. i] ~= token then
                            ban["hwid" .. i] = token
                            updated = true
                        end
                    end
                    if updated then
                        SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(data, { indent = true }), -1)
                    end

                    local card = [[
                        {
                            "type": "AdaptiveCard",
                            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                            "version": "1.3",
                            "backgroundImage": {
                                "url": "https://www.transparenttextures.com/patterns/black-linen.png"
                            },
                            "body": [
                                {
                                    "type": "Container",
                                    "style": "emphasis",
                                    "bleed": true,
                                    "items": [
                                        {
                                            "type": "Image",
                                            "url": "https://img.icons8.com/color/452/error.png",
                                            "horizontalAlignment": "Center",
                                            "size": "Large",
                                            "spacing": "Large"
                                        },
                                        {
                                            "type": "TextBlock",
                                            "text": "Access Denied",
                                            "wrap": true,
                                            "horizontalAlignment": "Center",
                                            "size": "ExtraLarge",
                                            "weight": "Bolder",
                                            "color": "Attention",
                                            "spacing": "Medium"
                                        },
                                        {
                                            "type": "TextBlock",
                                            "text": "You are banned from this server.",
                                            "wrap": true,
                                            "horizontalAlignment": "Center",
                                            "size": "Large",
                                            "weight": "Bolder",
                                            "color": "Attention",
                                            "spacing": "Small"
                                        },
                                        {
                                            "type": "TextBlock",
                                            "text": "This ban never expires. If you think this was a mistake or you just want to appeal your ban, please join the support Discord below.",
                                            "wrap": true,
                                            "horizontalAlignment": "Center",
                                            "size": "Medium",
                                            "spacing": "Medium"
                                        }
                                    ]
                                }
                            ],
                            "actions": [
                                {
                                    "type": "Action.ShowCard",
                                    "title": "Ban Details",
                                    "card": {
                                        "type": "AdaptiveCard",
                                        "body": [
                                            {
                                                "type": "FactSet",
                                                "facts": [
                                                    {
                                                        "title": "Ban ID:",
                                                        "value": "%s"
                                                    },
                                                
                                                    {
                                                        "title": "Expires:",
                                                        "value": "Never"
                                                    }
                                                ]
                                            }
                                        ],
                                        "actions": [
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": "Join Discord",
                                                "url": "%s",
                                                "style": "positive",
                                                "iconUrl": "https://img.icons8.com/ios-filled/452/discord-logo.png"
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                                       
                    ]]
                    
                    local discordLink = SecureServe.DiscordLink or "https://discord.com"
                    deferrals.presentCard(string.format(card, id, expire, discordLink), function(data, rawData) end)
                    Citizen.CreateThread(function()
                        while true do
                          Wait(0)
                          deferrals.presentCard(string.format(card, id, expire, discordLink), function(data, rawData) end)
                          CancelEvent()
                        end
                      end)
                    return
                end
            end
        end
    end

    deferrals.done()
end)