trolleys = {}

RegisterServerEvent('av_union:spawnTrolleys', function()
    local src = source
    local player = GetPlayerPed(src)
    if #(GetEntityCoords(player) - vector3(-3.5310, -685.3057, 16.1309)) <= 20 and heist['vaultOpen'] then
        local temp_object = CreateObject(`hei_prop_hei_cash_trolly_01`, 5.061, -680.50, 15.13, 1, 0, 0) -- 1st Right
        while not DoesEntityExist(temp_object) do Wait(0) end
        Entity(temp_object).state.available = true
        trolleys[#trolleys+1] = temp_object
        temp_object = nil
        temp_object = CreateObject(`hei_prop_hei_cash_trolly_01`, 6.32, -674.99, 15.13, 1, 0, 0) -- 2nd Right
        while not DoesEntityExist(temp_object) do Wait(0) end
        Entity(temp_object).state.available = true
        trolleys[#trolleys+1] = temp_object
        temp_object = nil
        temp_object = CreateObject(`hei_prop_hei_cash_trolly_01`, -6.13, -676.20, 15.13, 1, 0, 0) -- 1st Left
        while not DoesEntityExist(temp_object) do Wait(0) end
        Entity(temp_object).state.available = true
        trolleys[#trolleys+1] = temp_object
        temp_object = nil
        temp_object = CreateObject(`hei_prop_hei_cash_trolly_01`, -3.97, -671.06, 15.13, 1, 0, 0) -- 2nd Left
        while not DoesEntityExist(temp_object) do Wait(0) end
        Entity(temp_object).state.available = true
        trolleys[#trolleys+1] = temp_object
    else
        banPlayer(src, 'av_union:spawnTrolleys')
    end
end)

RegisterServerEvent('av_union:deleteTrolley', function(netId)
    local src = source
    local player = GetPlayerPed(src)
    if #(GetEntityCoords(player) - vector3(-0.2695, -675.1189, 16.1308)) <= 50 and heist['vaultOpen'] then
        for k, v in pairs(trolleys) do
            local temp_id = NetworkGetNetworkIdFromEntity(v)
            if temp_id and temp_id ~= 0 then
                if temp_id == netId then
                    if DoesEntityExist(v) then
                        local newCoords = GetEntityCoords(v) + vector3(0.0, 0.0, - 0.49)
                        local newRotation = GetEntityRotation(v)
                        while DoesEntityExist(v) do
                            DeleteEntity(v)
                            Wait(5)
                        end
                        trolleys[k] = CreateObject(`hei_prop_hei_cash_trolly_03`, newCoords, true, false, false)
                        SetEntityRotation(NewTrolley, newRotation)
                        local reward = math.random(Config.Reward['min'], Config.Reward['max'])
                        addMoney(src, Config.MoneyAccount, reward)
                        TriggerClientEvent('av_union:notification',src,Lang['you_received']..reward,'success')
                    end
                end
            end
        end
    else
        banPlayer(src, 'av_union:deleteTrolley')
    end
end)