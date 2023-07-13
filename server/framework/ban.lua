function banPlayer(source,event)
    -- Add your custom ban event/export here...
    print('Player '..GetPlayerName(source)..' was caught cheating(?), triggered event: '..event)
    DropPlayer(source, "Ouch you got caught :(")
end