ESX = exports['es_extended']:getSharedObject()

local adminCount, supporterCount, einreiseCount = 0, 0, 0
local displayAdminInfo = false

RegisterCommand("admininfo", function()
    ESX.TriggerServerCallback('checkPlayerPermission', function(hasPermission)
        if hasPermission then
            displayAdminInfo = not displayAdminInfo
            if displayAdminInfo then
                ESX.ShowNotification("Admin-Info Anzeige aktiviert")
            else
                ESX.ShowNotification("Admin-Info Anzeige deaktiviert")
            end
        else
            ESX.ShowNotification("Du hast keine Berechtigung, diese Information anzuzeigen.")
        end
    end)
end, false)

Citizen.CreateThread(function()
    while true do
        if displayAdminInfo then
            ESX.TriggerServerCallback('checkAdminAndJobCounts', function(admins, supporters, einreise)
                adminCount = admins
                supporterCount = supporters
                einreiseCount = einreise
            end)
        end
        Citizen.Wait(5000) -- 5 sekunden
    end
end)

Citizen.CreateThread(function()
    while true do
        if displayAdminInfo then
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.45, 0.45)
            SetTextColour(255, 255, 255, 255)
            SetTextEntry("STRING")
            AddTextComponentString(string.format("Admins: %d\nSupporter: %d\nEinreise: %d", adminCount, supporterCount, einreiseCount))
            DrawText(0.020, 0.070)
        end
        Citizen.Wait(0)
    end
end)


