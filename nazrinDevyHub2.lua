-- Load Acrylic UI Library (Replace with a trusted source)
local Acrylic = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnknownUser1084/Acrylic/main/Acrylic.lua"))()

-- Create a ScreenGui for the galaxy background
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local GalaxyBackground = Instance.new("ImageLabel")
GalaxyBackground.Size = UDim2.new(1, 0, 1, 0) -- Full screen
GalaxyBackground.BackgroundTransparency = 1
GalaxyBackground.Image = "rbxassetid://7476220285" -- Starry Galaxy Night
GalaxyBackground.Parent = ScreenGui

-- Create the main GUI instance
local Library = Acrylic.new(true) -- Enable notifications

-- Create a window titled "Game Selector" with galaxy-inspired styling
local Window = Library:createWindow{
    Name = "Game Selector Hub",
    Size = UDim2.fromOffset(300, 200),
    Theme = "Dark", -- Adjust if Acrylic supports galaxy-like themes
    Position = UDim2.new(0.5, -150, 0.5, -100) -- Center the window
}

-- Create a single tab for game selection
local MainTab = Window:giveTab("Games")

-- Services for Arm Battles
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Player = Players.LocalPlayer

-- Global variables for Arm Battles toggles
getgenv().AutoHitEnabled = false
getgenv().AutoLiftEnabled = false

-- Function for simulating mouse click (used in Arm Battles)
local function simulateClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    wait(0.01)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end

-- Game Place IDs (Update if necessary)
local BROOKHAVEN_PLACEID = 4580230200 -- Brookhaven RP
local ARM_BATTLES_PLACEID = 12960847226 -- Arm Battles

