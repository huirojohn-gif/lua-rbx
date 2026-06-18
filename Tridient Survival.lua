-- TRIDENT SURVIVAL - RAGE MODE
-- ESP, Skeleton ESP, Distance

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local skeletonEnabled = false
local distanceEnabled = false

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TridentESP"
screenGui.Parent = LocalPlayer.PlayerGui

local function createBox(plr)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 50, 0, 80)
    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixels = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Visible = false
    frame.Parent = screenGui
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = plr.Name
    nameLabel.Parent = frame
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0, 16)
    distanceLabel.Position = UDim2.new(0, 0, 1, 18)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.TextSize = 11
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Text = "0m"
    distanceLabel.Parent = frame
    
    local skeleton = Instance.new("Frame")
    skeleton.Size = UDim2.new(0, 2, 0, 60)
    skeleton.Position = UDim2.new(0.5, -1, 0, 10)
    skeleton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    skeleton.BackgroundTransparency = 0.3
    skeleton.Visible = false
    skeleton.Parent = frame
    
    local skeleton2 = Instance.new("Frame")
    skeleton2.Size = UDim2.new(0, 30, 0, 2)
    skeleton2.Position = UDim2.new(0.5, -15, 0, 30)
    skeleton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    skeleton2.BackgroundTransparency = 0.3
    skeleton2.Visible = false
    skeleton2.Parent = frame
    
    return {
        frame = frame,
        nameLabel = nameLabel,
        distanceLabel = distanceLabel,
        skeleton = skeleton,
        skeleton2 = skeleton2
    }
end

local espObjects = {}

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        espObjects[plr] = createBox(plr)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then
        espObjects[plr] = createBox(plr)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if espObjects[plr] then
        espObjects[plr].frame:Destroy()
        espObjects[plr] = nil
    end
end)

-- Основной цикл обновления ESP
RunService.RenderStepped:Connect(function()
    for plr, obj in pairs(espObjects) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            local hrp = plr.Character.HumanoidRootPart
            local humanoid = plr.Character.Humanoid
            local pos, onScreen = Camera:WorldToScreenPoint(hrp.Position)
            
            if onScreen and espEnabled then
                local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0)
                local scale = 80 / (distance / 10 + 5)
                local size = math.clamp(scale, 20, 120)
                
                obj.frame.Size = UDim2.new(0, size * 1.5, 0, size * 2.2)
                obj.frame.Position = UDim2.new(0, pos.X - (size * 1.5) / 2, 0, pos.Y - size * 1.1)
                obj.frame.Visible = true
                
                -- Цвет в зависимости от здоровья
                local health = humanoid.Health / humanoid.MaxHealth
                obj.frame.BackgroundColor3 = Color3.fromRGB(255 - (255 * health), 255 * health, 0)
                
                -- Имя
                obj.nameLabel.Text = plr.Name
                obj.nameLabel.TextSize = math.clamp(size * 0.25, 10, 18)
                
                -- Расстояние
                if distanceEnabled then
                    obj.distanceLabel.Visible = true
                    obj.distanceLabel.Text = tostring(math.floor(distance)) .. "m"
                    obj.distanceLabel.TextSize = math.clamp(size * 0.2, 9, 14)
                else
                    obj.distanceLabel.Visible = false
                end
                
                -- Скелетон (упрощенный 2D)
                if skeletonEnabled then
                    obj.skeleton.Visible = true
                    obj.skeleton2.Visible = true
                    obj.skeleton.Size = UDim2.new(0, 2, 0, size * 1.5)
                    obj.skeleton.Position = UDim2.new(0.5, -1, 0, size * 0.2)
                    obj.skeleton2.Size = UDim2.new(0, size * 0.8, 0, 2)
                    obj.skeleton2.Position = UDim2.new(0.5, -(size * 0.4), 0, size * 0.7)
                else
                    obj.skeleton.Visible = false
                    obj.skeleton2.Visible = false
                end
            else
                obj.frame.Visible = false
            end
        else
            obj.frame.Visible = false
        end
    end
end)

-- Функции для управления из консоли / через bind
_G.ToggleESP = function()
    espEnabled = not espEnabled
    print("ESP: " .. tostring(espEnabled))
end

_G.ToggleSkeleton = function()
    skeletonEnabled = not skeletonEnabled
    print("Skeleton ESP: " .. tostring(skeletonEnabled))
end

_G.ToggleDistance = function()
    distanceEnabled = not distanceEnabled
    print("Distance: " .. tostring(distanceEnabled))
end

print("TRIDENT RAGE MODE LOADED")
print("Commands:")
print("_G.ToggleESP() - Вкл/Выкл ESP")
print("_G.ToggleSkeleton() - Вкл/Выкл скелетон")
print("_G.ToggleDistance() - Вкл/Выкл расстояние")
