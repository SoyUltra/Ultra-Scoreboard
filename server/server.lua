local QBCore = nil
local ESX = nil
local PoliceCount = 0
local playerPhones = {}
if Config.Framework == "ESX" then
print("^4 Ultra Scoreboard Started: ESX Mode Configured^0")
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    ESX.RegisterServerCallback('Ultra-Scoreboard:CurrentJobs', function(source, cb)
        local players = ESX.GetExtendedPlayers()
        local MechanicCount = 0
        local AmbulanceCount = 0
        local RealestateCount = 0
        local TaxiCount = 0
        local AbogadoCount = 0
        PoliceCount = 0
        local TotalPlayers = 0
        for _, xPlayer in pairs(players) do
            TotalPlayers = TotalPlayers + 1
            if xPlayer.job.name == "mechanic" then
                MechanicCount = MechanicCount + 1
            elseif xPlayer.job.name == "police" then
                PoliceCount = PoliceCount + 1
            elseif xPlayer.job.name == "ambulance" then
                AmbulanceCount = AmbulanceCount + 1
            elseif xPlayer.job.name == "realestateagent" then
                RealestateCount = RealestateCount + 1
            elseif xPlayer.job.name == "taxi" then
                TaxiCount = TaxiCount + 1
            elseif xPlayer.job.name == "banker" then
                AbogadoCount = AbogadoCount + 1
            end
        end
        local xPlayersMe = ESX.GetPlayerFromId(source)
        local rpName = xPlayersMe.getName()
        local rPhone = "ERROR"
        local license = xPlayersMe.identifier
        if playerPhones[source] ~= nil then
            rPhone = playerPhones[source]
            if Config.Debug then print("SAVED") end
        else
            if Config.Debug then print("MYSQL") end
                MySQL.query('SELECT * FROM users WHERE identifier = @license LIMIT 1',{["@license"] = license}, function(result)
                    playerPhones[source] = result[1].phone_number
                    rPhone = playerPhones[source]
                end)
                rPhone = playerPhones[source]
                Citizen.Wait(250)                
        end
        cb(PoliceCount, AmbulanceCount, MechanicCount, RealestateCount, TaxiCount, AbogadoCount, TotalPlayers, rpName, rPhone)
    end)

elseif Config.Framework == "QBCORE" then
    print("^3 Ultra Scoreboard Started: QB-Core Mode Configured^0")
    QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateCallback('Ultra-Scoreboard:CurrentPlayers', function(source, cb)
       local TotalPlayers = 0
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            TotalPlayers = TotalPlayers + 1
        end
        cb(TotalPlayers)
    end)

    QBCore.Functions.CreateCallback('Ultra-Scoreboard:CurrentJobs', function(source, cb)
        local MechanicCount = 0
        local Mechanic2Count = 0
        local AmbulanceCount = 0
        local RealestateCount = 0
        local TaxiCount = 0
        local AbogadoCount = 0
        PoliceCount = 0
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)

            if Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty then
                MechanicCount = MechanicCount + 1
            elseif Player.PlayerData.job.name == "mechanic2" and Player.PlayerData.job.onduty then
                Mechanic2Count = Mechanic2Count + 1
            elseif Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                PoliceCount = PoliceCount + 1
            elseif Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty then
                AmbulanceCount = AmbulanceCount + 1
            elseif Player.PlayerData.job.name == "taxi" and Player.PlayerData.job.onduty then
                TaxiCount = TaxiCount + 1
            elseif Player.PlayerData.job.name == "realestate" and Player.PlayerData.job.onduty then
                RealestateCount = RealestateCount + 1
            elseif Player.PlayerData.job.name == "abogado" and Player.PlayerData.job.onduty then
                AbogadoCount = AbogadoCount + 1
            end
        end
        cb(PoliceCount, AmbulanceCount, MechanicCount, RealestateCount, TaxiCount, AbogadoCount)
    end)

end

