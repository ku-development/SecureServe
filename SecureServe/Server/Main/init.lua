--> [Init] <--

local timeout = 0
local ac_name = GetCurrentResourceName()
local user_data = {
    DiscordID = "N/A",
    expire = "N/A",
    date = "N/A",
    is_expired = true
}

RegisterServerCallback {
    eventName = 'SecureServe:Server_Callbacks:Protections:GetConfig',
    eventCallback = function(source)
        return SecureServe
    end
}

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    print(
[[^5
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&X+;x&&X+;x$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$;;x$&X+++++X$X;:+$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$+:;$&$x+xx++xxxxx;+$&X::+$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&X+;+X&&$$$&&&&&&&&$Xxxxxx++x$$X+;+X&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&x::+XX$&XX&&&&&Xx:;$&&&&++x$&&$Xx:+X++X+:;X&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&$x::+xxx$$X+$&&x:....:$&&$;X&&X:.....;+Xx;+Xx;xx+:;x$&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&X+::+;;xX$XxxX&&&&$:.....x&&&x...;&&&x.......;XXX+;+XXx++x+;;x$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&X::+x;:x&&$;;$&&&&&&&$:....;&&&&x......+&&&;......:$XXXX$x.;X&+.;XX;.:x&&&&&&&&&&&&&&&
&&&&&&&&&&&&&x:XXX$$x++X&&&&&&&&&&&:....x&&&&;.........x&&$:.....;&&&&&&&&$x;+x$$XX$x:X&&&&&&&&&&&&&
&&&&&&&&&&&&&+;X;$X+$$$$$$&&&&&&&&:....+x;&&:..........++X&&;.....x&&&&&&&&&&&$$+$$XX;;&&&&&&&&&&&&&
&&&&&&&&&&&&&++x;&x+$$$$$$&&&&&&&x......+&:+&;.......:$x+&&x......:$&&&&&&&&&&&&+X$XX;:&&&&&&&&&&&&&
&&&&&&&&&&&&&++;+&+x$$$$$$&&&&&&&;.......:$x:$X.....;$;x&$:........x&&&&&&&&&&$$xx$XX;:&&&&&&&&&&&&&
&&&&&&&&&&&&&++;;&+x$$$$$$&&&&&&x..........X&;x$...X$;$&+..........:$&&&&&&&&&$$Xx$Xx;:&&&&&&&&&&&&&
&&&&&&&&&&&&&;+;;&+x$X$$$$&&&&&&:..:X:......+&x:$$$+;&X.......+X....x&&&&&&&&&$$X+$Xx;:&&&&&&&&&&&&&
&&&&&&&&&&&&&;;:;&;xXx$$$$&&&&&x....X&x.......x$:;:X$:.....:x&x......&&&&&&&&&$XX+$Xx;:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;:;&;xXx$$$$&&&&&......$&&;......:$$X:......x&&:.......+&&&&&&&&$XX+$XX+:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;:;&;xX+Xx$$$&&&+.......;&&$:.............+&&X:.....;...$&&&&&&&XXX+$$X+:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;:;&;xX+X+$$$&&$:.::.....:X&&x..........+&&&+......:+...x&&&&&&&x$X+$$X+:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;:;&+xX;Xxx$$&&x..+$.......;&&&;......;&&&$;......;;X+..;$&&&&&&+$X+$$X+:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;;;$+xX+xX+$$&$;..+&&;.......X&&$:..:$&&&X.......;x&&X:..x&&&&&$+&X+$$$+:$&&&&&&&&&&&&
&&&&&&&&&&&&&;;;;$x+Xx+$;X$&X...X&&&x.......;&&&X+&&&&;.......xx&&&&:..;&&&&&X+&Xx$$$+:$&&&&&&&&&&&&
&&&&&&&&&&&&&+:;;$x;Xx;X++$&+..:&&&&&$:.......X&&&&&X.......;+&&&&&&+...X&&&&xx&xX$$$+:$&&&&&&&&&&&&
&&&&&&&&&&&&&X:+:XX+;X+;X;X$:.:+&&&&&&&+.......+&&&x.......;x&&&&&&&x::.;&&&&+$$+$$$$;:&&&&&&&&&&&&&
&&&&&&&&&&&&&&:+;;XXx;X;;X;$$$&&&&&&&&&&$.......$&&:.....:;&&&&&&&&$x&&&&&&&Xx$;$$&+x;;&&&&&&&&&&&&&
&&&&&&&&&&&&&&X:+:+XXx;x;+X;X$$$$&&&&$+$&&x.....&&&:....:X&&&&&&&&$;X&&&&$XX+Xx&&&X:X:X&&&&&&&&&&&&&
&&&&&&&&&&&&&&&+:x:xXXx;X;xX;X$$$$$$$$X+X&&$:....+:....:$&$&&&&&&$;+$&$$$x$$Xx&&&$:X++&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&$;:x:XXXX:x;xX+X$$$$$$$$x+;&&&X........X&$x&&&&&&X;+$&&x$:&&X+&&&$;+X;$$$&&&&&&&&&&&&
&&&&&&&&&&&&&&&&$:;;;XXXX+x;+x+$$$$$$$$X+;+$&&&+....;&&xX&&&&&&X;+$&&+X+&&X+&&&&++x:$$$$&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&$:+:;XXXx+X;+x;X$$$XXXXx;;+X&&&$::$&xx&&&&&&&$;x&&&+xxX&X+$$$$;;+:$$$$$&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&$X:x;;XXXX;x++x+XXXXXXXx+;;+xX&&&&&+$&&&&&&&$;X&&&++Xx&$+$$$$;:x:$$$$$&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&$$X:;;;XXXX+x;+x+xXXXXxxx;;;+xxX$x+&&&&&&&&X+&&&&x+x;$$;$$$X;;+;$&&&$&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&$$$:;:;XXXX+X+;+++xXxxxx+;;;++++X&&&&&&&&$X&&&&x;x;$Xx$$XX:;;:$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&$$$;+;;xXXX;x+;;++xxxx++;;;;+++X&&&&&&&&$&&&&++X;$$xXXXx:;+x$&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&$$$;:+:XXXX+++;;+++x++++;;;;++X&&&&&&&&&&&&xxx;XXxXXXx:;+$$$$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&$$$+:+.xXXXx+x;;+++++++;;;;+;X&&&&&&&&&&&;X+:XxXXXX+:;X$$$$$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&$$$x:+:+XXXx;+;;;++++++;;;+;X&&&&&&&&&$+$+;$xXXXX;:+X$$$$$$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&$$$X::;;xXXX++;;;+++++;;;+;X&&&&&&&&XX&++XxXXXX::+$$$$$$$$&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&$$$$+:;:+xXXx++;;;++++++++X&&&&&&&x&&;xXX$XX+.;x$$$$$$$&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&$$$X:;:;xXXX;+;;;;++++++X&&&&&&$&$+XxX$$X;:;X$$$$&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&$$$$+:;:xXXX++;;;;+++++X&&&&&&&&xxX$$$x::x$$$$&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$$$X:;:+XXXx+;;;;++++X&&&&&&&Xx$$$X;:+X$$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$$$$+:;:+XXXx+;;;+++X&&&&&$x$&$$+:;x$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$$&&$;:+:xXXX+;;+++X&&&&xx&&&x:++$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&X:;;:XX$X+;++X&&Xx&&&X:;;X&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&X:;++X$$x;+X$+$&&$;+;X&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&x:;;x$$$;+$&&&;;;+&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&x:++X$&&&$+;++$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&+:+xXX;;++$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$;;xX$;$&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&X;:+&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
^0]])
    
    sm_print("Light Blue", "Authenticating with server...")
    repeat

        
        Citizen.Wait(1000)


    SetConvar("Anti Cheat", "SecureServe-ac.com")
    SetConvarServerInfo("Anti Cheat", "SecureServe-ac.com")
    SetConvarReplicated("Anti Cheat", "SecureServe-ac.com")

    --> [Modules] <--
    initialize_misc_module()

    --> [Protections] <--
    initialize_server_protections_anti_resource()
    initialize_server_protections_play_sound()
    initialize_protections_explosions()
    initialize_protections_entity_spam()
    initialize_protections_damage()
    initialize_protections_entity_lockdown()
    initialize_protections_ptfx()

