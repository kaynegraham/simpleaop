local currentAOP = "None Set"
local aopSet = false 

-- Let Player Know of AOP when they join --
AddEventHandler('playerSpawned', function()
    CreateThread(function()
        while not aopSet do
            DrawAOP(Config.x, Config.y, 1.0, 0.5, "AOP: " .. "None Set", 255, 255 ,255 ,255)
            Wait(1)
        end
    end)
    TriggerEvent("chat:addMessage", { args = { "~r~ Current AOP: ", currentAOP}})
end)

-- Notify Players of AOP Change -- 
RegisterNetEvent('aop:notification')
AddEventHandler('aop:notification', function(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text) 
    EndTextCommandDisplayHelp(0, 0, 1 -1)
end)

-- View Current AOP --
RegisterCommand(Config.viewaopCommand, function()
    TriggerEvent("chat:addMessage", { args = { "~r~ Current AOP: ", currentAOP}})
end)

-- Send AOP to Server -- 
RegisterNetEvent('aop:sendaop')
AddEventHandler('aop:sendaop', function(newAOP)
    currentAOP = newAOP
    CreateThread(function()
        while true do 
        Wait(1)
        DrawAOP(Config.x, Config.y, 1.0, 0.5, "AOP: " .. currentAOP, 255, 255 ,255 ,255)
        aopSet = true
        end
    end)
end)

-- Add Suggestions -- 
CreateThread(function()
    while true do 
        -- Add Suggestion for Set AOP Command --
TriggerEvent('chat:addSuggestion', '/' .. Config.setaopCommand, "Set the AOP", {
    { name = "AOP Location", help = "The Location for AOP to be"}
})

-- Add Suggestion for View AOP Command --
TriggerEvent('chat:addSuggestion', '/' .. Config.viewaopCommand, "View the Current AOP")
    Wait(10000)
end
end)

-- Draw AOP -- 
function DrawAOP(x, y,height,scale,text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r,g,b,a)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline() 
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - 1.0/2, y - height/2 + 0.005)
end