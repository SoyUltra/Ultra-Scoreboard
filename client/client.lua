-- ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

local QBCore = exports["qb-core"]:GetCoreObject()

local scoreboardOpen = false
local PlayerOptin = {}

local function IDShowingDrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function IDShowingGetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            players[#players+1] = player
        end
    end
    return players
end

local function IDShowingGetPlayersFromCoords(coords, distance)
    local players = IDShowingGetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(PlayerPedId())
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
		if targetdistance <= distance then
            closePlayers[#closePlayers+1] = player
		end
    end

    return closePlayers
end

local function GroupDigits(value)
    local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1' .. ','):reverse())..right
end

RegisterKeyMapping(Config.OpenScore, Config.KeyName, 'keyboard', Config.KeyOpen)

TriggerEvent('chat:addSuggestion', Config.OpenScore, Config.ChatCommandSuggest)

RegisterCommand(Config.OpenScore,function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'show'
    })
    if scoreboardOpen == true then
        scoreboardOpen = false
    elseif scoreboardOpen == false then
        QBCore.Functions.TriggerCallback('Ultra-Scoreboard:server:GetPlayersArrays', function(playerList)
            PlayerOptin = playerList
            scoreboardOpen = true
        end)
    end
end)

RegisterNUICallback("exit" , function(_)
    SetNuiFocus(false, false)
    scoreboardOpen = false
    SendNUIMessage({
        action = 'hide'
    })
end)

Citizen.CreateThread(function ()
    while true do
        Wait(500)
        if LocalPlayer.state.isLoggedIn then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                QBCore.Functions.TriggerCallback('Ultra-Scoreboard:CurrentPlayers', function(player)
                    local pid = GetPlayerServerId(PlayerId())
                    SendNUIMessage({
                        action = 'updatedata',
                        pid = pid,
                        phone = PlayerData.charinfo.phone,
                        job = PlayerData.job.label or Config.NoJob,
                        name = PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname,
                        bank = Config.TypeIconMoney ..GroupDigits(PlayerData.money['bank']),
                        logo = Config.Logo,
                        playerss = player,
                        maxPlayers = Config.MaxPlayers,
                    })
                end)
            end)
        else
            SendNUIMessage({action = 'hide'})
        end
        Wait(500)
    end
end)

Citizen.CreateThread(function ()
    while true do
        Wait(500)
        QBCore.Functions.TriggerCallback('Ultra-Scoreboard:CurrentPlayers2', function(police, ambulance, mechanic, realestate, taxi, abogado)
            SendNUIMessage({
                action = 'updatedatajob',
                mechanic = mechanic,
                police = police,
                ambulance = ambulance,
                realestate = realestate,
                taxi = taxi,
                abogado = abogado,
            })
        end)
        Wait(500)
    end
end)

CreateThread(function()
    while true do
        local loop = 1000
        if scoreboardOpen == true then
            for _, player in pairs(IDShowingGetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 6.5)) do
                local PlayerId = GetPlayerServerId(player)
                local PlayerPed = GetPlayerPed(player)
                local PlayerCoords = GetEntityCoords(PlayerPed)
                if PlayerOptin[PlayerId].permission then
                    loop = 0
                    IDShowingDrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '['..PlayerId..']')
                end
            end
        end
        Wait(loop)
    end
end)