end)

local function replaceEventRegistrations(filePath)
    local file = io.open(filePath, "r")
    if not file then
        -- print("Could not open file: " .. filePath)
        return
    end

    local content = file:read("*all")
    file:close()

    local netEventPattern = "RegisterNetEvent%s*%('([^']+)'%s*%)%s*AddEventHandler%s*%('%1'%s*,%s*function%(([^)]*)%)"
    content = content:gsub(netEventPattern, "RegisterNetEvent('%1', function(%2)")

    local serverEventPattern = "RegisterServerEvent%s*%('([^']+)'%s*%)%s*AddEventHandler%s*%('%1'%s*,%s*function%(([^)]*)%)"
    content = content:gsub(serverEventPattern, "RegisterNetEvent('%1', function(%2)")

    local outputFile = io.open(filePath, "w")
    if not outputFile then
        -- print("Could not open file for writing: " .. filePath)
        return
    end

    outputFile:write(content)
    outputFile:close()
    -- print("Updated file: " .. filePath)
end

local function fileContainsLine(filePath, lineToFind)
    local file = io.open(filePath, "r")
    if not file then
        -- print("Could not open file: " .. filePath)
        return false
    end

    for line in file:lines() do
        if line:match(lineToFind) then
            file:close()
            return true
        end
    end

    file:close()
    return false
