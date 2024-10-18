function LPH_JIT_MAX(func)
    return function(...)
        return func(...)
    end
end
function LPH_NO_VIRTUALIZE(func)
    return function(...)
        return func(...)
    end
end

local PlayerCache = {}
local UpdateInterval = 5000 -- 5 seconds, adjust as needed

code = GlobalState.SecureServe_events;

-- Function to update cache data for a player
local function UpdatePlayerCache(playerId)
    if not PlayerCache[playerId] then
        PlayerCache[playerId] = {}
    end
    
    local cache = PlayerCache[playerId]
    local ped = GetPlayerPed(playerId)
    
    -- Player identifiers
    cache.playerId = playerId
    cache.serverId = GetPlayerServerId(playerId)
    cache.ped = ped
    cache.pedId = PedToNet(ped)
    
    -- Frequently updated data
    cache.position = GetEntityCoords(ped)
    cache.health = GetEntityHealth(ped)
    cache.armor = GetPedArmour(ped)
    cache.currentWeapon = GetSelectedPedWeapon(ped)
end

-- Function to get cached player data
function GetCachedPlayerData(playerId)
    return PlayerCache[playerId] or {}
end

-- Function to remove player from cache (call this when a player disconnects)
function RemovePlayerFromCache(playerId)
    PlayerCache[playerId] = nil
end

-- Staggered update function to spread processing over time
local function StaggeredUpdate()
    local playerList = GetPlayers()
    local playerCount = #playerList
    local updateInterval = math.max(50, math.floor(UpdateInterval / playerCount))
    
    for i, playerId in ipairs(playerList) do
        SetTimeout(i * updateInterval, function()
            UpdatePlayerCache(playerId)
        end)
    end
end

-- Start the cache update loop
CreateThread(function()
    while true do
        StaggeredUpdate()
        Wait(UpdateInterval)
    end
end)
function CheckPlayer(playerId)
    local data = GetCachedPlayerData(playerId)
    -- Your anticheat logic here, using 'data'
    -- e.g., if data.pedId ~= PedToNet(GetPlayerPed(playerId)) then -- potential ped change
end
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    RemovePlayerFromCache(playerId)
end)

RegisterNetEvent('receiveConfig', function(config)
    SecureServe = config
end)


Citizen.CreateThread(function()
    -- TriggerServerEvent("requestWhitelist")
    TriggerServerEvent('requestConfig')
end)

while not SecureServe do
    -- TriggerServerEvent("requestWhitelist")
    TriggerServerEvent('requestConfig')
    Wait(10)
end

Wait(1000)


--> [Protections] <--
local events = nil
ProtectionCount = {}


for k,v in pairs(SecureServe.AntiInternal) do
    if v.webhook == "" then
        SecureServe.AntiInternal[k].webhook = SecureServe.Webhooks.AntiInternal
    end
    if type(v.time) ~= "number" then
        SecureServe.AntiInternal[k].time = SecureServe.BanTimes[v.time]
    end
    
    name = SecureServe.AntiInternal[k].detection
    dispatch = SecureServe.AntiInternal[k].dispatch
    default = SecureServe.AntiInternal[k].default
    defaultr = SecureServe.AntiInternal[k].defaultr
    defaults = SecureServe.AntiInternal[k].defaults
    punish = SecureServe.AntiInternal[k].punishType
    time = SecureServe.AntiInternal[k].time
    if type(time) ~= "number" then
        time = SecureServe.BanTimes[v.time]
    end
    limit = SecureServe.AntiInternal[k].limit or 999
    webhook = SecureServe.AntiInternal[k].webhook
    if webhook == "" then
        webhook = SecureServe.Webhooks.AntiInternal
    end
    enabled = SecureServe.AntiInternal[k].enabled
    if name == "Anti RedEngine" then
        Anti_RedEngine_time = time
        Anti_RedEngine_limit = limit
        Anti_RedEngine_webhook = webhook
        Anti_RedEngine_enabled = enabled
        Anti_RedEngine_punish = punish
    elseif name == "Anti Internal" then
        Anti_AntiIntrenal_time = time
        Anti_AntiIntrenal_limit = limit
        Anti_AntiIntrenal_webhook = webhook
        Anti_AntiIntrenal_enabled = enabled
        Anti_AntiIntrenal_punish = punish
    elseif name == "Destroy Input" then
        Anti_Destory_Input_time = time
        Anti_Destory_Input_limit = limit
        Anti_Destory_Input_webhook = webhook
        Anti_Destory_Input_enabled = enabled
        Anti_Destory_Input_punish = punish
    end
