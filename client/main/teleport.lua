local busy = false
RegisterNetEvent('av_union:teleport', function(data)
    if busy then return end
    busy = true
    if not data then 
        print('[ERROR] NO COORDS PROVIDED (main/teleport.lua)') 
        return 
    end
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    Citizen.Wait(2000)
    SetEntityCoords(ped, data.x, data.y, data.z, false, false, false, true)
    SetEntityHeading(ped, data.heading)
    Citizen.Wait(1000)
    DoScreenFadeIn(2100)
    Wait(1000)
    busy = false
end)