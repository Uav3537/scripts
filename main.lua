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
createButton("hitbox", function()
    -- 입력창 Frame 생성
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(0, 250, 0, 120)
    inputFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
    inputFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    inputFrame.Parent = playerGui
    inputFrame.Active = true
    inputFrame.Draggable = true

    -- TextBox 생성
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 230, 0, 40)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.PlaceholderText = "RemoteEvent 이름 입력"
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputFrame

    -- Fire 버튼 생성
    local fireBtn = Instance.new("TextButton")
    fireBtn.Size = UDim2.new(0, 100, 0, 30)
    fireBtn.Position = UDim2.new(0.5, -50, 0, 60)
    fireBtn.Text = "Fire!"
    fireBtn.Parent = inputFrame

    -- 클릭 이벤트https://github.com/Uav3537/scripts/new/main
    fireBtn.MouseButton1Click:Connect(function()
        local eventName = textBox.Text
        if eventName and eventName ~= "" then
            local remoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
            if remoteEvent and remoteEvent:IsA("RemoteEvent") then
                remoteEvent:FireServer() -- 필요하면 인자 추가
                print(eventName .. " fired!")
            else
                warn("RemoteEvent가 존재하지 않거나 RemoteEvent가 아님")
            end
        end
        inputFrame:Destroy() -- 발사 후 창 닫기
    end)
end)

