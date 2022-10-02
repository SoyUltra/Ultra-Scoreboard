-- ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
local QBCore = nil
local ESX = nil
local PlayerData = nil
local ped, pid, Player, playerId, player
local OpenMenu = false

-- Start Frameworksw

if Config.Framework == "QBCORE" then
    QBCore = exports["qb-core"]:GetCoreObject()
    PlayerData = QBCore.Functions.GetPlayerData()
    SendNUIMessage({
        action = 'updatedata',
        pid = 0,
        phone = 'Loading',
        job = 'Loading',
        name = 'Loading',
        bank = 'Loading',
        logo = Config.Logo,
        playerss = 'Loading',
        maxPlayers = Config.MaxPlayers,
    })
elseif Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    SendNUIMessage({
        action = 'updatedata',
        pid = 0,
        phone = 'Loading',
        job = 'Loading',
        name = 'Loading',
        bank = 'Loading',
        logo = Config.Logo,
        playerss = 'Loading',
        maxPlayers = Config.MaxPlayers,
    })
else
    -- Your own framework
end

--Data Extra Start
if Config.Framework == "QBCORE" then
--Extra DATA QBCORE PLAYER CHANGE CHARACTER
    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
        PlayerData = {}
    end)
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
    AddEventHandler("QBCore:Client:OnPlayerLoaded", function ()
        PlayerData = {}
    end)
   
elseif Config.Framework == "ESX" then
--Extra ESX
else
--Other framework your own code
end
--Data Extra End

---Keyboard
RegisterKeyMapping(Config.OpenScore, Config.KeyName, 'keyboard', Config.KeyOpen)
TriggerEvent('chat:addSuggestion', Config.OpenScore, Config.ChatCommandSuggest)

--Function OnKey
RegisterCommand(Config.OpenScore,function ()
    OpenMenu = not OpenMenu
    if OpenMenu then
        SetNuiFocus(true, true) 
        SendNUIMessage({ action = 'show'})
        SendNUIMessage({ action = 'bottom'})
        if Config.UseRobberys == true then
            SendNUIMessage({ action = 'showrobbery'})
        end
    else
        SetNuiFocus(false, false)
        SendNUIMessage({action = 'hide'})
    end

    if Config.Framework == "QBCORE" then
            QBCore.Functions.TriggerCallback('Ultra-Scoreboard:CurrentPlayers', function(oPlayers)
                ped = PlayerPedId()
                pid = GetPlayerServerId(PlayerId())
                PlayerData = QBCore.Functions.GetPlayerData()    
                playerId = PlayerId()
                SendNUIMessage({
                    action = 'updatedata',
                    pid = pid,
                    phone = PlayerData.charinfo.phone,
                    job = PlayerData.job.label or Config.NoJob,
                    name = PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname,
                    bank = Config.TypeIconMoney ..GroupDigits(PlayerData.money['bank']),
                    logo = Config.Logo,
                    playerss = oPlayers,
                    maxPlayers = Config.MaxPlayers,
                })
            end)
            QBCore.Functions.TriggerCallback('Ultra-Scoreboard:CurrentJobs', function(police, ambulance, mechanic, realestate, taxi, abogado)
                ped = PlayerPedId()
                pid = GetPlayerServerId(PlayerId())
                PlayerData = QBCore.Functions.GetPlayerData()    
                playerId = PlayerId()

                SendNUIMessage({
                    action = 'updatedatajob',
                    mechanic = mechanic,
                    police = police,
                    ambulance = ambulance,
                    realestate = realestate,
                    taxi = taxi,
                    abogado = abogado,
                    robos = Config.RobList,
                })

                -- ✓ ✘
            end)

            
    elseif Config.Framework == "ESX" then
        ESX.PlayerData = ESX.GetPlayerData()
                local player = PlayerId()
                local pid  = GetPlayerServerId(player)
                local playersList = 0
                for i = 1, #ESX.PlayerData.accounts, 1 do
                    if ESX.PlayerData.accounts[i].name == "bank" then
                        bank = ESX.PlayerData.accounts[i].money
                    end
                end
                ESX.TriggerServerCallback('Ultra-Scoreboard:CurrentJobs', function(police, ambulance, mechanic, realestate, taxi, abogado, oPlayers, rpName ,rPhone)
                    SendNUIMessage({
                        action = 'updatedatajob',
                        mechanic = mechanic,
                        police = police,
                        ambulance = ambulance,
                        realestate = realestate,
                        taxi = taxi,
                        abogado = abogado,
                        robos = Config.RobList,
                    })
                    SendNUIMessage({
                        action = 'updatedata',
                        pid = pid,
                        phone = rPhone,
                        job = ESX.PlayerData.job.label or Config.NoJob,
                        name = rpName,
                        bank = Config.TypeIconMoney ..ESX.Math.GroupDigits(bank),
                        logo = Config.Logo,
                        playerss = oPlayers,
                        maxPlayers = Config.MaxPlayers,
                    })
                end)
              

    end
end)

RegisterNUICallback("exit" , function(data, cb)
    OpenMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'hide'})
end)

--Other functions 

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

GroupDigits = function(value)
    local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1' .. ','):reverse())..right
end

--- Comunity functions 
local mwait = 1000
if Config.UseRobberys == false then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(mwait)
        if OpenMenu then
            mwait = 5
        else 
            mwait = 1000
        end
        if IsDisabledControlJustReleased(0, 200) then
                       -- print("HI")
                        OpenMenu = false
                        SetNuiFocus(false, false)
                        SendNUIMessage({action = 'hide'})
        end
        if IsControlJustReleased(0, 177) or  IsControlJustReleased(0, 202) then
                --print("HI")
                OpenMenu = false
                SetNuiFocus(false, false)
                SendNUIMessage({action = 'hide'})
        end
    end    
end)
end