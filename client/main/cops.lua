function isCop()
    local job = GetJob().name
    return Config.PoliceJob[job]
end