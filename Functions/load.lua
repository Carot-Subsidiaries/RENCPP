for i, x in pairs(loadstring(game:HttpGet("https://github.com/Carot-Subsidiaries/RENCPP/raw/main/Functions/functions.lua"))()) do
    getgenv()["pp"..i] = x
end
