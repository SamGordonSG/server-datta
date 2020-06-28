fx_version 'adamant'

game 'gta5'

description 'Véhicules entreprises'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'serveur/global.lua',
	'serveur/ambulance.lua',
	'serveur/brasseur.lua',
	'serveur/petitstudio.lua',
	'serveur/foodtruck.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/ambulance.lua',
	'client/brasseur.lua',
	'client/petitstudio.lua',
	'client/foodtruck.lua'
}

dependencies {
	'es_extended',
	'esx_vehicleshop'
}
