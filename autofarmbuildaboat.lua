local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local gravityNormal = workspace.Gravity
local isRunning = false
local speed = 375
local currentTween = nil

local destinations = {
    CFrame.new(-43.6134491, 62.1137619, 672.744934, -0.999842644, -0.00183729955, 0.017645346, 0, 0.994622767, 0.103564225, -0.0177407414, 0.103547923, -0.994466245),
    CFrame.new(-60.1504707, 97.4659729, 8767.91406, -0.99889338, 0.000705028593, 0.0470264405, 0, 0.999887645, -0.0149902813, -0.047031723, -0.0149736926, -0.998781145),
    CFrame.new(-54.331871, -345.398346, 9488.60645, -0.98221302, 0, 0.187770084, 0, 1, 0, -0.187770084, 0, -0.98221302),
}

-- Безопасное создание интерфейса для Xeno
local playerGui = player:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("XenoAutoFarmUI") then
    playerGui.XenoAutoFarmUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XenoAutoFarmUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 220, 0, 110)
menu.Position = UDim2.new(0.4, 0, 0.4, 0)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menu.BorderSizePixel = 0
menu.Active = true
menu.Draggable = true
menu.Parent = screenGui

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 25)
close.Position = UDim2.new(1, -32, 0, 4)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.Parent = menu

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -16, 0, 50)
toggle.Position = UDim2.new(0, 8, 0, 40)
toggle.Text = "AutoFarm + AntiAfk"
toggle.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.Parent = menu

close.MouseButton1Click:Connect(function()
    isRunning = false
    workspace.Gravity = gravityNormal
    if currentTween then
        currentTween:Cancel()
    end
    screenGui:Destroy()
end)

local function moveTo(targetCFrame, setGravity)
    local char = player.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    local distance = (root.Position - targetCFrame.Position).Magnitude
    local duration = distance / speed

    if currentTween then
        currentTween:Cancel()
    end

    currentTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    currentTween:Play()

    if setGravity then
        workspace.Gravity = gravityNormal
    else
        workspace.Gravity = 0
    end

    local reached = false
    local connection
    connection = currentTween.Completed:Connect(function()
        reached = true
        if connection then connection:Disconnect() end
    end)

    while not reached and isRunning do
        if not player.Character or player.Character ~= char or not char:FindFirstChild("HumanoidRootPart") then
            if currentTween then currentTween:Cancel() end
            return false
        end
        RunService.Heartbeat:Wait()
    end
    
    return reached
end

-- Поток Anti-AFK (надежная имитация нажатия клавиши)
task.spawn(function()
    while true do
        task.wait(15)
        if isRunning then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.K, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.K, false, game)
            end)
        end
    end
end)

local function autoFarmLoop()
    while isRunning do
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart", 10)
        local humanoid = char:WaitForChild("Humanoid", 10)
        if not root or not humanoid then 
            task.wait(1)
            continue 
        end

        local success = true
        for i, cf in ipairs(destinations) do
            if not isRunning then break end
            success = moveTo(cf, i == #destinations)
            if not success then break end
        end

        if success and isRunning then
            local dead = false
            local diedConn
            diedConn = humanoid.Died:Connect(function()
                dead = true
                if diedConn then diedConn:Disconnect() end
            end)
            
            while not dead and isRunning and player.Character == char do
                task.wait(0.5)
            end
        end

        workspace.Gravity = gravityNormal
        task.wait(1.5)
    end
end

toggle.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if not isRunning then
        toggle.Text = "AutoFarm + AntiAfk"
        toggle.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        workspace.Gravity = gravityNormal
        if currentTween then
            currentTween:Cancel()
        end
    else
        toggle.Text = "Stop AutoFarm"
        toggle.BackgroundColor3 = Color3.fromRGB(200, 80, 0)
        workspace.Gravity = gravityNormal
        task.spawn(autoFarmLoop)
    end
end)