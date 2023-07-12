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

for k, v in pairs(points) do
    function v:onExit()
        if lib.isTextUIOpen() then
            lib.hideTextUI()
        end
    end
    
    function v:nearby()
        if self.currentDistance <= self.distance and self.canInteract() then
            if not lib.isTextUIOpen() then
                lib.showTextUI(self.label)
            end
            if IsControlJustPressed(0,self.key) then
                TriggerEvent(self.event, self.args)
            end
        end
    end
end