end


for k,v in pairs(SecureServe.Protection.Simple) do
    if v.webhook == "" then
        SecureServe.Protection.Simple[k].webhook = SecureServe.Webhooks.Simple
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.Simple[k].time = SecureServe.BanTimes[v.time]
    end
    
    name = SecureServe.Protection.Simple[k].protection
    dispatch = SecureServe.Protection.Simple[k].dispatch
    default = SecureServe.Protection.Simple[k].default
    defaultr = SecureServe.Protection.Simple[k].defaultr
    defaults = SecureServe.Protection.Simple[k].defaults
    time = SecureServe.Protection.Simple[k].time
    if type(time) ~= "number" then
        time = SecureServe.BanTimes[v.time]
    end
    limit = SecureServe.Protection.Simple[k].limit or 999
    webhook = SecureServe.Protection.Simple[k].webhook
    if webhook == "" then
        webhook = SecureServe.Webhooks.Simple
    end
    enabled = SecureServe.Protection.Simple[k].enabled
    if name == "Anti Give Weapon" then
        Anti_Give_Weapon_time = time
        Anti_Give_Weapon_limit = limit
        Anti_Give_Weapon_webhook = webhook
        Anti_Give_Weapon_enabled = enabled
    elseif name == "Anti Remove Weapon" then
        Anti_Remove_Weapon_time = time
        Anti_Remove_Weapon_limit = limit
        Anti_Remove_Weapon_webhook = webhook
        Anti_Remove_Weapon_enabled = enabled
    elseif name == "Anti Player Blips" then
        Anti_Player_Blips_time = time
        Anti_Player_Blips_limit = limit
        Anti_Player_Blips_webhook = webhook
        Anti_Player_Blips_enabled = enabled
    elseif name == "Anti Car Fly" then
        Anti_Car_Fly_time = time
        Anti_Car_Fly_limit = limit
        Anti_Car_Fly_webhook = webhook
        Anti_Car_Fly_enabled = enabled
    elseif name == "Anti Car Ram" then
        Anti_Car_Ram_time = time
        Anti_Car_Ram_limit = limit
        Anti_Car_Ram_webhook = webhook
        Anti_Car_Ram_enabled = enabled
    elseif name == "Anti Particles" then
        Anti_Particles_time = time
        Anti_Particles_limit = limit
        Anti_Particles_webhook = webhook
        Anti_Particles_enabled = enabled
    elseif name == "Anti Internal" then
        Anti_Internal_time = time
        Anti_Internal_limit = limit
        Anti_Internal_webhook = webhook
        Anti_Internal_enabled = enabled
    elseif name == "Anti Damage Modifier" then
        Anti_Damage_Modifier_default = default
        Anti_Damage_Modifier_time = time
        Anti_Damage_Modifier_limit = limit
        Anti_Damage_Modifier_webhook = webhook
        Anti_Damage_Modifier_enabled = enabled
    elseif name == "Anti Weapon Pickup" then
        Anti_Weapon_Pickup_time = time
        Anti_Weapon_Pickup_limit = limit
        Anti_Weapon_Pickup_webhook = webhook
        Anti_Weapon_Pickup_enabled = enabled
    elseif name == "Anti Remove From Car" then
        Anti_Remove_From_Car_time = time
        Anti_Remove_From_Car_limit = limit
        Anti_Remove_From_Car_webhook = webhook
        Anti_Remove_From_Car_enabled = enabled
    elseif name == "Anti Spectate" then
        Anti_Spectate_time = time
        Anti_Spectate_limit = limit
        Anti_Spectate_webhook = webhook
        Anti_Spectate_enabled = enabled
    elseif name == "Anti Freecam" then
        Anti_Freecam_time = time
        Anti_Freecam_limit = limit
        Anti_Freecam_webhook = webhook
        Anti_Freecam_enabled = enabled
    elseif name == "Anti Explosion Bullet" then
        Anti_Explosion_Bullet_time = time
        Anti_Explosion_Bullet_limit = limit
        Anti_Explosion_Bullet_webhook = webhook
        Anti_Explosion_Bullet_enabled = enabled
    elseif name == "Anti Magic Bullet" then
        Anti_Magic_Bullet_time = time
        Anti_Magic_Bullet_limit = limit
        Anti_Magic_Bullet_webhook = webhook
        Anti_Magic_Bullet_enabled = enabled
    elseif name == "Anti Night Vision" then
        Anti_Night_Vision_time = time
        Anti_Night_Vision_limit = limit
        Anti_Night_Vision_webhook = webhook
        Anti_Night_Vision_enabled = enabled
    elseif name == "Anti Thermal Vision" then
        Anti_Thermal_Vision_time = time
        Anti_Thermal_Vision_limit = limit
        Anti_Thermal_Vision_webhook = webhook
        Anti_Thermal_Vision_enabled = enabled
    elseif name == "Anti God Mode" then
        Anti_God_Mode_time = time
        Anti_God_Mode_limit = limit
        Anti_God_Mode_webhook = webhook
        Anti_God_Mode_enabled = enabled
    elseif name == "Anti Infinite Ammo" then
        Anti_Infinite_Ammo_time = time
        Anti_Infinite_Ammo_limit = limit
        Anti_Infinite_Ammo_webhook = webhook
        Anti_Infinite_Ammo_enabled = enabled
    elseif name == "Anti Teleport" then
        Anti_Teleport_time = time
        Anti_Teleport_limit = limit
        Anti_Teleport_webhook = webhook
        Anti_Teleport_enabled = enabled
    elseif name == "Anti Invisible" then
        Anti_Invisible_time = time
        Anti_Invisible_limit = limit
        Anti_Invisible_webhook = webhook
        Anti_Invisible_enabled = enabled
    elseif name == "Anti Resource Stopper" then
        Anti_Resource_Stopper_dispatch = dispatch
        Anti_Resource_Stopper_time = time
        Anti_Resource_Stopper_limit = limit
        Anti_Resource_Stopper_webhook = webhook
        Anti_Resource_Stopper_enabled = enabled
    elseif name == "Anti Resource Starter" then
        Anti_Resource_Starter_dispatch = dispatch
        Anti_Resource_Starter_time = time
        Anti_Resource_Starter_limit = limit
        Anti_Resource_Starter_webhook = webhook
        Anti_Resource_Starter_enabled = enabled
    elseif name == "Anti Vehicle God Mode" then
        Anti_Vehicle_God_Mode_time = time
        Anti_Vehicle_God_Mode_limit = limit
        Anti_Vehicle_God_Mode_webhook = webhook
        Anti_Vehicle_God_Mode_enabled = enabled
    elseif name == "Anti Vehicle Power Increase" then
        Anti_Vehicle_Power_Increase_time = time
        Anti_Vehicle_Power_Increase_limit = limit
        Anti_Vehicle_Power_Increase_webhook = webhook
        Anti_Vehicle_Power_Increase_enabled = enabled
    elseif name == "Anti Speed Hack" then
        Anti_Speed_Hack_time = time
        Anti_Speed_Hack_limit = limit
        Anti_Speed_Hack_webhook = webhook
        Anti_Speed_Hack_defaultr = defaultr
        Anti_Speed_Hack_defaults = defaults
        Anti_Speed_Hack_enabled = enabled
    elseif name == "Anti Vehicle Spawn" then
        Anti_Vehicle_Spawn_time = time
        Anti_Vehicle_Spawn_limit = limit
        Anti_Vehicle_Spawn_webhook = webhook
        Anti_Vehicle_Spawn_enabled = enabled
    elseif name == "Anti Ped Spawn" then
        Anti_Ped_Spawn_time = time
        Anti_Ped_Spawn_limit = limit
        Anti_Ped_Spawn_webhook = webhook
        Anti_Ped_Spawn_enabled = enabled
    elseif name == "Anti Plate Changer" then
        Anti_Plate_Changer_time = time
        Anti_Plate_Changer_limit = limit
        Anti_Plate_Changer_webhook = webhook
        Anti_Plate_Changer_enabled = enabled
    elseif name == "Anti Cheat Engine" then
        Anti_Cheat_Engine_time = time
        Anti_Cheat_Engine_limit = limit
        Anti_Cheat_Engine_webhook = webhook
        Anti_Cheat_Engine_enabled = enabled
    elseif name == "Anti Rage" then
        Anti_Rage_time = time
        Anti_Rage_limit = limit
        Anti_Rage_webhook = webhook
        Anti_Rage_enabled = enabled
    elseif name == "Anti Aim Assist" then
        Anti_Aim_Assist_time = time
        Anti_Aim_Assist_limit = limit
        Anti_Aim_Assist_webhook = webhook
        Anti_Aim_Assist_enabled = enabled
    elseif name == "Anti Kill All" then
        Anti_Kill_All_time = time
        Anti_Kill_All_limit = limit
        Anti_Kill_All_webhook = webhook
        Anti_Kill_All_enabled = enabled
    elseif name == "Anti Solo Session" then
        Anti_Solo_Session_time = time
        Anti_Solo_Session_limit = limit
        Anti_Solo_Session_webhook = webhook
        Anti_Solo_Session_enabled = enabled
    elseif name == "Anti AI" then
        Anti_AI_default = default
        Anti_AI_time = time
        Anti_AI_limit = limit
        Anti_AI_webhook = webhook
        Anti_AI_enabled = enabled
    elseif name == "Anti No Reload" then
        Anti_No_Reload_time = time
        Anti_No_Reload_limit = limit
        Anti_No_Reload_webhook = webhook
        Anti_No_Reload_enabled = enabled
    elseif name == "Anti Rapid Fire" then
        Anti_Rapid_Fire_time = time
        Anti_Rapid_Fire_limit = limit
        Anti_Rapid_Fire_webhook = webhook
        Anti_Rapid_Fire_enabled = enabled
    elseif name == "Anti Bigger Hitbox" then
        Anti_Bigger_Hitbox_default = default
        Anti_Bigger_Hitbox_time = time
        Anti_Bigger_Hitbox_limit = limit
        Anti_Bigger_Hitbox_webhook = webhook
        Anti_Bigger_Hitbox_enabled = enabled
    elseif name == "Anti No Recoil" then
        Anti_No_Recoil_default = default
        Anti_No_Recoil_time = time
        Anti_No_Recoil_limit = limit
        Anti_No_Recoil_webhook = webhook
        Anti_No_Recoil_enabled = enabled
    elseif name == "Anti State Bag Overflow" then
        Anti_State_Bag_Overflow_time = time
        Anti_State_Bag_Overflow_limit = limit
        Anti_State_Bag_Overflow_webhook = webhook
        Anti_State_Bag_Overflow_enabled = enabled
    elseif name == "Anti Extended NUI Devtools" then
        Anti_Extended_NUI_Devtools_time = time
        Anti_Extended_NUI_Devtools_limit = limit
        Anti_Extended_NUI_Devtools_webhook = webhook
        Anti_Extended_NUI_Devtools_enabled = enabled
    elseif name == "Anti No Ragdoll" then
        Anti_No_Ragdoll_time = time
        Anti_No_Ragdoll_limit = limit
        Anti_No_Ragdoll_webhook = webhook
        Anti_No_Ragdoll_enabled = enabled
    elseif name == "Anti Super Jump" then
        Anti_Super_Jump_time = time
        Anti_Super_Jump_limit = limit
        Anti_Super_Jump_webhook = webhook
        Anti_Super_Jump_enabled = enabled
    elseif name == "Anti Noclip" then
        Anti_Noclip_time = time
        Anti_Noclip_limit = limit
        Anti_Noclip_webhook = webhook
        Anti_Noclip_enabled = enabled
    elseif name == "Anti Infinite Stamina" then
        Anti_Infinite_Stamina_time = time
        Anti_Infinite_Stamina_limit = limit
        Anti_Infinite_Stamina_webhook = webhook
        Anti_Infinite_Stamina_enabled = enabled
    elseif name == "Anti AFK Injection" then
        Anti_AFK_time = time
        Anti_AFK_limit = limit
        Anti_AFK_webhook = webhook
        Anti_AFK_enabled = enabled
    elseif name == "Anti Play Sound" then
        Anti_Play_Sound_time = time
        Anti_Play_Sound_webhook = webhook
        Anti_Play_Sound_enabled = enabled
    end
    
    if not ProtectionCount["SecureServe.Protection.Simple"] then ProtectionCount["SecureServe.Protection.Simple"] = 0 end
    ProtectionCount["SecureServe.Protection.Simple"] = ProtectionCount["SecureServe.Protection.Simple"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedCommands) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedCommands[k].webhook = SecureServe.Webhooks.BlacklistedCommands
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedCommands[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedCommands"] then ProtectionCount["SecureServe.Protection.BlacklistedCommands"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedCommands"] = ProtectionCount["SecureServe.Protection.BlacklistedCommands"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedSprites) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedSprites[k].webhook = SecureServe.Webhooks.BlacklistedSprites
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedSprites[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedSprites"] then ProtectionCount["SecureServe.Protection.BlacklistedSprites"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedSprites"] = ProtectionCount["SecureServe.Protection.BlacklistedSprites"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedAnimDicts) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedAnimDicts[k].webhook = SecureServe.Webhooks.BlacklistedAnimDicts
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedAnimDicts[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedAnimDicts"] then ProtectionCount["SecureServe.Protection.BlacklistedAnimDicts"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedAnimDicts"] = ProtectionCount["SecureServe.Protection.BlacklistedAnimDicts"] + 1
end


