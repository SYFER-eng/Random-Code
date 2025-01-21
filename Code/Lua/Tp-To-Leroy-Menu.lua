local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create ESP Toggle Button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0, 200, 0, 50)
espButton.Position = UDim2.new(0, 50, 0, 50)
espButton.Text = "Toggle ESP"
espButton.Parent = screenGui
espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Create Give Health Button
local giveHealthButton = Instance.new("TextButton")
giveHealthButton.Size = UDim2.new(0, 200, 0, 50)
giveHealthButton.Position = UDim2.new(0, 50, 0, 120)
giveHealthButton.Text = "Give 10 Million Health"
giveHealthButton.Parent = screenGui
giveHealthButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
giveHealthButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Create Teleport to "pigskin5897" Button
local tpToPlayerButton = Instance.new("TextButton")
tpToPlayerButton.Size = UDim2.new(0, 200, 0, 50)
tpToPlayerButton.Position = UDim2.new(0, 50, 0, 190)
tpToPlayerButton.Text = "Teleport to leroy"
tpToPlayerButton.Parent = screenGui
tpToPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpToPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- State to keep track of ESP toggle
local espEnabled = true

-- Function to create an ESP effect on a player
local function espPlayer(player)
    local character = player.Character
    if character and not character:FindFirstChild("ESP") then
        local esp = Instance.new("Highlight")
        esp.Name = "ESP"  -- Name the highlight as ESP
        esp.Parent = character
        esp.Adornee = character
        esp.FillTransparency = 0.5  -- Semi-transparent fill
        esp.OutlineColor = Color3.fromRGB(255, 255, 255)  -- White outline
        esp.OutlineTransparency = 0  -- No outline transparency
        
        -- Set color to green, as we are highlighting all players through walls
        esp.FillColor = Color3.fromRGB(0, 255, 0)  -- Green color
    end
end

-- Function to remove ESP from all players
local function removeESPFromPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        local character = player.Character
        if character and character:FindFirstChild("ESP") then
            local esp = character:FindFirstChild("ESP")
            if esp then
                esp:Destroy()
            end
        end
    end
end

-- Function to apply ESP to all players if ESP is enabled
local function applyESPToAllPlayers()
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            -- Apply ESP to each player's character
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                espPlayer(player)
            end
        end
    else
        -- Remove ESP when toggled off
        removeESPFromPlayers()
    end
end

-- Function to give the player 10,000,000 health
local function giveHealth()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character:FindFirstChild("Humanoid")
        humanoid.Health = 10000000  -- Set health to 10 million
        humanoid.MaxHealth = 10000000  -- Set max health to 10 million
    end
end

-- Function to teleport to a specific player by name ("pigskin5897")
local function teleportToPlayer()
    local targetPlayer = Players:FindFirstChild("pigskin5897")
    if targetPlayer and targetPlayer.Character then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        player.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))  -- Teleport player to "pigskin5897"
    else
        warn("Player 'pigskin5897' not found or does not have a character.")
    end
end

-- Button Click Events
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "Toggle ESP (ON)"
    else
        espButton.Text = "Toggle ESP (OFF)"
    end
    applyESPToAllPlayers()  -- Apply or remove ESP based on the toggle state
end)

giveHealthButton.MouseButton1Click:Connect(function()
    giveHealth()  -- Call the function to give the player 10 million health
end)

tpToPlayerButton.MouseButton1Click:Connect(function()
    teleportToPlayer()  -- Call the function to teleport the player to "pigskin5897"
end)

-- Continuously update ESP for all players
game:GetService("RunService").Heartbeat:Connect(function()
    applyESPToAllPlayers()  -- Check and apply/remove ESP every frame
end)
