local busy = false
RegisterNetEvent('av_union:teleport', function(data)
    if busy then return end
    if not data then 
        print('[ERROR] NO COORDS PROVIDED (main/teleport.lua)')
        return 
    end
    busy = true
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(2000)
    SetEntityCoords(ped, data.x, data.y, data.z, false, false, false, true)
    SetEntityHeading(ped, data.heading)
    Wait(1000)
    DoScreenFadeIn(2100)
    Wait(1000)
    busy = false
end)