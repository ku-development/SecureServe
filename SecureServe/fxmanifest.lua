fx_version "cerulean"
game "gta5"

author "SecureServe.net"
version "1.0.0"

ui_page 'index.html'
files {
    'bans.json',
    'index.html'
}

server_scripts {
    "config.lua",
    "server.lua",
}

client_scripts {
    "client.lua",
}

shared_scripts {
    "shared.lua",
    "module.lua",
}

dependencies {
    "/server:5181",
    "screenshot-basic"
}

lua54 "yes"

exports {
    'GetEventWhitelist',
    "TriggeredEvent",
    "IsEventWhitelisted"
}

server_export 'IsEventWhitelisted'