end

Citizen.CreateThread(function ()
    local function executePythonFile()
        local command = 'app.py'
    
        os.execute(command)
    end

    executePythonFile()
end)


local function searchInDirectory(directory, resourceName)
    local findCommand
    if os.getenv("OS") == "Windows_NT" then
        findCommand = 'dir /s /b "' .. directory .. '\\*.lua"'
    else
        findCommand = 'find "' .. directory .. '" -type f -name "*.lua"'
    end

    local p = io.popen(findCommand)
    if not p then
        -- print("Could not open directory: " .. directory)
        return
    end


    
    -- for file in p:lines() do
    --     -- replaceEventRegistrations(file)

    --     if fileContainsLine(file, "CreateObject") or fileContainsLine(file, "CreateVehicle") or
    --        fileContainsLine(file, "CreatePed") or fileContainsLine(file, "CreatePedInsideVehicle") or
    --        fileContainsLine(file, "CreateRandomPed") or fileContainsLine(file, "CreateRandomPedAsDriver") then
    --         -- print("Whitelisted resource with entity creation: " .. resourceName)
    --         table.insert(SecureServe.EntitySecurity, {resource = resourceName, whitelist = true})
    --     end
    -- end

    p:close()
end

function SearchForAssetPackDependency()
    SecureServe.EntitySecurity = SecureServe.EntitySecurity or {}

    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local resourcePath = GetResourcePath(resourceName)
        if not resourcePath then
            -- print("Could not find resource path for: " .. resourceName)
            goto continue
        end

        local fxManifestPath = resourcePath .. "/fxmanifest.lua"
        local resourceLuaPath = resourcePath .. "/__resource.lua"

        if fileContainsLine(fxManifestPath, "dependency '/assetpacks'") or fileContainsLine(resourceLuaPath, "dependency '/assetpacks'") then
            -- print("Whitelisted encrypted resource: " .. resourceName)
            -- table.insert(SecureServe.EntitySecurity, {resource = resourceName, whitelist = true})
        end

        -- Search all Lua files in the resource directory and its subdirectories
        searchInDirectory(resourcePath, resourceName)

        ::continue::
    end
end

SearchForAssetPackDependency()


exports('isResourceWhitelistedServer', function(resourceName)
    for _, resource in ipairs(SecureServe.EntitySecurity) do
        if resource.resource == resourceName and resource.whitelist then
            return true
        end
    end
    return false
end)

