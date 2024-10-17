initialize_protections_ptfx = LPH_JIT_MAX(function()
    local particlesSpawned = {}
    AddEventHandler('ptFxEvent', function(sender, data)
        if (Anti_Particles_enabled) then
            particlesSpawned[sender] = (particlesSpawned[sender] or 0) + 1
            if (particlesSpawned[sender] > Anti_Particles_limit) then
                CancelEvent()
                punish_player(sender, "Anti Particle Spam", webhook, time)                
                return
            end
            if (data.effectHash == 2341015072) then
                CancelEvent()
                punish_player(sender, "Anti Fire Player", webhook, time)                
            end
            CancelEvent()
        end
    end)
end)