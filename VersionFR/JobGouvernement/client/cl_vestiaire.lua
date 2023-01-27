ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

---------------- FONCTIONS ------------------

RMenu.Add('dobraziil', 'gouv', RageUI.CreateMenu("Vestaire", "Gouvernement"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('dobraziil', 'gouv'), true, true, true, function()

            RageUI.Button("S'équiper de sa tenue : ~b~Civile",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    vcivil()
                end
            end)

            RageUI.Button("S'équiper de la tenue : ~g~Gouvernement",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    gouv()
                end
            end)

        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------


local position = {
    {x = -541.25, y = -192.96, z = 47.12}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then 
                DrawMarker(20, -541.25, -192.96, 46.50+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)



            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au vestiaire")
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('dobraziil', 'gouv'), not RageUI.Visible(RMenu:Get('dobraziil', 'gouv')))
                end
            end
        end
    end
    end
end)

function gouv()
                local model = GetEntityModel(GetPlayerPed(-1))
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if model == GetHashKey("mp_m_freemode_01") then
                        clothesSkin = {
                            ['tshirt_1'] = 21,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['arms'] = 4,      ['helmet_1'] = -1,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['chain_1'] = 13,   ['shoes_2'] = 0,
                        }
                    else
                        clothesSkin = {
                            ['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 141,   ['torso_2'] = 0,
			['arms'] = 72,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
                        }
                    end
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end)
            end

function vcivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end
