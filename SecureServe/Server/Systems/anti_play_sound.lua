initialize_server_protections_play_sound = function()
    if (Anti_Play_Sound_enabled) then
        if (GetConvar("sv_enableNetworkedSounds", "true") == "false") then return end
        SetConvar("sv_enableNetworkedSounds", "false")
    end
end