for k,v in pairs(SecureServe.Protection.BlacklistedExplosions) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedExplosions[k].webhook = SecureServe.Webhooks.BlacklistedExplosions
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedExplosions[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedExplosions"] then ProtectionCount["SecureServe.Protection.BlacklistedExplosions"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedExplosions"] = ProtectionCount["SecureServe.Protection.BlacklistedExplosions"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedWeapons) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedWeapons[k].webhook = SecureServe.Webhooks.BlacklistedWeapons
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedWeapons[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedWeapons"] then ProtectionCount["SecureServe.Protection.BlacklistedWeapons"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedWeapons"] = ProtectionCount["SecureServe.Protection.BlacklistedWeapons"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedVehicles) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedVehicles[k].webhook = SecureServe.Webhooks.BlacklistedVehicles
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedVehicles[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedVehicles"] then ProtectionCount["SecureServe.Protection.BlacklistedVehicles"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedVehicles"] = ProtectionCount["SecureServe.Protection.BlacklistedVehicles"] + 1
end

for k,v in pairs(SecureServe.Protection.BlacklistedObjects) do
    if v.webhook == "" then
        SecureServe.Protection.BlacklistedObjects[k].webhook = SecureServe.Webhooks.BlacklistedObjects
    end
    if type(v.time) ~= "number" then
        SecureServe.Protection.BlacklistedObjects[k].time = SecureServe.BanTimes[v.time]
    end
            
    if not ProtectionCount["SecureServe.Protection.BlacklistedObjects"] then ProtectionCount["SecureServe.Protection.BlacklistedObjects"] = 0 end
    ProtectionCount["SecureServe.Protection.BlacklistedObjects"] = ProtectionCount["SecureServe.Protection.BlacklistedObjects"] + 1
