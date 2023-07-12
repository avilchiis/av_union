RegisterNetEvent('av_union:notification',function(msg,type,duration)
    local duration = duration or 3500
    lib.notify({
        title = 'Union Heist',
        description = msg,
        type = type,
        duration = duration
    })
end)