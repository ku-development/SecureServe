
initialize_protections_AI = LPH_JIT_MAX(function()
    if Anti_AI_enabled then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(15000)
                if IsPlayerCamControlDisabled() ~= false then
                    TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti Menyoo", webhook, time)
                end
                local weapons = {
                    `COMPONENT_COMBATPISTOL_CLIP_01`,
                    `COMPONENT_COMBATPISTOL_CLIP_02`,
                    `COMPONENT_APPISTOL_CLIP_01`,
                    `COMPONENT_APPISTOL_CLIP_02`,
                    `COMPONENT_MICROSMG_CLIP_01`,
                    `COMPONENT_MICROSMG_CLIP_02`,
                    `COMPONENT_SMG_CLIP_01`,
                    `COMPONENT_SMG_CLIP_02`,
                    `COMPONENT_ASSAULTRIFLE_CLIP_01`,
                    `COMPONENT_ASSAULTRIFLE_CLIP_02`,
                    `COMPONENT_CARBINERIFLE_CLIP_01`,
                    `COMPONENT_CARBINERIFLE_CLIP_02`,
                    `COMPONENT_ADVANCEDRIFLE_CLIP_01`,
                    `COMPONENT_ADVANCEDRIFLE_CLIP_02`,
                    `COMPONENT_MG_CLIP_01`,
                    `COMPONENT_MG_CLIP_02`,
                    `COMPONENT_COMBATMG_CLIP_01`,
                    `COMPONENT_COMBATMG_CLIP_02`,
                    `COMPONENT_PUMPSHOTGUN_CLIP_01`,
                    `COMPONENT_SAWNOFFSHOTGUN_CLIP_01`,
                    `COMPONENT_ASSAULTSHOTGUN_CLIP_01`,
                    `COMPONENT_ASSAULTSHOTGUN_CLIP_02`,
                    `COMPONENT_PISTOL50_CLIP_01`,
                    `COMPONENT_PISTOL50_CLIP_02`,
                    `COMPONENT_ASSAULTSMG_CLIP_01`,
                    `COMPONENT_ASSAULTSMG_CLIP_02`,
                    `COMPONENT_AT_RAILCOVER_01`,
                    `COMPONENT_AT_AR_AFGRIP`,
                    `COMPONENT_AT_PI_FLSH`,
                    `COMPONENT_AT_AR_FLSH`,
                    `COMPONENT_AT_SCOPE_MACRO`,
                    `COMPONENT_AT_SCOPE_SMALL`,
                    `COMPONENT_AT_SCOPE_MEDIUM`,
                    `COMPONENT_AT_SCOPE_LARGE`,
                    `COMPONENT_AT_SCOPE_MAX`,
                    `COMPONENT_AT_PI_SUPP`,
                }
                for i = 1, #weapons do
                    local dmg_mod = GetWeaponComponentDamageModifier(weapons[i])
                    local accuracy_mod = GetWeaponComponentAccuracyModifier(weapons[i])
                    local range_mod = GetWeaponComponentRangeModifier(weapons[i])
                    if dmg_mod > Anti_AI_default or accuracy_mod > Anti_AI_default or range_mod > Anti_AI_default then
                        TriggerServerEvent("SecureServe:Server:Methods:PunishPlayer" .. code, nil, "Anti AIS", webhook, time)
                    end
                end
            end
        end)
    end
end)