-- Button 1: Brookhaven RP (Styled as blue rounded rectangle, with game validation)
MainTab:giveButton{
    Name = "Brookhaven",
    Callback = function()
        if game.PlaceId ~= BROOKHAVEN_PLACEID then
            Library:notify({
                Title = "Error",
                Content = "❌ WRONG GAME!",
                Duration = 5
            })
            return
        end
        Library:notify({
            Title = "Loading Brookhaven",
            Content = "Starting Salvatore-inspired script...",
            Duration = 3
        })
        
        -- Brookhaven RP Script (Salvatore features in Acrylic)
        local BrookhavenWindow = Acrylic.new(true):createWindow{
            Name = "Salvatore Hub - Brookhaven",
            Size = UDim2.fromOffset(500, 400),
            Theme = "Dark"
        }

        -- Tab 1: Main Page (Server Management)
        local MainTab = BrookhavenWindow:giveTab("Main")
        MainTab:giveButton{
            Name = "Server Hop",
            Callback = function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
            end
        }
        MainTab:giveButton{
            Name = "Rejoin Server",
            Callback = function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
            end
        }

        -- Tab 2: Fun Page (Items & Effects)
        local FunTab = BrookhavenWindow:giveTab("Fun")
        FunTab:giveSection("Roses")
        FunTab:giveButton{
            Name = "Get Roses",
            Callback = function()
                local rose = game:GetService("ReplicatedStorage").Remotes.ClaimRose:InvokeServer()
                print("Roses claimed!")
            end
        }
        FunTab:giveToggle{
            Name = "Rainbow Roses",
            Default = false,
            Callback = function(state)
                if state then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, part in pairs(char:GetChildren()) do
                            if part.Name == "Rose" then
                                spawn(function()
                                    while state do
                                        part.Color = Color3.fromHSV(tick() % 6 / 6, 1, 1)
                                        wait(0.1)
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        }

        -- Tab 3: FE Sound
        local SoundTab = BrookhavenWindow:giveTab("FE Sound")
        local soundDropdown = SoundTab:giveDropdown{
            Name = "Gun Sound ID",
            Options = {"Woah Gun", "Ahhh Gun", "Yippee Gun", "Get Out Gun", "Skibidi Bop Mm Dada Gun"},
            Default = 1,
            Callback = function(option)
                local sounds = {
                    ["Woah Gun"] = "rbxassetid://131961136",
                    ["Ahhh Gun"] = "rbxassetid://131961136",
                    ["Yippee Gun"] = "rbxassetid://131961136",
                    ["Get Out Gun"] = "rbxassetid://131961136",
                    ["Skibidi Bop Mm Dada Gun"] = "rbxassetid://131961136"
                }
                local sound = Instance.new("Sound", game.Workspace)
                sound.SoundId = sounds[option]
                sound:Play()
                sound.Ended:Connect(function() sound:Destroy() end)
            end
        }

        -- Tab 4: FE Lag & Light
        local LagTab = BrookhavenWindow:giveTab("Lag/Light")
        LagTab:giveButton{
            Name = "Activate FE Lag Server",
            Callback = function()
                for i = 1, 100 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(1,1,1)
                    part.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    part.Parent = game.Workspace
                    part:Destroy()
                end
                print("Lag activated!")
            end
        }
        LagTab:giveButton{
            Name = "FE Light Spawn",
            Callback = function()
                local light = Instance.new("Tool")
                light.Name = "Flashlight"
                local handle = Instance.new("Part", light)
                handle.Name = "Handle"
                light.Parent = game.Players.LocalPlayer.Backpack
            end
        }

        -- Tab 5: Dupe & Throw
        local DupeTab = BrookhavenWindow:giveTab("Dupe/Throw")
        DupeTab:giveSection("Money")
        DupeTab:giveButton{
            Name = "Dupe Money",
            Callback = function()
                game:GetService("ReplicatedStorage").Remotes.AddMoney:FireServer(10000)
            end
        }
        DupeTab:giveButton{
            Name = "Loop Throw Money",
            Callback = function()
                spawn(function()
                    while wait(0.1) do
                        local money = game.Workspace:FindFirstChild("MoneyBill")
                        if money then money.CFrame = money.CFrame * CFrame.new(0,0,-10) end
                    end
                end)
            end
        }

        -- Tab 6: Tools
        local ToolTab = BrookhavenWindow:giveTab("Tools")
        local dupeAmountInput = ToolTab:giveTextbox{
            Name = "Dupe Amount",
            Default = "10",
            Callback = function(value)
                _G.DupeAmount = tonumber(value)
            end
        }
        local toolDropdown = ToolTab:giveDropdown{
            Name = "Choose Tool for Dupe",
            Options = {"Couch", "Crystals", "Crystal", "Fire Hose", "Agency Book"},
            Default = 1,
            Callback = function(option)
                _G.ToolToDupe = option
            end
        }
        ToolTab:giveButton{
            Name = "Start Dupe",
            Callback = function()
                local amount = _G.DupeAmount or 10
                local toolName = _G.ToolToDupe or "Couch"
                for i = 1, amount do
                    local tool = game.ServerStorage.Tools[toolName]:Clone()
                    tool.Parent = game.Players.LocalPlayer.Backpack
                end
                print("Duped " .. amount .. " " .. toolName)
            end
        }

        -- Tab 7: Player
        local PlayerTab = BrookhavenWindow:giveTab("Player")
        local playerDropdown = PlayerTab:giveDropdown{
            Name = "Select Player",
            Options = function() return game.Players:GetPlayers() end,
            Default = 1,
            Callback = function(playerName)
                _G.TargetPlayer = game.Players:FindFirstChild(playerName)
            end
        }
        PlayerTab:giveButton{
            Name = "Kill Player",
            Callback = function()
                local target = _G.TargetPlayer
                if target and target.Character then
                    target.Character.Humanoid.Health = 0
                end
            end
        }
        PlayerTab:giveButton{
            Name = "Bring Player",
            Callback = function()
                local target = _G.TargetPlayer
                if target and target.Character and game.Players.LocalPlayer.Character then
                    target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        }

        -- Tab 8: Misc
        local MiscTab = BrookhavenWindow:giveTab("Misc")
        MiscTab:giveToggle{
            Name = "Walk Speed (50)",
            Default = false,
            Callback = function(state)
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = state and 50 or 16
                end
            end
        }
        MiscTab:giveToggle{
            Name = "Fly",
            Default = false,
            Callback = function(state)
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(4000, 4000, 4000)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.Parent = char.HumanoidRootPart
                    spawn(function()
                        while state do
                            bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 50
                            wait()
                        end
                        bv:Destroy()
                    end)
                end
            end
        }
        MiscTab:giveButton{
            Name = "Teleport to House",
            Callback = function()
                local houses = game.Workspace.Houses:GetChildren()
                if #houses > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = houses[1].PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                end
            end
        }

        Library:notify({
            Title = "Brookhaven Loaded!",
            Content = "Salvatore features ready for Brookhaven RP!",
            Duration = 5
        })
    end,
    -- Custom styling to match blue rounded rectangle
    Color = Color3.fromRGB(0, 0, 255), -- Blue
    CornerRadius = UDim.new(0, 10) -- Rounded corners (if Acrylic supports)
}

-- Button 2: Arm Battles (Styled as blue rounded rectangle, with game validation)
MainTab:giveButton{
    Name = "Arm Battles",
    Callback = function()
        if game.PlaceId ~= ARM_BATTLES_PLACEID then
            Library:notify({
                Title = "Error",
                Content = "❌ WRONG GAME!",
                Duration = 5
            })
            return
        end
        Library:notify({
            Title = "Loading Arm Battles",
            Content = "Starting Arm Battles script by ND (nazrinDevy)...",
            Duration = 3
        })

        -- Create Arm Battles window
        local ArmBattlesWindow = Acrylic.new(true):createWindow{
            Name = "Arm Battles Script",
            Size = UDim2.fromOffset(400, 300),
            Theme = "Dark"
        }

        -- Tab 1: Hit (Auto Attack)
        local HitTab = ArmBattlesWindow:giveTab("Hit")
        HitTab:giveToggle{
            Name = "Auto Hit (Attack to Win)",
            Default = false,
            Callback = function(Value)
                getgenv().AutoHitEnabled = Value
                if Value then
                    spawn(function()
                        while getgenv().AutoHitEnabled do
                            simulateClick()
                            wait(0.001) -- Fast attack rate
                        end
                    end)
                end
                Library:notify({
                    Title = "Auto Hit",
                    Content = Value and "Enabled - Auto attacking!" or "Disabled",
                    Duration = 3
                })
            end
        }

        -- Tab 2: Lift (Auto Lift for Strength)
        local LiftTab = ArmBattlesWindow:giveTab("Lift")
        LiftTab:giveToggle{
            Name = "Auto Lift (Boost Strength)",
            Default = false,
            Callback = function(Value)
                getgenv().AutoLiftEnabled = Value
                if Value then
                    spawn(function()
                        while getgenv().AutoLiftEnabled do
                            simulateClick()
                            wait(0.005) -- Slower rate for lifting
                        end
                    end)
                end
                Library:notify({
                    Title = "Auto Lift",
                    Content = Value and "Enabled - Auto lifting!" or "Disabled",
                    Duration = 3
                })
            end
        }

        -- Tab 3: Credits
        local CreditsTab = ArmBattlesWindow:giveTab("Credits")
        CreditsTab:giveLabel("Script Created by nazrinDevy (ND)")
        CreditsTab:giveParagraph{
            Title = "About nazrinDevy",
            Content = "nazrinDevy is an exceptional Roblox script developer known for creating high-quality, user-friendly exploits and tools tailored for games like Arm Battles. With a passion for gaming and coding, nazrinDevy delivers seamless GUIs using libraries like Rayfield, ensuring easy toggles for features such as auto-attacks, teleports, and more. Check out nazrinDevy's work on platforms like ScriptBlox, V3rmillion, and Roblox scripting communities for even more amazing scripts that enhance your gameplay experience without hassle. Follow nazrinDevy for updates, custom requests, and the latest in Roblox automation!"
        }
        CreditsTab:giveLabel("Thanks for using this script! - ND")
        CreditsTab:giveButton{
            Name = "Unload Script",
            Callback = function()
                ArmBattlesWindow:Destroy()
                Library:notify({
                    Title = "Script Unloaded",
                    Content = "Arm Battles script has been destroyed.",
                    Duration = 3
                })
            end
        }

        Library:notify({
            Title = "Arm Battles Loaded!",
            Content = "Script by ND (nazrinDevy) ready! Features: Auto Hit, Auto Lift, Credits",
            Duration = 5
        })
    end,
    -- Custom styling to match blue rounded rectangle
    Color = Color3.fromRGB(0, 0, 255), -- Blue
    CornerRadius = UDim.new(0, 10) -- Rounded corners (if Acrylic supports)
}

-- Initial notification
Library:notify({
    Title = "Game Selector Loaded!",
    Content = "Choose a game: Brookhaven or Arm Battles",
    Duration = 5
})
