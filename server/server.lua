
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('Ultra-Scoreboard:CurrentPlayers', function(_, cb)
    local TotalPlayers = 0

    for _ in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end

    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('Ultra-Scoreboard:server:GetPlayersArrays', function(_, cb)
    local players = {}
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        players[v.PlayerData.source] = {}
        players[v.PlayerData.source].permission = QBCore.Functions.IsOptin(v.PlayerData.source)
    end
    cb(players)
end)

QBCore.Functions.CreateCallback('Ultra-Scoreboard:CurrentPlayers2', function(_, cb)
    local MechanicCount = 0
    local PoliceCount = 0
    local AmbulanceCount = 0
    local RealestateCount = 0
    local TaxiCount = 0
    local AbogadoCount = 0

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)

        if Player.PlayerData.job.name == "mechanic" then
            MechanicCount = MechanicCount + 1
        end

        if Player.PlayerData.job.name == "police" then
            PoliceCount = PoliceCount + 1
        end

        if Player.PlayerData.job.name == "ambulance" then
            AmbulanceCount = AmbulanceCount + 1
        end

        if Player.PlayerData.job.name == "realestate" then
            RealestateCount = RealestateCount + 1
        end

        if Player.PlayerData.job.name == "taxi" then
            TaxiCount = TaxiCount + 1
        end

        if Player.PlayerData.job.name == "abogado" then
            AbogadoCount = AbogadoCount + 1
        end
    end

    cb(PoliceCount, AmbulanceCount, MechanicCount, RealestateCount, TaxiCount, AbogadoCount)
end)