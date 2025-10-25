local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createFrame(name, position, size, color)
    local screen = Instance.new("ScreenGui")
    screen.Name = name
    screen.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(unpack(size))
    frame.Position = UDim2.new(unpack(position))
    frame.BackgroundColor3 = Color3.fromRGB(unpack(color))
    frame.Parent = screen

    return frame
end

local function createText(name, txt, position, size, color)
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = txt
    textLabel.Size = UDim2.new(unpack(size))
    textLabel.Position = UDim2.new(unpack(position))
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
    imgLabel.Size = UDim2.new(unpack(size))
    imgLabel.Position = UDim2.new(unpack(position))
    imgLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imgLabel.BackgroundTransparency = 1
    return imgLabel
end

local loadMain = createFrame(
    "LoadMain",
    {0.5, -150, 0.5, -100},
    {0, 300, 0, 200},
    {35, 35, 35}
)

local loadLabel = createText(
    "LoadLabel",
    "Victory Path Scripts",
    {0.5, 0.5, 0, 0},
    {0, 200, 0, 50},
    {225,225,225}
)
loadLabel.Parent = loadMain

local loadAuthor = createText(
    "loadAuthor",
    "by Drone",
    {0.0, 0, 0.8, 0},
    {0, 200, 0, 20},
    {225,225,225}
)
loadAuthor.Parent = loadLabel

local loadText = createText(
    "LoadText",
    "로딩중",
    {0.45, 0, 0.8, 0},
    {0, 50, 0, 50},
    {225,225,225}
)
loadText.Parent = loadMain

local loadPlayerName = createText(
    "loadPlayerName",
    player.DisplayName .." (@"..player.Name..")",
    {0.3, 0, 0.75, 0},
    {0, 150, 0, 20},
    {225,225,225}
)
loadPlayerName.Parent = loadMain

local loadPlayerImage = createImage(
    "loadPlayerImage",
    "https://www.roblox.com/headshot-thumbnail/image?userId=" 
        .. player.UserId 
        .. "&width=150&height=150&format=png",
    {0.45, 0, 0.5, 0},
    {0, 50, 0, 50},
    {225,225,225}
)
loadPlayerImage.Parent = loadMain
