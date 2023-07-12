function hasItem(name,amount)
    if not name then print('^2[ERROR] Function hasItem() received null as argument') return false end
    local amount = amount or 1
    return lib.callback.await('av_union:hasItem', false, name, amount)
end

function removeItem(name,amount)
    if not name then print('^2[ERROR] Function removeItem() received null as argument') return false end
    local amount = amount or 1
    return lib.callback.await('av_union:removeItem', false, name, amount)
end