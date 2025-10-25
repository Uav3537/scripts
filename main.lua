local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createFrame(name, position, size, color)
    local screen = Instance.new("ScreenGui")
    screen.Name = name
    screen.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size[1], 0, size[2])
    frame.Position = UDim2.new(position[1], 0, position[2], 0)
    frame.BackgroundColor3 = Color3.fromRGB(unpack(color))
    frame.Parent = screen
    frame.AnchorPoint = Vector2.new(0.5, 0.5)

    return frame
end

local function createText(name, txt, position, size, color)
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = txt
    textLabel.Size = UDim2.new(0, size[1], 0, size[2])
    textLabel.Position = UDim2.new(position[1], 0, position[2], 0)
    textLabel.AnchorPoint = Vector2.new(0.5, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(unpack(color))
    textLabel.TextWrapped = false
    textLabel.TextScaled = true
    return textLabel
end

local function createImage(name, img, position, size, color)
    local imgLabel = Instance.new("ImageLabel")
    imgLabel.Image = img
    imgLabel.Size = UDim2.new(0, size[1], 0, size[2])
    imgLabel.Position = UDim2.new(position[1], 0, position[2], 0)
    imgLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imgLabel.BackgroundTransparency = 1
    return imgLabel
end

local function createButton(text, position, size, bgColor, textColor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, size[1], 0, size[2])
    btn.Position = UDim2.new(position[1], 0, position[2], 0)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(unpack(bgColor))
    btn.TextColor3 = Color3.fromRGB(unpack(textColor))

    if callback then
        btn.MouseButton1Click:Connect(callback)
    end

    return btn
end
local function loadAll(count)
    local loadMain = createFrame(
        "LoadMain",
        {0.5, 0.5},
        {300, 200},
        {35, 35, 35}
    )

    local loadLabel = createText(
        "LoadLabel",
        "Victory Path Scripts",
        {0.5, 0},
        {200, 50},
        {225,225,225}
    )
    loadLabel.Parent = loadMain

    local loadAuthor = createText(
        "loadAuthor",
        "by Drone",
        {0.3, 0.7},
        {200, 20},
        {225,225,225}
    )
    loadAuthor.Parent = loadLabel

    local loadText = createText(
        "LoadText",
        "로딩중...",
        {0.5, 0.8},
        {200, 30},
        {225,225,225}
    )
    loadText.Parent = loadMain

    local loadPlayerName = createText(
        "loadPlayerName",
        player.DisplayName .." (@"..player.Name..")",
        {0.5, 0.6},
        {200, 20},
        {225,225,225}
    )
    loadPlayerName.Parent = loadMain

    local loadPlayerImage = createImage(
        "loadPlayerImage",
        "https://www.roblox.com/headshot-thumbnail/image?userId=" 
            .. player.UserId 
            .. "&width=150&height=150&format=png",
        {0.5, 0.4},
        {50, 50},
        {225,225,225}
    )
    loadPlayerImage.Parent = loadMain

    for i = 0, count do
        loadText.Text = "로딩중" .. string.rep(".", i % 3 + 1)
        wait(0.3)
    end
    loadMain.Parent:Destroy()

    local hubMain = createFrame(
        "hubMain",
        {0.5, 0.5},
        {500, 600},
        {35, 35, 35}
    )
    hubMain.Active = true
    hubMain.Draggable = true

    local hubRemove = createButton(
        "X",
        {0.94, 0.05},
        {50, 50},
        {50, 50, 50},
        {255,255,255},
        function()
            hubMain.Parent:Destroy()
        end
    )
    hubRemove.Parent = hubMain

    local hubButton1 = createButton(
        "infinite yield",
        {0.45, 0.1},
        {400, 50},
        {60, 60, 60},
        {255,255,255},
        function()
            hubMain.Parent:Destroy()
            loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))()
        end
    )
    hubButton1.Parent = hubMain

    local hubButton2 = createButton(
        "dex explorer",
        {0.45, 0.2},
        {400, 50},
        {60, 60, 60},
        {255,255,255},
        function()
            hubMain.Parent:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
        end
    )
    hubButton2.Parent = hubMain

    local hubButton3 = createButton(
        "hitbox + loopbring + teleport",
        {0.45, 0.3},
        {400, 50},
        {60, 60, 60},
        {255,255,255},
        function()
            local save = hubMain.Parent
            hubMain:Destroy()

            local targetMain = Instance.new("ScrollingFrame")
            targetMain.Size = UDim2.new(0, 500, 0, 500)
            targetMain.Position = UDim2.new(0.5, 0, 0.5, 0)
            targetMain.AnchorPoint = Vector2.new(0.5, 0.5)
            targetMain.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            targetMain.CanvasSize = UDim2.new(0, 0, 5, 0) -- 세로 스크롤용
            targetMain.ScrollBarThickness = 10
            targetMain.Parent = save

            local selectedPlayers = {}

            local targetButton = createButton(
                "실행하기",
                {0.5, 0},
                {400, 50},
                {60, 60, 60},
                {255, 255, 255},
                function()
                    targetMain.Parent:Destroy()
                    for _, name in ipairs(selectedPlayers) do
                        local plr = game.Players:FindFirstChild(name)
                        if plr and plr.Character then
                            local hrp = plr.Character:WaitForChild("HumanoidRootPart")
                            local myHRP = player.Character:WaitForChild("HumanoidRootPart")
                        
                            -- 시각화용 파트 생성
                            local clone = Instance.new("Part")
                            clone.Size = Vector3.new(30, 30, 30)
                            clone.CFrame = hrp.CFrame
                            clone.Anchored = true
                            clone.CanCollide = false
                            clone.BrickColor = BrickColor.new("Bright red")
                            clone.Parent = workspace
                        
                            local run = game:GetService("RunService")
                            run.RenderStepped:Connect(function()
                                if hrp and hrp.Parent and myHRP and myHRP.Parent then
                                    hrp.Size = Vector3.new(30, 30, 30)
                                    hrp.CFrame = CFrame.new(myHRP.Position + myHRP.CFrame.LookVector * 50)
                                end
                            end)
                        end
                    end
                end
            )
            targetButton.AnchorPoint = Vector2.new(0.5, 0)
            targetButton.Parent = targetMain

            local players = game.Players:GetPlayers()
            for i, plr in ipairs(players) do
                local playerContainer = Instance.new("Frame")
                playerContainer.Size = UDim2.new(0, 400, 0, 50)
                playerContainer.Position = UDim2.new(0.5, 0, 0, i * 55)
                playerContainer.AnchorPoint = Vector2.new(0.5, 0)
                playerContainer.BackgroundTransparency = 1
                playerContainer.Parent = targetMain

                local playerButton = createButton(
                    plr.Name,
                    {0.5, 0.5},
                    {400, 50},
                    {60, 60, 60},
                    {255, 255, 255},
                    nil
                )
                playerButton.Parent = playerContainer

                playerButton.MouseButton1Click:Connect(function()
                    local existingOutline = playerButton:FindFirstChild("Outline")
                    if existingOutline then
                        existingOutline:Destroy()
                        for idx, name in ipairs(selectedPlayers) do
                            if name == plr.Name then
                                table.remove(selectedPlayers, idx)
                                break
                            end
                        end
                    else
                        local outline = Instance.new("UIStroke")
                        outline.Name = "Outline"
                        outline.Color = Color3.fromRGB(255, 0, 0)
                        outline.Thickness = 3
                        outline.Parent = playerButton
                        table.insert(selectedPlayers, plr.Name)
                    end
                end)

                local playerImage = createImage(
                    "playerImage",
                    "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=150&height=150&format=png",
                    {0, 0.5},
                    {40, 40},
                    {225, 225, 225}
                )
                playerImage.AnchorPoint = Vector2.new(0, 0.5)
                playerImage.Parent = playerContainer
            end
        end
    )
    hubButton3.Parent = hubMain

    local hubButton4 = createButton(
        "remote spy",
        {0.45, 0.2},
        {400, 50},
        {60, 60, 60},
        {255,255,255},
        function()
            hubMain.Parent:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Uav3537/scripts/refs/heads/main/remotespy.lua"))()
        end
    )
    hubButton4.Parent = hubMain

    local hubButton5 = createButton(
        "remote fire",
        {0.45, 0.2},
        {400, 50},
        {60, 60, 60},
        {255,255,255},
        function()
            hubMain.Parent:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Uav3537/scripts/refs/heads/main/fireremote.lua"))()
        end
    )
    hubButton5.Parent = hubMain
end

local startMain = createFrame(
    "StartMain",
    {0, 1},
    {200, 150},
    {35, 35, 35}
)

local startButton = createButton(
    "Start",
    {0.75, 0.25},
    {50, 50},
    {50, 50, 50},
    {255,255,255},
    function()
        loadAll(2)
    end
)
startButton.Parent = startMain
loadAll(5)
