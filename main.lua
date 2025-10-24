local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "MyCustomUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

-- 닫기 버튼
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 30)
closeButton.Position = UDim2.new(1, -55, 0, 5)
closeButton.Text = "X"
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- 버튼들을 담을 ScrollingFrame
local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Size = UDim2.new(1, -10, 1, -50)
buttonContainer.Position = UDim2.new(0, 5, 0, 40)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = frame
buttonContainer.CanvasSize = UDim2.new(0,0,0,0)

-- 자동 정렬
local layout = Instance.new("UIListLayout")
layout.Parent = buttonContainer
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,5)

local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name
    btn.Parent = buttonContainer
    btn.BackgroundColor3 = Color3.fromRGB(100,100,100)

    -- 버튼 클릭 시
    btn.MouseButton1Click:Connect(function()
        -- 사용자 기능 실행
        if callback then
            pcall(callback)  -- 안전하게 실행
        end

        -- 전체 프레임 삭제
        if frame and frame.Parent then
            frame:Destroy()
        end
    end)
end

createButton("infinite yield", function() loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Infinite%20Yield.lua"))() end)
createButton("dex explorer", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)
createButton("hitbox", function() print("버튼 3 클릭") end)
