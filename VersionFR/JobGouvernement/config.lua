Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.Type         = 20

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true
Config.EnableNonFreemodePeds      = false
Config.EnableLicenses             = true

Config.EnableHandcuffTimer        = true 
Config.HandcuffTimer              = 10 * 60000 

Config.EnableJobBlip              = false 

Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.WhitelistedCops = {
	'gouv'
}

Config.pos = {

	garage = {
		position = {x = -511.16, y = -262.12, z = 35.45}
	},

	spawnvoiture = {
		position = {x = -511.16, y = -262.12, z = 35.45, h = 117.98}
	},
        pos  = {
            {pos = vector3(-511.16, -262.12, 35.45), heading = 117.98},  
            {pos = vector3(-511.16, -262.12, 35.45), heading = 117.98},              
        },
    }