end



--> [Init] <--
AddEventHandler('playerSpawned', LPH_NO_VIRTUALIZE(function()
    Citizen.CreateThread(function()
        -- TriggerServerCallback {
        --     eventName = 'SecureServe:Server_Callbacks:Protections:GetConfig',
        --     args = {},
        --     callback = function(result)
        --         SecureServe = result
        --     end
        -- }
        
        -- while SecureServe == nil do
        --     Wait(0)
        -- end
        -- SecureServe = SecureServe
    
        --> [Inits] <--
        -- initialize_protections_internal()
        initialize_protections_noclip()
        initialize_protections_entity_security()
        initialize_protections_resources()
        initialize_protections_no_recoil()
        initialize_protections_weapon_pickup()
        initialize_protections_invisible()
        initialize_ocr()
        initialize_protections_god_mode()
        initialize_protections_state_bag_overflow()
        initialize_protections_spoof_shot()
        initialize_protections_speed_hack()
        initialize_protections_spectate()
        initialize_protections_no_reload()
        initialize_protections_AI()
        -- initialize_protections_rapid_fire()
        initialize_protections_no_ragdoll()
        initialize_protections_player_blips()
        initialize_protections_magic_bullet()
        initialize_protections_visions()
        initialize_protections_infinite_ammo()
        initialize_protections_bigger_hitbox()
        initialize_protections_explosive_bullets()
        initialize_protections_afk_injection()
        initialize_protections_aim_assist()

        --> [Blacklists] <--
        initialize_blacklists_commands()
        initialize_blacklists_sprites()
        initialize_blacklists_weapon()

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0) -- Run every frame
                local playerPed = PlayerPedId()
                SetEntityProofs(playerPed, false, false, true, false, false, false, false, false)
            end
        end)
    end)
end))


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every second
        TriggerServerEvent('playerLoaded')
        break
    end
end)