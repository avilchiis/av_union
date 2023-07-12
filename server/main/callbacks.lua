lib.callback.register('av_union:hasItem', function(source, item, amount)
    return hasItem(source,item,amount)
end)

lib.callback.register('av_union:removeItem', function(source, item, amount)
    return removeItem(source,item,amount)
end)
