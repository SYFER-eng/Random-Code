local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create all instances
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ButtonHolder = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TopButton = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Shadow = Instance.new("ImageLabel")
local TopButtonGradient = Instance.new("UIGradient")

-- Scripts configuration
local scripts = {
    {name = "🔥 Aim Menu", loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/SYFER-eng/Random-Code/refs/heads/main/Code/Lua/AimMenu.lua'))()"},
    {name = "⚡ Speed Hacks", loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/SYFER-eng/Random-Code/refs/heads/main/Code/Lua/Roblox-Speed-Hack.lua'))()"},
    {name = "💫 Script 3", loadstring = "loadstring(game:HttpGet('https://example.com/script3.lua'))()"},
    {name = "🌟 Script 4", loadstring = "loadstring(game:HttpGet('https://example.com/script4.lua'))()"}
}

-- Setup ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Setup TopButton
TopButton.Name = "TopButton"
TopButton.Parent = ScreenGui
TopButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopButton.Position = UDim2.new(0.5, -25, 0, 10)
TopButton.Size = UDim2.new(0, 50, 0, 50)
TopButton.ClipsDescendants = true

-- Add corner to TopButton
local TopButtonCorner = Instance.new("UICorner")
TopButtonCorner.CornerRadius = UDim.new(0, 8)
TopButtonCorner.Parent = TopButton

-- Setup rainbow gradient for TopButton
TopButtonGradient.Parent = TopButton

-- Rainbow effect
spawn(function()
    while wait() do
        for i = 0, 1, 0.001 do
            TopButtonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromHSV(i, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(i + 0.2, 1, 1))
            }
            wait()
        end
    end
end)

-- Make TopButton draggable
local draggingTop = false
local dragStartTop
local startPosTop

TopButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingTop = true
        dragStartTop = input.Position
        startPosTop = TopButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingTop = false
            end
        end)
    end
end)

TopButton.InputChanged:Connect(function(input)
    if draggingTop and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartTop
        TopButton.Position = UDim2.new(
            startPosTop.X.Scale,
            startPosTop.X.Offset + delta.X,
            startPosTop.Y.Scale,
            startPosTop.Y.Offset + delta.Y
        )
    end
end)

-- Setup MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.ClipsDescendants = true

-- Setup Gradient
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 120))
})
UIGradient.Parent = MainFrame

-- Setup Shadow
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Image = "rbxassetid://6015897843"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = -1

-- Setup UICorner
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

-- Setup Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "✨ Script Hub ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

-- Setup ButtonHolder
ButtonHolder.Name = "ButtonHolder"
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 10, 0, 60)
ButtonHolder.Size = UDim2.new(1, -20, 1, -70)
ButtonHolder.ScrollBarThickness = 6
ButtonHolder.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)

-- Setup UIListLayout
UIListLayout.Parent = ButtonHolder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- TopButton Toggle Functionality
local menuVisible = true
TopButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if menuVisible then
            local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            local minimizeTween = TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 50, 0, 50),
                Position = TopButton.Position,
                BackgroundTransparency = 1
            })
            minimizeTween:Play()
            wait(0.6)
            MainFrame.Visible = false
        else
            MainFrame.Position = TopButton.Position
            MainFrame.Size = UDim2.new(0, 50, 0, 50)
            MainFrame.BackgroundTransparency = 1
            MainFrame.Visible = true
            
            local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            local maximizeTween = TweenService:Create(MainFrame, tweenInfo, {
                Size = UDim2.new(0, 300, 0, 400),
                Position = UDim2.new(0.5, -150, 0.5, -200),
                BackgroundTransparency = 0
            })
            maximizeTween:Play()
        end
        menuVisible = not menuVisible
    end
end)

-- Create Script Buttons
for i, scriptData in ipairs(scripts) do
    local button = Instance.new("TextButton")
    button.Name = "ScriptButton" .. i
    button.Parent = ButtonHolder
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Font = Enum.Font.GothamBold
    button.Text = scriptData.name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 150))
    })
    buttonGradient.Parent = button
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    -- Button Hover Effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(70, 70, 200),
            TextSize = 18
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            TextSize = 16
        }):Play()
    end)
    
    -- Button Click Handler
    button.MouseButton1Click:Connect(function()
        loadstring(scriptData.loadstring)()
        
        -- Create ripple effect
        local ripple = Instance.new("Frame")
        ripple.Parent = button
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.6
        ripple.Position = UDim2.new(0, 0, 0, 0)
        ripple.Size = UDim2.new(0, 0, 1, 0)
        
        local rippleTween = TweenService:Create(ripple, TweenInfo.new(0.5), {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        })
        
        rippleTween:Play()
        rippleTween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end)
end

-- MainFrame Dragging Functionality
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
