CreateThread(function()
    while Config.Framework == "ESX" then
        local currentCops = 0
        for k, v in pairs(Config.PoliceJob) do
            local xPlayers = ESX.GetExtendedPlayers("job", k)
            if xPlayers then
                currentCops += #xPlayers
            end
        end
        TriggerClientEvent("police:SetCopCount", -1, currentCops)
        Wait(5 * 60 * 1000) -- verify cops count every 5 minutes
    end
end)