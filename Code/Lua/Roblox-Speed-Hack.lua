local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHackPremium"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

-- Main Window
local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(0, 800, 0, 500)
mainWindow.Position = UDim2.new(0.5, -400, 0.5, -250)
mainWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainWindow.BorderSizePixel = 0
mainWindow.Active = true
mainWindow.Draggable = true
mainWindow.ClipsDescendants = true
mainWindow.Parent = screenGui

-- Add Shadow
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1.02, 0, 1.02, 0)
shadow.Position = UDim2.new(-0.01, 0, -0.01, 0)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://297774371"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.Parent = mainWindow

-- Tabs Container
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(0, 200, 1, 0)
tabsContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tabsContainer.Parent = mainWindow

-- Add Corner Radius to Main Window
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainWindow

-- Create Tab Button Function
local function createTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 50)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 16
    tab.Parent = tabsContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = tab
    
    return tab
end

-- Create Tabs
local speedTab = createTab("SPEED CONTROLLER", UDim2.new(0, 0, 0, 0))
local unloadTab = createTab("UNLOAD SCRIPT", UDim2.new(0, 0, 0, 60))

-- Content Frames
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(0, 600, 1, 0)
speedFrame.Position = UDim2.new(0, 200, 0, 0)
speedFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
speedFrame.Visible = true
speedFrame.Parent = mainWindow

local unloadFrame = Instance.new("Frame")
unloadFrame.Size = UDim2.new(0, 600, 1, 0)
unloadFrame.Position = UDim2.new(0, 200, 0, 0)
unloadFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
unloadFrame.Visible = false
unloadFrame.Parent = mainWindow

-- Add Gradient to Frames
local function addGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
    })
    gradient.Rotation = 45
    gradient.Parent = parent
end

addGradient(speedFrame)
addGradient(unloadFrame)

-- Speed Control Elements
local speedSlider = Instance.new("Frame")
speedSlider.Size = UDim2.new(0.8, 0, 0, 6)
speedSlider.Position = UDim2.new(0.1, 0, 0.4, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
speedSlider.Parent = speedFrame

local sliderHandle = Instance.new("TextButton")
sliderHandle.Size = UDim2.new(0, 20, 0, 20)
sliderHandle.Position = UDim2.new(0, -10, 0.5, -10)
sliderHandle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
sliderHandle.Text = ""
sliderHandle.Parent = speedSlider

-- Add Corner Radius to Slider Elements
local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 3)
sliderCorner.Parent = speedSlider

local handleCorner = Instance.new("UICorner")
handleCorner.CornerRadius = UDim.new(1, 0)
handleCorner.Parent = sliderHandle

-- Speed Display
local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(0, 200, 0, 30)
speedDisplay.Position = UDim2.new(0.5, -100, 0.3, 0)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Text = "Speed: 16"
speedDisplay.TextColor3 = Color3.fromRGB(0, 0, 0)
speedDisplay.TextSize = 24
speedDisplay.Font = Enum.Font.GothamBold
speedDisplay.Parent = speedFrame

-- Unload Button
local unloadButton = Instance.new("TextButton")
unloadButton.Size = UDim2.new(0, 200, 0, 50)
unloadButton.Position = UDim2.new(0.5, -100, 0.5, -25)
unloadButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
unloadButton.Text = "UNLOAD SCRIPT"
unloadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
unloadButton.Font = Enum.Font.GothamBold
unloadButton.TextSize = 18
unloadButton.Parent = unloadFrame

local unloadCorner = Instance.new("UICorner")
unloadCorner.CornerRadius = UDim.new(0, 8)
unloadCorner.Parent = unloadButton

-- Enhanced Black Comet Effect
local function createComet()
    local comet = Instance.new("Frame")
    comet.Size = UDim2.new(0, 4, 0, 4)
    comet.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    comet.BorderSizePixel = 0
    comet.Parent = mainWindow
    
    for i = 1, 5 do
        local trail = Instance.new("Frame")
        trail.Size = UDim2.new(0, 25 - (i * 4), 0, 3 - (i * 0.4))
        trail.Position = UDim2.new(0, -(25 - (i * 4)), 0, 0.5)
        trail.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        trail.BackgroundTransparency = 0.2 * i
        trail.BorderSizePixel = 0
        trail.Parent = comet
        
        local glow = Instance.new("ImageLabel")
        glow.Size = UDim2.new(1.2, 0, 1.2, 0)
        glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
        glow.BackgroundTransparency = 1
        glow.Image = "rbxassetid://7331079227"
        glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        glow.ImageTransparency = 0.5 + (0.1 * i)
        glow.Parent = trail
    end
    
    local startX = math.random(-50, 0)
    local startY = math.random(0, mainWindow.AbsoluteSize.Y)
    comet.Position = UDim2.new(0, startX, 0, startY)
    
    local endX = mainWindow.AbsoluteSize.X + 50
    local endY = startY + math.random(100, 200)
    
    local tweenInfo = TweenInfo.new(
        math.random(8, 12) / 10,
        Enum.EasingStyle.Linear
    )
    
    local tween = tweenService:Create(comet, tweenInfo, {
        Position = UDim2.new(0, endX, 0, endY),
        BackgroundTransparency = 1
    })
    
    tween:Play()
    tween.Completed:Connect(function()
        comet:Destroy()
    end)
end

-- Spawn Enhanced Comets
spawn(function()
    while wait(0.2) do
        if mainWindow.Visible then
            createComet()
        end
    end
end)

-- Speed Control Logic
local dragging = false
local minSpeed = 16
local maxSpeed = 200
local currentSpeed = minSpeed

-- Store the current speed in Player Attributes to persist across resets
player:SetAttribute("CurrentSpeed", currentSpeed)

sliderHandle.MouseButton1Down:Connect(function()
    dragging = true
end)

userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

runService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = userInputService:GetMouseLocation()
        local sliderPos = speedSlider.AbsolutePosition
        local sliderSize = speedSlider.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        sliderHandle.Position = UDim2.new(relativeX, -10, 0.5, -10)
        
        currentSpeed = math.floor(minSpeed + (maxSpeed - minSpeed) * relativeX)
        speedDisplay.Text = "Speed: " .. currentSpeed
        
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
        end

        -- Update the stored speed
        player:SetAttribute("CurrentSpeed", currentSpeed)
    end
end)

-- Tab Switching Logic
speedTab.MouseButton1Click:Connect(function()
    speedFrame.Visible = true
    unloadFrame.Visible = false
end)

unloadTab.MouseButton1Click:Connect(function()
    speedFrame.Visible = false
    unloadFrame.Visible = true
end)

-- Unload Script Logic
unloadButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
    end
    screenGui:Destroy()
end)

-- Toggle GUI Visibility with Insert
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- Initialize GUI State
speedFrame.Visible = true
unloadFrame.Visible = false
mainWindow.Visible = true

-- Restore speed on character respawn or reset
player.CharacterAdded:Connect(function(character)
    wait(1)  -- Allow some time for the character to load
    local storedSpeed = player:GetAttribute("CurrentSpeed") or 16  -- Default to 16 if no speed is stored
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = storedSpeed
end)
