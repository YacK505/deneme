fx_version 'cerulean'
game 'gta5'

author 'Codex'
description 'Simple house robbery script using qb-core and ox_lib'

lua54 'yes'

dependencies {
    'qb-core',
    'ox_lib',
    'ox_inventory'
}

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'
