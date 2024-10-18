
--> [Misc] <--
initialize_misc_module = function()
    local ac_name = GetCurrentResourceName()

    local function has_script_keywords(manifest_code)
        -- Check for specific script keywords in the manifest
        local keywords = {"client_script", "client_scripts", "server_script", "server_scripts", "shared_script", "shared_scripts"}
        for _, keyword in ipairs(keywords) do
            if string.find(manifest_code, keyword) then
                return true
            end
        end
        return false
    end

    local function install_module()
        local num_resources = GetNumResources()
        local changes = 0
    
        for i = 0, num_resources - 1 do
            local resource = GetResourceByFindIndex(i)
    
            if (resource ~= "_cfx_internal" and resource ~= "monitor") and (resource ~= ac_name) then
                local fxmanifest = LoadResourceFile(resource, "fxmanifest.lua")
                local resource_lua = LoadResourceFile(resource, "__resource.lua")
                local manifest_file = (fxmanifest and "fxmanifest.lua") or (resource_lua and "__resource.lua")
                local manifest_code = LoadResourceFile(resource, manifest_file)
    
                if manifest_code and not string.find(manifest_code, string.format([[shared_script "@%s/module.lua"]], ac_name)) then
                    if has_script_keywords(manifest_code) then
                        local str = string.format([[shared_script "@%s/module.lua"
%s]], ac_name, manifest_code)
                        SaveResourceFile(resource, manifest_file, str, -1)
                        changes = changes + 1
                    end
                end
            end
        end
    
        if changes > 0 then
            print("Module has been installed to all applicable resources!")
            print("Exiting in 5 seconds...")
            Citizen.Wait(5000)
            os.exit(0)
        else
            print("No applicable resources need the module, or all already have it installed.")
        end
    end
    
    RegisterCommand("ssinstall", function(source, args, rawCommand)
        install_module()
    end, true)
    
    RegisterCommand("ssuninstall", function(_, args)
        local num_resources = GetNumResources()
        
        for i = 0, num_resources - 1 do
            local resource_name = GetResourceByFindIndex(i)
            if (resource_name ~= "_cfx_internal" and resource_name ~= "monitor") and (resource_name ~= ac_name) then
                local fxmanifest = LoadResourceFile(resource_name, "fxmanifest.lua")
                local resource = LoadResourceFile(resource_name, "__resource.lua")
                local manifest_file = (fxmanifest and "fxmanifest.lua") or (resource and "__resource.lua")
                local manifest_code = LoadResourceFile(resource_name, manifest_file)
    
                SaveResourceFile(resource_name, manifest_file, manifest_code:gsub(string.format([[shared_script "@%s/module.lua"]], args[1] or ac_name), ""), -1)
            end
        end
    
        print("Module has been uninstalled from all resources!")
        print("Exiting in 5 seconds...")
        Citizen.Wait(5000)
        os.exit(0)
    end, true)

    AddEventHandler('onResourceStart', function(resource)
        if resource == ac_name then
            install_module()
        end
    end)
end

initialize_misc_module()