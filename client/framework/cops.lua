currentCops = 0

RegisterNetEvent('police:SetCopCount', function(amount)
    currentCops = amount
end)

function isCop()
    local job = GetJob().name
    return Config.PoliceJob[job]
end

function enoughCops()
    return currentCops >= Config.MinCops
end