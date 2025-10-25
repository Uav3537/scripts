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

for i = 0, 5 do
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end
)
hubButton2.Parent = hubMain
