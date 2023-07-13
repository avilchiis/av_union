fx_version 'cerulean'
description 'AV Union Heist'
author 'Avilchiis'
version '1.0.0'
lua54 'yes'
games {
'gta5'
}

shared_scripts {
'@ox_lib/init.lua',
'config/*.lua'
}

client_scripts {
'client/**/*',
}

server_scripts {
'server/**/*'
}

dependencies {
 'ox_lib',
 'ps-ui',
 '/gameBuild:2060',
}