
fx_version 'cerulean'
game 'gta5'

author 'Clau#1981, Robeer#9999'
version '1.1'
description 'Ultra Scoreboard'

shared_scripts {
    -- '@es_extended/imports.lua',  --On ESX ENABLE
    -- '@es_extended/locale.lua',   -- On ESX ENABLE
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    --'@mysql-async/lib/MySQL.lua', -- FOR OLD VERSION OF MYSQL
    'server/*.lua',
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