-- KEY SYSTEM
local CorrectKey = "NORI-PTHOB-CLHB-C1FW-EEN47-OT5KQ"

if not getgenv().Key or getgenv().Key ~= CorrectKey then
    game.Players.LocalPlayer:Kick("Wrong Key!")
    return
end

-- SERVICES
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

-- MAIN UI
local Frame = Instance.new("Frame", game.CoreGui)
Frame.Size = UDim2.new(0,500,0,320)
Frame.Position = UDim2.new(0.5,-250,0.5,-160)
Frame.BackgroundColor3 = Color3.fromRGB(0,70,130)
Frame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner", Frame)
MainCorner.CornerRadius = UDim.new(0,10)

-- TITLE BAR
local TitleBar = Instance.new("Frame", Frame)
TitleBar.Size = UDim2.new(1,0,0,40)
TitleBar.BackgroundColor3 = Color3.fromRGB(0,50,100)
TitleBar.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", TitleBar)
UICorner.CornerRadius = UDim.new(0,10)

-- 🔵 LOGO VIỀN XANH
local Logo = Instance.new("Frame", TitleBar)
Logo.Size = UDim2.new(0,28,0,28)
Logo.Position = UDim2.new(0,8,0.5,-14)
Logo.BackgroundColor3 = Color3.fromRGB(0,100,200)
Logo.BorderSizePixel = 0

local LogoCorner = Instance.new("UICorner", Logo)
LogoCorner.CornerRadius = UDim.new(1,0)

-- RUỘT LOGO
local Inner = Instance.new("Frame", Logo)
Inner.Size = UDim2.new(0.7,0,0.7,0)
Inner.Position = UDim2.new(0.15,0,0.15,0)
Inner.BackgroundColor3 = Color3.fromRGB(0,170,255)
Inner.BorderSizePixel = 0

local InnerCorner = Instance.new("UICorner", Inner)
InnerCorner.CornerRadius = UDim.new(1,0)

-- TITLE TEXT
local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1,-80,1,0)
Title.Position = UDim2.new(0,45,0,0)
Title.BackgroundTransparency = 1
Title.Text = "NORI HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- CLOSE BUTTON
local Close = Instance.new("TextButton", TitleBar)
Close.Size = UDim2.new(0,40,1,0)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200,0,0)
Close.TextColor3 = Color3.new(1,1,1)

Close.MouseButton1Click:Connect(function()
    Frame:Destroy()
end)

-- DRAG
local dragToggle = false
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

-- BUTTON SPEED
local SpeedBtn = Instance.new("TextButton", Frame)
SpeedBtn.Size = UDim2.new(0,200,0,50)
SpeedBtn.Position = UDim2.new(0,20,0,60)
SpeedBtn.Text = "Speed x2"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
SpeedBtn.TextColor3 = Color3.new(1,1,1)

SpeedBtn.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 32
end)

-- TOGGLE AUTO JUMP
local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0,200,0,50)
Toggle.Position = UDim2.new(0,20,0,120)
Toggle.Text = "Auto Jump: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(0,120,200)
Toggle.TextColor3 = Color3.new(1,1,1)

local jumping = false

Toggle.MouseButton1Click:Connect(function()
    jumping = not jumping
    Toggle.Text = "Auto Jump: " .. (jumping and "ON" or "OFF")

    while jumping do
        task.wait(0.3)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Jump = true
        end
    end
end)

-- NOTIFICATION
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "NORI HUB",
        Text = "Loaded thành công!",
        Duration = 5
    })
end)
