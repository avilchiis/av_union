function hackMinigame() -- Used to hack vault
    local waiting = true
    local res = false
    exports['ps-ui']:Scrambler(function(success)
        res = success
        waiting = false
    end, "numeric", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
    while waiting do Wait(100) end
    return res
end