
fx_version 'cerulean'
game 'gta5'

author 'Clau#1981'

description 'Ultra Scoreboard'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

ui_page {
    'html/index.html',
}

files {
	'html/index.html',
	'html/app.js', 
    'html/style.css'
}

lua54 'yes'
