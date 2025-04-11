-- Speedy Royale - Loading Screen Script
-- Place this LocalScript inside ReplicatedFirst

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Remove default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedyHubGui"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Background
local background = Instance.new("ImageLabel")
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundTransparency = 1
background.Image = "rbxassetid://INSERT_BACKGROUND_IMAGE_ID"
background.ZIndex = 0
background.Parent = screenGui

-- Highlighted Text
local textLabel = Instance.new("TextLabel")
textLabel.Text = "Speedy Hub"
textLabel.Size = UDim2.new(0.6, 0, 0.2, 0)
textLabel.Position = UDim2.new(0.2, 0, 0.4, 0)
textLabel.Font = Enum.Font.GothamBlack
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
textLabel.TextStrokeTransparency = 0.3
textLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.ZIndex = 1
textLabel.Parent = screenGui

-- Optional: Add fade-out after 5 seconds
delay(5, function()
    for i = 1, 10 do
        screenGui.BackgroundTransparency = i / 10
        textLabel.TextTransparency = i / 10
        textLabel.TextStrokeTransparency = 0.3 + (i / 10)
        wait(0.1)
    end
    screenGui:Destroy()
end)
