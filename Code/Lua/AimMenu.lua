local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Syfer-eng Menu v1.0", "Ocean")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- FOV Circle
local FOVShape = "Circle"
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.NumSides = 100
FOVCircle.Radius = 100

-- FOV Rectangle
local FOVRectangle = Drawing.new("Square")
FOVRectangle.Visible = false
FOVRectangle.Thickness = 2
FOVRectangle.Color = Color3.fromRGB(255, 255, 255)
FOVRectangle.Filled = false
FOVRectangle.Transparency = 1

-- Menu Popup
local MenuPopup = Drawing.new("Text")
MenuPopup.Text = "Syfer-eng Menu v1.0"
MenuPopup.Size = 18
MenuPopup.Color = Color3.fromRGB(255, 255, 255)
MenuPopup.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X - 180, workspace.CurrentCamera.ViewportSize.Y - 50)
MenuPopup.Visible = false
MenuPopup.Outline = true
MenuPopup.OutlineColor = Color3.fromRGB(0, 0, 0)

-- Device Type Function
local function GetDeviceType()
    if UserInputService.TouchEnabled then return "Mobile"
    elseif UserInputService.GamepadEnabled then return "Console"
    else return "PC" end
end

-- Settings
local Settings = {
    AimbotEnabled = false,
    SoftAimEnabled = false,
    TeamCheck = true,
    AimPart = "Head",
    FOVType = "Default",
    ESPEnabled = false,
    BoneESP = false,
    BoxESP = false,
    ShowFOV = true,
    RainbowESP = false,
    ESPColor = Color3.fromRGB(255, 255, 255),
    CheatESPEnabled = false
}

-- Bone Connections
local BoneConnections = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

-- ESP Objects Cache
local ESPObjects = {}

-- Create Tabs
local CombatTab = Window:NewTab("💥 Combat")
local VisualTab = Window:NewTab("👁️ Visuals")
local FOVTab = Window:NewTab("🔍 FOV")

-- Combat Section
local AimbotSection = CombatTab:NewSection("Universal Aimbot")

-- Cheat Detection Function
local function IsPlayerCheating(player)
    local character = player.Character
    if not character then return false end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end

    return humanoid.WalkSpeed > 20 or humanoid.JumpPower > 55 or (character.HumanoidRootPart and character.HumanoidRootPart.Position.Y > 500)
end

