lib.callback.register('av_union:hasItem', function(source, item, amount)
    return hasItem(source,item,amount)
end)

lib.callback.register('av_union:removeItem', function(source, item, amount)
    return removeItem(source,item,amount)
end)

lib.callback.register('av_union:validTrolley', function(source, netId)
    local trolley = NetworkGetEntityFromNetworkId(netId)
    local res = false
    if trolley then
        if Entity(trolley).state.available then
            Entity(trolley).state.available = false
            res = true
        end
    end
    return res
end)
