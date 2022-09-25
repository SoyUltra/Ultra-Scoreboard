ESX.RegisterServerCallback('Ultra-Scoreboard:CurrentPlayers', function(source, cb)
    local players = ESX.GetExtendedPlayers()

    cb(#players)
end)

ESX.RegisterServerCallback('Ultra-Scoreboard:CurrentPlayers2', function(source, cb)
    local players = ESX.GetExtendedPlayers()
    
    local MechanicCount = 0
    local PoliceCount = 0
    local AmbulanceCount = 0
    local RealestateCount = 0
    local TaxiCount = 0
    local AbogadoCount = 0

    for _, xPlayer in pairs(players) do
        if xPlayer.job.name == "mechanic" then
            MechanicCount = MechanicCount + 1
        elseif xPlayer.job.name == "police" then
            PoliceCount = PoliceCount + 1
        elseif xPlayer.job.name == "ambulance" then
            AmbulanceCount = AmbulanceCount + 1
        elseif xPlayer.job.name == "realestate" then
            RealestateCount = RealestateCount + 1
        elseif xPlayer.job.name == "taxi" then
            TaxiCount = TaxiCount + 1
        elseif xPlayer.job.name == "abogado" then
            AbogadoCount = AbogadoCount + 1
        end
    end
    cb(PoliceCount, AmbulanceCount, MechanicCount, RealestateCount, TaxiCount, AbogadoCount)
end)
