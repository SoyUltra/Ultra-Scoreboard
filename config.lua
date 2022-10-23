-- ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
                                               
Config = {}

Config.Framework = "QBCORE"             -- QBCORE o ESX
Config.Debug     = false                 -- Debug mode
Config.Logo =                           "https://i.imgur.com/yduIdh7.png" 

Config.OpenScore =                      "scoreboard"
Config.ChatCommandSuggest =             "Open Scoreboard"
Config.KeyOpen =                        "F10"
Config.KeyName =                        "Open Scorebaord"

Config.MaxPlayers =                     GetConvarInt('sv_maxclients', 70)
Config.TypeIconMoney =                  " $"

Config.NoJob =                          "unemployed"
Config.NoGang =                          "Ninguna"
Config.UseRobberys = true

--!!WARNING!! 
-- The Label is not working yet, I only put it to make an order guide! 
-- if you want to change the rob you have to change it in the html

Config.RobList = {
    {order = 1 , label = 'FLEECA',          requieredCops = 3},
    {order = 2 , label = 'PACIFIC BANK',    requieredCops = 2},
    {order = 3 , label = 'VANGELICO',       requieredCops = 6},
    {order = 4 , label = 'STORE',           requieredCops = 3},
    {order = 5 , label = 'HUMANE LABS',     requieredCops = 4},
    {order = 6 , label = 'BOBCAT',          requieredCops = 5},
    {order = 7 , label = 'UNION',           requieredCops = 3},
    {order = 8 , label = 'YACHT',           requieredCops = 2},
    {order = 9 , label = 'VANT',            requieredCops = 1},
}
