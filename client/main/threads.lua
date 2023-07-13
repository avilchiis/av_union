CreateThread(function()
    local alreadyClose = false
    while not loaded do Wait(1000) end
    while IsScreenFadedOut() do Wait(1000) end
    while true do
        local close = false
        if #(GetEntityCoords(PlayerPedId()) - vector3(0.3161, -677.2463, 16.1308)) <= 80 then
            close = true
            if heist['vaultOpen'] and not alreadyClose then
                local vault = GetClosestObjectOfType(-1.727947, -686.5417, 16.68913, 2.0, `v_ilev_fin_vaultdoor`, false, false, false)
                if vault and vault ~= 0 then
                    if GetEntityHeading(vault) < 300 then
                        OpenVault(vault,true)
                    end
                end
            end
            if heist['tunnelOpen'] and not alreadyClose then
                local handle = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_tunnel")
                local handle2 = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, "des_finale_vault")
                if (GetStateOfRayfireMapObject(handle) == 3 or GetStateOfRayfireMapObject(handle2) == 3) then
                    SetStateOfRayfireMapObject(handle, 4)
                    SetStateOfRayfireMapObject(handle2, 4)
                    Wait(100)
                    SetStateOfRayfireMapObject(handle, 9)
                    SetStateOfRayfireMapObject(handle2, 9)
                    Citizen.CreateThread(function()
                        Wait(10)
                        while GetRayfireMapObjectAnimPhase(handle) > 0.0 do
                            Wait(0)
                        end
                        while GetRayfireMapObjectAnimPhase(handle2) > 0.0 do
                            Wait(0)
                        end
                    end)
                end
            end
        end
        if close and not alreadyClose then
            alreadyClose = true
        end
        if not close and alreadyClose then
            alreadyClose = false
        end
        Wait(2000)
    end
end)