heist = {}
loaded = false

RegisterNetEvent('av_union:sync', function(data,doors)
    heist = data
    if doors then
        Config.Doors = doors
        for k, v in pairs(doors) do
            AddDoorToSystem(k, v['model'], v['coords']['x'], v['coords']['y'], v['coords']['z'], 0, 1, 0)
            DoorSystemSetDoorState(k, v['locked'] and 1 or 0)
        end
    end
    if not heist['vaultOpen'] then
        if IsAlarmPlaying('BIG_SCORE_HEIST_VAULT_ALARMS') then
            StopAlarm('BIG_SCORE_HEIST_VAULT_ALARMS', 1)
        end
    end
end)

RegisterNetEvent('av_union:doors', function(id, state)
    DoorSystemSetDoorState(id, state and 1 or 0)
	Config.Doors[id]['locked'] = state
end)