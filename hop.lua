loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
         Hub = {
         Title = "Skibidi Hub",
         Animation = "Skibidi Open Menu"
         },
        Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
        Notifications = true,
        CorrectKey = "Running the Script...",
       Incorrectkey = "The key is incorrect",
       CopyKeyLink = "Copied to Clipboard"
      }
    }
  })

       MinimizeButton({
       Image = "http://www.roblox.com/asset/?id= 110310444028946",
       Size = {60, 60},
       Color = Color3.fromRGB(10, 10, 10),
       Corner = true,
       Stroke = false,
       StrokeColor = Color3.fromRGB(255, 0, 0)
      })
      
------ Tab
     local Tab1o = MakeTab({Name = "Hop Boss"})
     
------- BUTTON
    
    AddButton(Tab1o, {
     Name = "Hop Rip_Indra",
    Callback = function()
	  -- Blox Fruits Update 27 - Full Auto Holy Grail + Boss Farm
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

-- Danh sách boss có thể farm
local BossNames = {
    "Cake Queen",
    "Beautiful Pirate",
    "Captain Elephant",
    "Stone",
    "Island Empress",
    "Kilo Admiral",
    "Order",
    "rip_indra",
    "Longma",
    "Cursed Captain",
    "Tide Keeper",
    "Darkbeard",
    "Thunder God",
    "Saber Expert",
    "Ice Admiral"
}

-- Lấy danh sách server
local function GetServers()
    local Servers = {}
    local cursor = ""
    local success, response

    repeat
        success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. cursor
            ))
        end)

        if success and response and response.data then
            for _, server in ipairs(response.data) do
                if server.playing < server.maxPlayers and server.id ~= JobId then
                    table.insert(Servers, server.id)
                end
            end
            cursor = response.nextPageCursor or ""
        else
            break
        end
    until not cursor

    return Servers
end

-- Kiểm tra Chén Thánh
local function CheckHolyGrail()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") or obj:IsA("Model") or obj:IsA("Part") then
            local name = obj.Name:lower()
            if name:find("holy") or name:find("grail") or name:find("chén") then
                return obj
            end
        end
        if obj:IsA("Folder") and obj.Name == "EventItems" then
            for _, item in pairs(obj:GetChildren()) do
                local itemName = item.Name:lower()
                if itemName:find("holy") or itemName:find("grail") or itemName:find("chén") then
                    return item
                end
            end
        end
    end
    return nil
end

-- Auto Pickup
local function AutoPickup(item)
    if item and item:IsA("Tool") then
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item.Handle, 0)
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item.Handle, 1)
    elseif item and item:IsA("Part") then
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 0)
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 1)
    elseif item and item:IsA("Model") then
        for _,v in pairs(item:GetDescendants()) do
            if v:IsA("Part") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
end

-- Auto Farm Boss
local function FarmBoss()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            for _, bossName in ipairs(BossNames) do
                if string.lower(obj.Name) == string.lower(bossName) then
                    print("Tìm thấy Boss: "..bossName..", đang farm...")
                    repeat
                        task.wait(0.1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    until not obj or not obj.Parent or obj.Humanoid.Health <= 0
                    print("Boss "..bossName.." đã bị tiêu diệt!")
                end
            end
        end
    end
end

-- Hop Server
local function Hop()
    local Servers = GetServers()
    if #Servers > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, Servers[math.random(1, #Servers)], LocalPlayer)
    else
        warn("Không tìm thấy server mới để nhảy.")
    end
end

-- Main Process
task.spawn(function()
    while task.wait(5) do
        local grail = CheckHolyGrail()
        if grail then
            warn("Đã tìm thấy Chén Thánh!")
            AutoPickup(grail)
            task.wait(3)
            warn("Đang Auto Farm Boss gần...")
            FarmBoss()
            break
        else
            warn("Chưa thấy Chén Thánh... nhảy server khác...")
            Hop()
            task.wait(8)
        end
    end
end)