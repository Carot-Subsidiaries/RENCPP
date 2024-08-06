-- GET RENC WORKING --
getgenv().getplayers = function()
    local players = {}
    for _, x in pairs(game:GetService("Players"):GetPlayers()) do
        players[x.Name] = x
    end
    players["LocalPlayer"] = game:GetService("Players").LocalPlayer
    return players
end

getgenv().getplayer = function(name: string): Player
    return not name and getplayers()["LocalPlayer"] or getplayers()[name]
end

getgenv().getfps = function(): number -- credits: https://devforum.roblox.com/t/get-client-fps-trough-a-script/282631/14 idea: @clipflip.rblx
    local RunService = game:GetService("RunService")
    local FPS: number
    local TimeFunction = RunService:IsRunning() and time or os.clock

    local LastIteration: number, Start: number
    local FrameUpdateTable = {}

    local function HeartbeatUpdate()
        LastIteration = TimeFunction()
        for Index = #FrameUpdateTable, 1, -1 do
            FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
        end

        FrameUpdateTable[1] = LastIteration
        FPS = TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start)
    end

    Start = TimeFunction()
    RunService.Heartbeat:Connect(HeartbeatUpdate)
    task.wait(1.1)
    return FPS
end

getgenv().getping = function(): number -- idea: @clipflip.rblx
    return game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()
end

getgenv().runanimation = function(animationId: any, player: Player) -- @.wyv_
    local plr: Player = player or getplayer()
    local humanoid: Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. tostring(animationId)
        humanoid:LoadAnimation(animation):Play()
    end
end

getgenv().getdevice = function(): string -- @clipflip.rblx
    return tostring(game:GetService("UserInputService"):GetPlatform()):split(".")[3]
end

getgenv().getaffiliateid = function(): string
    return "none"
end

getgenv().customprint = function(text: string, properties: table, imageId: rbxasset) --[[ NOT RECOMMENDED ATM
    print(text)
    task.wait(.025)
    local msg = game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI:WaitForChild("MainView").ClientLog[tostring(#game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren())-1].msg
    for i, x in pairs(properties) do
        msg[i] = x
    end
    if imageId then msg.Parent.image.Image = imageId end
    ]]
end

getgenv().getlocalplayer = function(): Player
    return getplayer()
end

getgenv().join = function(placeID: number, jobID: string)
    game:GetService("TeleportService"):TeleportToPlaceInstance(placeID, jobID, getplayer())
end

getgenv().firetouchtransmitter = firetouchinterest
getgenv().playanimation = runanimation
getgenv().getplatform, getgenv().getos = getdevice, getdevice
getgenv().joingame, getgenv().joinserver = join, join
-- GET RENC WORKING --

local functions = {}

function functions:get(script: string, ...) -- made by @.wyv_
    local scripts = {
            "IY" = loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source')),
            "RENC" = loadstring(game:HttpGet('https://raw.githubusercontent.com/external-naming-convention/RobloxNamingStandard/main/RENCCheckEnv.lua')),
            "SECDEX" = loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true)),
            "DEX" = loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua")),
            "STATS" = function()
                local name, version = identifyexecutor()
                print("You are currently using " .. name .. " version " .. version .. ".")
                print("The game you're currently playing is " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " -- " .. game.PlaceId)
                print("The account you're currently using is " .. getplayer().Name .. " -- " .. game.Players.LocalPlayer.UserId)
                print("The operating system you're currently using is " .. getdevice())
            end
        }
    if scripts[script] then
        scripts[script](...)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "RENCPP Get";
            Text = "The script you tried to request couldn't be found.";
            Duration = 5;
        })
    end
end

return functions
