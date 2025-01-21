local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Create the main screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")  -- Set parent to CoreGui to overlay everything
screenGui.ResetOnSpawn = false  -- Prevent resetting the GUI when respawning

-- Create the main window
local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(0, 510, 0, 400)
mainWindow.Position = UDim2.new(0.5, -255, 0.5, -200)
mainWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainWindow.BackgroundTransparency = 0.2
mainWindow.Visible = true  -- Make it visible immediately
mainWindow.ZIndex = 999  -- Set the ZIndex to a high value to overlay on top of everything
mainWindow.Parent = screenGui

-- Title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Roblox Speed Hack For Leroy Made By Syfer-eng"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSans
titleLabel.ZIndex = 999  -- Set ZIndex to match main window
titleLabel.Parent = mainWindow

-- Create Tabs
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.Position = UDim2.new(0, 0, 0, 30)
tabsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabsFrame.BackgroundTransparency = 0.5
tabsFrame.ZIndex = 999  -- Set ZIndex to match main window
tabsFrame.Parent = mainWindow

-- Tab Buttons (only Speed and Unload)
local speedTabButton = Instance.new("TextButton")
speedTabButton.Size = UDim2.new(0, 170, 0, 40)
speedTabButton.Position = UDim2.new(0, 0, 0, 0)
speedTabButton.Text = "Speed"
speedTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedTabButton.Font = Enum.Font.SourceSans
speedTabButton.TextSize = 16
speedTabButton.ZIndex = 999  -- Set ZIndex to match main window
speedTabButton.Parent = tabsFrame

local unloadTabButton = Instance.new("TextButton")
unloadTabButton.Size = UDim2.new(0, 170, 0, 40)
unloadTabButton.Position = UDim2.new(0, 170, 0, 0)
unloadTabButton.Text = "Unload"
unloadTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
unloadTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
unloadTabButton.Font = Enum.Font.SourceSans
unloadTabButton.TextSize = 16
unloadTabButton.ZIndex = 999  -- Set ZIndex to match main window
unloadTabButton.Parent = tabsFrame

-- Create Sections
local speedSection = Instance.new("Frame")
speedSection.Size = UDim2.new(1, 0, 0, 250)
speedSection.Position = UDim2.new(0, 0, 0, 70)
speedSection.BackgroundTransparency = 0.3
speedSection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedSection.Visible = true  -- Make Speed section visible by default
speedSection.ZIndex = 999  -- Set ZIndex to match main window
speedSection.Parent = mainWindow

local unloadSection = Instance.new("Frame")
unloadSection.Size = UDim2.new(1, 0, 0, 250)
unloadSection.Position = UDim2.new(0, 0, 0, 70)
unloadSection.BackgroundTransparency = 0.3
unloadSection.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
unloadSection.Visible = false  -- Unload section starts invisible
unloadSection.ZIndex = 999  -- Set ZIndex to match main window
unloadSection.Parent = mainWindow

-- Speed Input Box (Editable)
local speedInputLabel = Instance.new("TextLabel")
speedInputLabel.Size = UDim2.new(0, 200, 0, 30)
speedInputLabel.Position = UDim2.new(0, 10, 0, 10)
speedInputLabel.BackgroundTransparency = 1
speedInputLabel.Text = "Speed: 16"
speedInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInputLabel.TextSize = 14
speedInputLabel.ZIndex = 999  -- Set ZIndex to match main window
speedInputLabel.Parent = speedSection

local speedInputBox = Instance.new("TextBox")
speedInputBox.Size = UDim2.new(0, 200, 0, 30)
speedInputBox.Position = UDim2.new(0, 10, 0, 40)
speedInputBox.Text = "16"
speedInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedInputBox.Font = Enum.Font.SourceSans
speedInputBox.TextSize = 14
speedInputBox.ZIndex = 999  -- Set ZIndex to match main window
speedInputBox.Parent = speedSection

-- Additional label for Universal Football default speed
local normalSpeedLabel = Instance.new("TextLabel")
normalSpeedLabel.Size = UDim2.new(0, 300, 0, 30)
normalSpeedLabel.Position = UDim2.new(0, 220, 0, 40)
normalSpeedLabel.BackgroundTransparency = 1
normalSpeedLabel.Text = "Normal in Universal Football is 16"
normalSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
normalSpeedLabel.TextSize = 14
normalSpeedLabel.Font = Enum.Font.SourceSans
normalSpeedLabel.ZIndex = 999  -- Set ZIndex to match main window
normalSpeedLabel.Parent = speedSection

local speedValue = 16  -- Default speed

-- Update the player's speed based on the input
local function updateSpeed()
    local inputValue = tonumber(speedInputBox.Text)
    if inputValue and inputValue > 0 and inputValue <= 100 then
        speedValue = inputValue
        player.Character:WaitForChild("Humanoid").WalkSpeed = speedValue
        speedInputLabel.Text = "Speed: " .. speedValue
    else
        speedInputLabel.Text = "Speed: Invalid"
    end
end

-- When the user changes the text, update the speed
speedInputBox.FocusLost:Connect(function()
    updateSpeed()
end)

-- Button Click Handlers
unloadTabButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    game:GetService("CoreGui"):FindFirstChild("RobloxGui"):ClearAllChildren()
end)

-- Tab Switching Logic
speedTabButton.MouseButton1Click:Connect(function()
    speedSection.Visible = true
    unloadSection.Visible = false
end)

unloadTabButton.MouseButton1Click:Connect(function()
    speedSection.Visible = false
    unloadSection.Visible = true
end)

-- Make window draggable
local draggingWindow = false
local dragInput, dragStart, startPos

mainWindow.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWindow = true
        dragStart = input.Position
        startPos = mainWindow.Position
    end
end)

mainWindow.InputChanged:Connect(function(input)
    if draggingWindow and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainWindow.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWindow = false
    end
end)

-- Set initial speed
updateSpeed()

-- Hide/Unhide the menu when Insert key is pressed
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled  -- Toggle visibility
    end
end)
