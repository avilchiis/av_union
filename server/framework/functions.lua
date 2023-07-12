-- Remove Item from Player
function removeItem(src, item, amount)
    local amount = amount or 1
    if Config.Framework == "QBCore" then
        exports[Config.Inventory]:RemoveItem(src, item, amount)
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        exports[Config.Inventory]:RemoveItem(src, item, amount)
    else
        -- Add your own check here :)
    end
end

-- Has item?
function hasItem(src,name,amount)
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            local item = exports.ox_inventory:GetItem(src, name, nil, true)
            if item and tonumber(item) >= qty then
                return true 
            end
        else
            return exports[Config.Inventory]:HasItem(src,name,qty)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] >= qty then
            return true
        end
    else
        -- Add your own check here :)
    end
    return false
end

-- Add Money
function addMoney(src, account, amount)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddMoney(account,amount)
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addAccountMoney(account,amount)
    else
        -- Add your own function here :)
    end
end