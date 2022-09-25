-- ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
                                                    

local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local ped, pid, Player, playerId, player


RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function ()
    PlayerData = {}
end)

GroupDigits = function(value)
    local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1' .. ','):reverse())..right
end


Citizen.CreateThread(function ()
    while true do 
        Wait(500)
        if LocalPlayer.state.isLoggedIn then
            
            QBCore.Functions.GetPlayerData(function(PlayerData)
                QBCore.Functions.TriggerCallback('Ultra-Scoreboard:CurrentPlayers', function(player)
                    ped = PlayerPedId()
                    pid = GetPlayerServerId(PlayerId())
                    Player = QBCore.Functions.GetPlayerData()    
                    playerId = PlayerId()

                    SendNUIMessage({
                        action = 'updatedata',
                        pid = pid,
                        phone = Player.charinfo.phone,
                        job = Player.job.label or Config.NoJob,
                        name = Player.charinfo.firstname.. " " ..PlayerData.charinfo.lastname,
                        cid = PlayerData.citizenid,
                        bank = Config.TypeIconMoney ..GroupDigits(Player.money['bank']),
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

local function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            players[#players+1] = player
        end
    end
    return players
end

RegisterKeyMapping(Config.OpenScore, Config.KeyName, 'keyboard', Config.KeyOpen)

TriggerEvent('chat:addSuggestion', Config.OpenScore, Config.ChatCommandSuggest)

RegisterCommand(Config.OpenScore,function ()
    SetNuiFocus(true, true) 
    SendNUIMessage({
        action = 'show'
    })
end)

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'hide'
    })
end)


