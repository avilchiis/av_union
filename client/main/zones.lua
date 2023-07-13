local points = {}

for k, v in pairs(allZones) do
    points[#points+1] = lib.points.new({
        label = v['label'],
        event = v['event'],
        coords = v['coords'],
        distance = v['distance'],
        canInteract = v['canInteract'],
        key = v['key'],
        args = v['args'],
    })
end

for k, v in pairs(Config.Doors) do
    points[#points+1] = lib.points.new({
        event = "av_union:door",
        coords = {v['coords'][1], v['coords'][2], v['coords'][3]},
        distance = 1.5,
        canInteract = function() return Config.Doors[k]['locked'] end,
        key = 38,
        args = k,
    })
end

for k, v in pairs(points) do
    function v:onExit()
        if lib.isTextUIOpen() then
            lib.hideTextUI()
        end
        if currentTrolley then
            currentTrolley = false
        end
    end
    
    function v:nearby()
        if self.currentDistance <= self.distance and self.canInteract() then
            if not lib.isTextUIOpen() and not inAnimation then
                if self.label then
                    lib.showTextUI(self.label)
                else
                    if Config.Doors[self.args]['locked'] then
                        lib.showTextUI(Lang['plant_thermite'])
                    end
                end
            end
            if IsControlJustPressed(0,self.key) then
                TriggerEvent(self.event, self.args)
            end
        end
    end
end