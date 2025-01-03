-- Set Map Name to Current AOP -- 
RegisterServerEvent("aop:start")
AddEventHandler("aop:start", function()
    Wait(5000)
    SetMapName("Current AOP: " .. "None Set")
end)

TriggerEvent("aop:start")

-- Set AOP Command -- 
RegisterCommand(Config.setaopCommand, function(source, args, raw)
        if IsPlayerAceAllowed(source, Config.acePerm) then 
        currentAOP = table.concat(args, " ")
        TriggerEvent("aop:sync")
        SetMapName("Current AOP : " .. currentAOP)
        TriggerClientEvent("aop:notification", -1, "New AOP: ~g~" .. currentAOP)
        else
        TriggerClientEvent("aop:notification", -1, "~r~You don't have permission to do that.")
        end
end)

-- Sync AOP between server and client -- 
RegisterServerEvent('aop:sync')
AddEventHandler('aop:sync', function()
    TriggerClientEvent('aop:sendaop', -1, currentAOP)
end)
