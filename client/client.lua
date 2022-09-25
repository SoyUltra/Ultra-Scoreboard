-- ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
                                                    
Citizen.CreateThread(function ()
    while true do 
        Wait(500)
        ESX.TriggerServerCallback('Ultra-Scoreboard:CurrentPlayers', function(player,name)
            local playerId = GetPlayerServerId(PlayerId())
            local bank

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == "bank" then
                    bank = ESX.PlayerData.accounts[i].money
                end
            end

            SendNUIMessage({
                action = 'updatedata',
                pid = playerId,
                job = ESX.PlayerData.job.label or Config.NoJob,
                name = name,
                bank = Config.TypeIconMoney ..ESX.Math.GroupDigits(bank),
                logo = Config.Logo,
                playerss = player,
                maxPlayers = Config.MaxPlayers,
            })
        end)
    Wait(500)
    end
end)

Citizen.CreateThread(function ()
    while true do 
        Wait(500)
        ESX.TriggerServerCallback('Ultra-Scoreboard:CurrentPlayers2', function(police, ambulance, mechanic, realestate, taxi, abogado)
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


