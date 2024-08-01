-- GET RENC WORKING --
getgenv().getplayers = getplayers or function()
  local players = {}
  for _, x in pairs(game:GetService("Players"):GetPlayers()) do
    players[x.Name] = x
  end
  players["LocalPlayer"] = game:GetService("Players").LocalPlayer
  return players
end

getgenv().getplayer = getplayer or function(name: string)
  return not name and getplayers()["LocalPlayer"] or getplayers()[name]
end

getgenv().getfps = getfps or function(suffix: boolean) -- @clipflip.rblx
    local rawfps = game:GetService("Stats").Workspace.Heartbeat:GetValue()
    local fpsnum = tonumber(rawfps)
    local fps = tostring(math.round(fpsnum))
    return not suffix and fps or fps.." fps"
end

getgenv().getping = runanimation or function(suffix: boolean) -- @clipflip.rblx
    local rawping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingstr = rawping:sub(1,#rawping-7)
    local pingnum = tonumber(pingstr)
    local ping = tostring(math.round(pingnum))
    return not suffix and ping or ping.." ms"
end

getgenv().runanimation = runanimation or function(animationId, player) -- @.wyv_
    local plr = player or getplayer()
    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. tostring(animationId)
        humanoid:LoadAnimation(animation):Play()
    end
end

getgenv().getdevice = getdevice or function() -- @clipflip.rblx
    local inputsrv = game:GetService("UserInputService")
        if inputsrv:GetPlatform() == Enum.Platform.Windows then
            return 'Windows'
        elseif inputsrv:GetPlatform() == Enum.Platform.OSX then
            return 'macOS'
        elseif inputsrv:GetPlatform() == Enum.Platform.IOS then
            return 'iOS'
        elseif inputsrv:GetPlatform() == Enum.Platform.UWP then
            return 'Windows (Microsoft Store)'
        elseif inputsrv:GetPlatform() == Enum.Platform.Android then
            return 'Android'
    else return 'Unknown'
    end
end

getgenv().getaffiliateid = getaffiliateid or function()
  return "moREnc"
end

getgenv().customprint = customprint or function(text: string, properties: table, imageId: rbxasset)
    print(text)
    task.wait(.025)
    local msg = game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI:WaitForChild("MainView").ClientLog[tostring(#game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren())-1].msg
    for i, x in pairs(properties) do
        msg[i] = x
    end
    if imageId then msg.Parent.image.Image = imageId end
end

getgenv().getlocalplayer = getlocalplayer or function()
    return getplayer()
end

getgenv().join = join or function(placeID: number, jobID: string)
    game:GetService("TeleportService"):TeleportToPlaceInstance(placeID, jobID, getplayer())
end

local oldfiresignal
oldfiresignal = hookfunction(firesignal, function(path: Instance, signal: string)
    return oldfiresignal(path[signal])
end)

getgenv().firetouchtransmitter = firetouchinterest
getgenv().playanimation = runanimation
getgenv().getplatform = getdevice
getgenv().getos = getdevice
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
