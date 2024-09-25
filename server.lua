ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('checkAdminAndJobCounts', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local adminCount = 0
    local supporterCount = 0
    local einreiseCount = 0

    for _, playerId in ipairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer then
            if xPlayer.getGroup() == 'admin' then
                adminCount = adminCount + 1
            end

            if xPlayer.getGroup() == 'supporter' then
                supporterCount = supporterCount + 1
            end

            if xPlayer.getJob().name == 'einreise' then
                einreiseCount = einreiseCount + 1
            end
        end
    end

    cb(adminCount, supporterCount, einreiseCount)
end)

ESX.RegisterServerCallback('checkPlayerPermission', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'supporter' then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)


