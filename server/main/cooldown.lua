startedTime = nil
CreateThread(function()
    while true do
        if startedTime then
            local currentTime = os.time()
            local time = startedTime - currentTime
            if time <= 0 then
                startedTime = nil
                WipeHeist()
            end
        end
        Wait(1 * 60 * 1000)
    end
end)