-- Initialize Sections
local function InitializeAimbotSection()
    AimbotSection:NewToggle("Enable Aimbot", "Universal targeting system", function(state)
        Settings.AimbotEnabled = state
    end)

    AimbotSection:NewToggle("Team Check", "Universal team detection", function(state)
        Settings.TeamCheck = state
    end)

    AimbotSection:NewDropdown("Aim Part", "Universal part targeting", 
        {"Head", "Torso", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, 
        function(part)
            Settings.AimPart = part
        end)
end

-- Initialize Aimbot Section
InitializeAimbotSection()

-- Visual Section
local ESPSection = VisualTab:NewSection("Universal ESP")
local function InitializeESPSection()
    ESPSection:NewToggle("Enable ESP", "Universal player ESP", function(state)
        Settings.ESPEnabled = state
    end)

    ESPSection:NewToggle("Bone ESP", "Universal skeleton system", function(state)
        Settings.BoneESP = state
    end)

    ESPSection:NewToggle("Box ESP", "Universal box system", function(state)
        Settings.BoxESP = state
    end)

    ESPSection:NewToggle("Rainbow ESP", "Dynamic color system", function(state)
        Settings.RainbowESP = state
    end)
end

InitializeESPSection()

-- FOV Section
local FOVSection = FOVTab:NewSection("FOV Settings")
local function InitializeFOVSection()
    FOVSection:NewToggle("Show FOV Circle", "Toggle FOV circle visibility", function(state)
        Settings.ShowFOV = state
        FOVCircle.Visible = state
        FOVRectangle.Visible = false
    end)

    FOVSection:NewDropdown("FOV Type", "Select FOV type", 
        {"Default", "Wide", "Narrow"}, 
        function(selected)
            Settings.FOVType = selected
            FOVCircle.Radius = selected == "Wide" and 150 or selected == "Narrow" and 50 or 100
        end)
end

InitializeFOVSection()

-- Utility Functions
local function FindFirstAvailablePart(character, partNames)
    for _, name in ipairs(partNames) do
        local part = character:FindFirstChild(name)
        if part then return part end
    end
    return nil
end

local function GetClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                if Settings.TeamCheck and player.Team == LocalPlayer.Team then continue end
                
                local targetPart = FindFirstAvailablePart(character, {
                    Settings.AimPart,
                    "Head",
                    "HumanoidRootPart",
                    "Torso",
                    "UpperTorso"
                })

                if targetPart then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if distance < shortestDistance then
                            closest = player
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end
    return closest
end

local function CreateBoneDrawing()
    local drawing = Drawing.new("Line")
    drawing.Thickness = 2
    drawing.Color = Color3.new(1, 0, 0)
    return drawing
end

local function GetRainbowColor()
    return Color3.fromHSV(tick() % 5 / 5, 1, 1)
end

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                if Settings.TeamCheck and player.Team == LocalPlayer.Team then continue end

                if not ESPObjects[player] then
                    ESPObjects[player] = {
                        Box = Drawing.new("Square"),
                        CheaterLabel = Drawing.new("Text"),
                        Bones = {}
                    }

                    local esp = ESPObjects[player]
                    esp.Box.Thickness = 2
                    esp.Box.Filled = false
                    esp.Box.Color = Color3.new(1, 0, 0)

                    esp.CheaterLabel.Size = 24
                    esp.CheaterLabel.Center = true
                    esp.CheaterLabel.Outline = true
                    esp.CheaterLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
                    esp.CheaterLabel.Color = Color3.fromRGB(0, 255, 0)

                    for _ = 1, #BoneConnections do
                        table.insert(esp.Bones, CreateBoneDrawing())
                    end
                end

                if Settings.ESPEnabled then
                    local espColor = Settings.RainbowESP and GetRainbowColor() or Settings.ESPColor
                    local esp = ESPObjects[player]

                    if Settings.BoxESP then
                        local rootPart = FindFirstAvailablePart(character, {"HumanoidRootPart"})
                        if rootPart then
                            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                            if onScreen then
                                local size = Vector2.new(2000 / vector.Z, 3000 / vector.Z)
                                esp.Box.Size = size
                                esp.Box.Position = Vector2.new(vector.X - size.X / 2, vector.Y - size.Y / 2)
                                esp.Box.Color = espColor
                                esp.Box.Visible = true

                                if Settings.CheatESPEnabled then
                                    local isCheating = IsPlayerCheating(player)
                                    esp.CheaterLabel.Text = isCheating and "CHEATING" or "NOT CHEATING"
                                    esp.CheaterLabel.Color = isCheating and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                                    esp.CheaterLabel.Position = Vector2.new(vector.X, vector.Y)
                                    esp.CheaterLabel.Visible = true
                                else
                                    esp.CheaterLabel.Visible = false
                                end
                            else
                                esp.Box.Visible = false
                                esp.CheaterLabel.Visible = false
                            end
                        end
                    else
                        esp.Box.Visible = false
                        esp.CheaterLabel.Visible = false
                    end

                    if Settings.BoneESP then
                        for i, connection in ipairs(BoneConnections) do
                            local part1 = FindFirstAvailablePart(character, {connection[1]})
                            local part2 = FindFirstAvailablePart(character, {connection[2]})

                            if part1 and part2 then
                                local pos1, vis1 = Camera:WorldToViewportPoint(part1.Position)
                                local pos2, vis2 = Camera:WorldToViewportPoint(part2.Position)

                                if vis1 and vis2 then
                                    local bone = esp.Bones[i]
                                    bone.From = Vector2.new(pos1.X, pos1.Y)
                                    bone.To = Vector2.new(pos2.X, pos2.Y)
                                    bone.Color = espColor
                                    bone.Visible = true
                                else
                                    esp.Bones[i].Visible = false
                                end
                            else
                                esp.Bones[i].Visible = false
                            end
                        end
                    else
                        for _, bone in pairs(esp.Bones) do
                            bone.Visible = false
                        end
                    end
                else
                    local esp = ESPObjects[player]
                    esp.Box.Visible = false
                    esp.CheaterLabel.Visible = false
                    for _, bone in pairs(esp.Bones) do
                        bone.Visible = false
                    end
                end
            end
        end
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    
    if FOVShape == "Circle" then
        FOVCircle.Position = mousePos
        FOVCircle.Visible = Settings.ShowFOV
    elseif FOVShape == "Square" then
        FOVRectangle.Position = Vector2.new(mousePos.X - 50, mousePos.Y - 50)
        FOVRectangle.Size = Vector2.new(100, 100)
        FOVRectangle.Visible = Settings.ShowFOV
    end

    if Settings.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestPlayer()
        if target and target.Character then
            local targetPart = FindFirstAvailablePart(target.Character, {
                Settings.AimPart,
                "Head",
                "HumanoidRootPart",
                "Torso",
                "UpperTorso"
            })

            if targetPart then
                local targetPos = targetPart.Position
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            end
        end
    end

    UpdateESP()

    if MenuPopup.Visible then
        MenuPopup.Color = GetRainbowColor()
        MenuPopup.OutlineColor = Color3.new(0, 0, 0)
    end
end)

-- Show Menu Popup on startup
MenuPopup.Visible = true
wait(3)
MenuPopup.Visible = false

-- Menu Toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        local combatSuite = game:GetService("CoreGui"):FindFirstChild("CombatSuite")
        if combatSuite then
            combatSuite.Enabled = not combatSuite.Enabled
        end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, bone in pairs(ESPObjects[player].Bones) do
            bone:Remove()
        end
        ESPObjects[player].Box:Remove()
        ESPObjects[player].CheaterLabel:Remove()
        ESPObjects[player] = nil
    end
end)
