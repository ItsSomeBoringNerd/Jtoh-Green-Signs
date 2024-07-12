local Player = game.Players.LocalPlayer
local BadgeService = game:GetService("BadgeService")

local Frames = game.Workspace.Lobby.PortalFrames
local Chart = game.Workspace.Lobby.DifficultyChart.TowerLabels
local Towers = game.Workspace.Towers

local frameExceptions = {"Citadel Portal", "Edifice Portal", "Great Citadel Portal", "Tower Portal", "Obelisk Portal", "Sky Lobby", "Steeple Portal"} -- add any other frame names you don't want the script to handle
local chartExceptions = {"C", "S", "T"} -- same thing, but this time for the items in difficulty charts

local BadgeTable = {}
local ChartTable = {}

for i, v in pairs(Frames:GetChildren()) do
    if not table.find(frameExceptions, v.Name) then
        if Towers:FindFirstChild(v.Name) then
            local bid = Towers:FindFirstChild(v.Name).BadgeID.Value
            local spart = nil
            if v:FindFirstChild("Sign") then
                spart = v.Sign
            elseif v:FindFirstChild("Tower Name") then
                spart = v["Tower Name"]
            end
            table.insert(BadgeTable, {Door = spart, BadgeId = bid})
        end
    end
end

for i, v in pairs(Chart:GetChildren()) do
    if not table.find(chartExceptions, v.Name) then
        if Towers:FindFirstChild(v.Name) then
            local bid = Towers:FindFirstChild(v.Name).BadgeID.Value
            local line = nil
            for x, y in pairs(v:GetChildren()) do
                if y:GetChildren() <= 0 then
                    line = y
                end
            end
            table.insert(ChartTable, {Door = line, BadgeId = bid})
        end
    end
end

for LoopNum, Badge in pairs(BadgeTable) do
    if BadgeService:UserHasBadgeAsync(Player.UserId, Badge.BadgeId) then
        Badge.Door.Color = Color3.fromRGB(0, 150, 0)
    end
end

for LoopNum, Badge in pairs(ChartTable) do
    if BadgeService:UserHasBadgeAsync(Player.UserId, Badge.BadgeId) then
        Badge.Door.Color = Color3.fromRGB(0, 150, 0)
        Badge.Door.Material = Enum.Material.Neon
    end
end
