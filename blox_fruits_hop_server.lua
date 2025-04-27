
-- Script Auto Hop Server tìm Chén Thánh (Holy Grail) cho Blox Fruits (Client: KRNL)

repeat wait() until game:IsLoaded()

-- Khởi tạo Services
local HttpService = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local LocalPlayer = game.Players.LocalPlayer
local PlaceId = game.PlaceId

-- Hàm tìm Server
local function HopServer()
    local servers = {}
    local req = request or http_request -- KRNL hỗ trợ request
    if req then
        local response = req({
            Url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        local data = HttpService:JSONDecode(response.Body)
        for i,v in pairs(data.data) do
            if v.playing < v.maxPlayers then
                table.insert(servers, v.id)
            end
        end
    end

    if #servers > 0 then
        TPS:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    else
        warn("[!] Không tìm thấy server phù hợp để hop!")
    end
end

-- Hàm kiểm tra Chén Thánh
local function CheckHolyGrail()
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v.Name:lower():find("holy") then
            return true
        end
    end
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("holy") then
            return true
        end
    end
    return false
end

-- Thông báo khởi động
print("[+] Bắt đầu Auto Hop Server tìm Chén Thánh...")

-- Vòng lặp chính
while true do
    wait(5)
    if CheckHolyGrail() then
        print("[!] Đã tìm thấy Chén Thánh trên server này!")
        break
    else
        print("[!] Chưa có Chén Thánh - Đang hop server khác...")
        HopServer()
        wait(8) -- Đợi 8 giây để server load ổn định
    end
end
