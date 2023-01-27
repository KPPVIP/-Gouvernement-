local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
blip = nil

local attente = 0

function OpenBillingMenu()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_gouv', ('gouv'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end


  ESX = nil

  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayerData = {}
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsIn( ped, false )
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

RMenu.Add('gouv', 'main', RageUI.CreateMenu("Gouvernement", "Gouvernement"))
RMenu.Add('gouv', 'inter', RageUI.CreateMenu("Gouvernement", "Gouvernement"))
RMenu.Add('gouv', 'boissons', RageUI.CreateSubMenu(RMenu:Get('gouv', 'main'), "Gouvernement", "Gouvernement"))
RMenu.Add('gouv', 'ppa', RageUI.CreateSubMenu(RMenu:Get('gouv', 'main'), "PPA", "Menu PPA"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('gouv', 'main'), true, true, true, function()

			RageUI.Button("📲 ~r~Gestions des Annonces~", nil, {RightLabel = "→→"},true, function ()
            end, RMenu:Get('gouv', 'boissons'))

			RageUI.Button("📋 ~o~Donner une facture",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
				if Selected then
					RageUI.CloseAll()        
					OpenBillingMenu() 
				end
			end)
		end, function()
        end)

		RageUI.IsVisible(RMenu:Get('gouv', 'boissons'), true, true, true, function()
					

		RageUI.Button("~g~Annonces d'ouverture",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			if Selected then      
				TriggerServerEvent('AnnonceOuvertG')
			end
		end)

		RageUI.Button("~r~Annonces de fermeture",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			if Selected then     
				TriggerServerEvent('AnnonceFermerG')
			end
		end)

		RageUI.Button("~l~Annonces Devis + Travaux",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			if Selected then     
				TriggerServerEvent('AnnoncePPA')
			end
		end)

	RageUI.Button("~b~Annonce recrutement", "Pour annoncer des recrutements", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
			if (Selected) then   
			TriggerServerEvent('Dobraziil:annoncerecrutement')
		end
		end)

	end, function()
	end)

	RageUI.IsVisible(RMenu:Get('gouv', 'ppa'), true, true, true, function()

		RageUI.Button("Attribuer le PPA (Permis port d'arme)",nil, {RightLabel = "~g~1500$"}, true, function(Hovered, Active, Selected)
			if Selected then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					TriggerServerEvent('donner:ppa')
					TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
				end
			end
		end)
	
	end, function()
	end)

Citizen.Wait(0)
end
end)

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then 
        --    RegisterNetEvent('esx_gouvjob:onDuty')
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('gouv', 'main'), not RageUI.Visible(RMenu:Get('gouv', 'main')))
            end
        end
        end
    end)

    RegisterNetEvent('openf6')
    AddEventHandler('openf6', function()
    RageUI.Visible(RMenu:Get('gouv', 'main'), not RageUI.Visible(RMenu:Get('gouv', 'main')))
    end)
    


		function demenotter()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local target, distance = ESX.Game.GetClosestPlayer()
            playerheading = GetEntityHeading(GetPlayerPed(-1))
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            local target_id = GetPlayerServerId(target)
            TriggerServerEvent('Dobraziil:requestrelease', target_id, playerheading, playerCoords, playerlocation)
            Wait(5000)
			TriggerServerEvent('Dobraziil:handcuff', GetPlayerServerId(closestPlayer))
		else
			ESX.ShowNotification('~r~Aucun joueurs à proximité')
			end
        end

		
local blips = {
	{title="Gouvernement", colour=0, id=419, x = -544.88, y = -204.84, z = 38.21}
}

Citizen.CreateThread(function()

for _, info in pairs(blips) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)
  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, 0.8)
  SetBlipColour(info.blip, info.colour)
  SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(info.title)
  EndTextCommandSetBlipName(info.blip)
end
end)