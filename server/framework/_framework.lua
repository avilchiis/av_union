if Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Commands.Add(Config.Command, 'Restart the Union Heist', {}, false, function(source)
        WipeHeist()
    end, Config.AdminLevel)
end

if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
    ESX.RegisterCommand(Config.Command, Config.AdminLevel, function()
        WipeHeist()
    end, false, { help = 'Restart the Union Heist'})
end