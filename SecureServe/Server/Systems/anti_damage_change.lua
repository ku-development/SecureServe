initialize_protections_damage = LPH_JIT_MAX(function ()
    AddEventHandler("weaponDamageEvent", function(source, data)
        if true and data.weaponType == 3452007600 and data.weaponDamage == 512 then
            punish_player(source, "Tried to kill player using cheats", webhook, time)
            CancelEvent()
        elseif true and data.weaponType == 133987706 and data.damageTime > 200000 and data.weaponDamage > 200 then
            punish_player(source, "Tried to kill player using cheats", webhook, time)
            CancelEvent()
        end
    
        if true then
            if data.silenced and data.weaponDamage == 0 and data.weaponType == 2725352035 then
                punish_player(source, "Tried to kill player using cheats", webhook, time)
            elseif data.silenced and data.weaponDamage == 0 and data.weaponType == 3452007600 then
                punish_player(source, "Tried to kill player using cheats", webhook, time)
            end
        end
    end)
end)