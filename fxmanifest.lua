fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'Parralel Studios'
description 'NoPixel V Inspired Announcements (Tx-Admin Replacement)'
version '1.0.0'

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/assets/*',
}

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'
