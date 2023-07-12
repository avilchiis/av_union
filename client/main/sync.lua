heist = {}
loaded = false

RegisterNetEvent('av_union:sync', function(data)
    heist = data
    if not heist['vaultOpen'] then
        if IsAlarmPlaying('BIG_SCORE_HEIST_VAULT_ALARMS') then
            StopAlarm('BIG_SCORE_HEIST_VAULT_ALARMS', 1)
        end
    end
end)