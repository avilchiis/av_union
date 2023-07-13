doors = Config.Doors

RegisterServerEvent('av_union:updateDoor', function(id)
    if doors[id] then
        doors[id]['locked'] = not doors[id]['locked']
        TriggerClientEvent('av_union:doors',-1,id,doors[id]['locked'])
    end
end)