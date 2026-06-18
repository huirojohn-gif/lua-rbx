-- TRIDENT SURVIVAL - RAGE MODE
-- ESP, Skeleton ESP, Distance
-- Открытие по Insert

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local skeletonEnabled = false
local distanceEnabled = false
local menuVisible = true

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TridentESP"
screenGui.Parent = LocalPlayer.PlayerGui

-- Создание меню
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 400, 0, 350)
menuFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
menuFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
menuFrame.BackgroundTransparency = 0.05
menuFrame.BorderSizePixel = 2
menuFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
menuFrame.Visible = true
menuFrame.Parent = screenGui

-- Тень/свечение
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0, -10, 0, -10)
glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glow.BackgroundTransparency = 0.9
glow.BorderSizePixel = 0
glow.Parent = menuFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.TextSize = 32
title.Font = Enum.Font.GothamBold
title.Text = "⚡ TRIDENT"
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.TextStrokeTransparency = 0
title.Parent = menuFrame

-- Разделитель
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.9, 0, 0, 2)
divider.Position = UDim2.new(0.05, 0, 0, 60)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BorderSizePixel = 0
divider.Parent = menuFrame

-- Кнопка ESP
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9, 0, 0, 45)
espBtn.Position = UDim2.new(0.05, 0, 0, 75)
espBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
espBtn.BorderSizePixel = 2
espBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextColor3 = Color3.fromRGB(208, 208, 208)
espBtn.TextSize = 22
espBtn.Font = Enum.Font.GothamMedium
espBtn.Text = "ESP [OFF]"
espBtn.Parent = menuFrame

-- Кнопка Skeleton
local skeletonBtn = Instance.new("TextButton")
skeletonBtn.Size = UDim2.new(0.9, 0, 0, 45)
skeletonBtn.Position = UDim2.new(0.05, 0, 0, 130)
skeletonBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
skeletonBtn.BorderSizePixel = 2
skeletonBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
skeletonBtn.TextColor3 = Color3.fromRGB(208, 208, 208)
skeletonBtn.TextSize = 22
skeletonBtn.Font = Enum.Font.GothamMedium
skeletonBtn.Text = "ESP Скелетон [OFF]"
skeletonBtn.Parent = menuFrame

-- Кнопка Distance
local distBtn = Instance.new("TextButton")
distBtn.Size = UDim2.new(0.9, 0, 0, 45)
distBtn.Position = UDim2.new(0.05, 0, 0, 185)
distBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
distBtn.BorderSizePixel = 2
distBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
distBtn.TextColor3 = Color3.fromRGB(208, 208, 208)
distBtn.TextSize = 22
distBtn.Font = Enum.Font.GothamMedium
distBtn.Text = "Расстояние [OFF]"
distBtn.Parent = menuFrame

-- Футер
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(170, 170, 170)
footer.TextSize = 14
footer.Font = Enum.Font.Gotham
footer.Text = "SURVIVAL · RAGE  |  INSERT"
footer.Parent = menuFrame

-- Функции обновления кнопок
local function updateButtons()
    espBtn.Text = espEnabled and "ESP [ON]" or "ESP [OFF]"
    espBtn.BorderColor3 = espEnabled and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(255, 255, 255)
    espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(58, 58, 58)
    
    skeletonBtn.Text = skeletonEnabled and "ESP Скелетон [ON]" or "ESP Скелетон [OFF]"
    skeletonBtn.BorderColor3 = skeletonEnabled and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(255, 255, 255)
    skeletonBtn.BackgroundColor3 = skeletonEnabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(58, 58, 58)
    
    distBtn.Text = distanceEnabled and "Расстояние [ON]" or "Расстояние [OFF]"
    distBtn.BorderColor3 = distanceEnabled and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(255, 255, 255)
    distBtn.BackgroundColor3 = distanceEnabled and Color3.fromRGB(30, 80, 50) or Color3.fromRGB(58, 58, 58)
end

-- Нажатия кнопок
espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateButtons()
end)

skeletonBtn.MouseButton1Click:Connect(function()
    skeletonEnabled = not skeletonEnabled
    updateButtons()
end)

distBtn.MouseButton1Click:Connect(function()
    distanceEnabled = not distanceEnabled
    updateButtons()
end)

-- Открытие/закрытие по Insert
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        menuVisible = not menuVisible
        menuFrame.Visible = menuVisible
    end
end)

-- Создание ESP объектов
local espObjects = {}

local function createBox(plr)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 50, 0, 80)
    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 2
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
                
                local health = humanoid.Health / humanoid.MaxHealth
                obj.frame.BackgroundColor3 = Color3.fromRGB(255 - (255 * health), 255 * health, 0)
                
                obj.nameLabel.Text = plr.Name
                obj.nameLabel.TextSize = math.clamp(size * 0.25, 10, 18)
                
                if distanceEnabled then
                    obj.distanceLabel.Visible = true
                    obj.distanceLabel.Text = tostring(math.floor(distance)) .. "m"
                    obj.distanceLabel.TextSize = math.clamp(size * 0.2, 9, 14)
                else
                    obj.distanceLabel.Visible = false
                end
                
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

print("TRIDENT RAGE MODE LOADED")
print("Нажмите INSERT для открытия/закрытия меню")
