local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI 생성
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "FireRemoteGUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0.5, -150, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.Parent = screenGui

local textBox = Instance.new("TextBox")
textBox.PlaceholderText = "Remote 이름 입력"
textBox.Size = UDim2.new(0, 280, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.Parent = frame

local fireButton = Instance.new("TextButton")
fireButton.Text = "실행"
fireButton.Size = UDim2.new(0, 100, 0, 30)
fireButton.Position = UDim2.new(0.5, -50, 0, 60)
fireButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
fireButton.TextColor3 = Color3.fromRGB(255,255,255)
fireButton.Parent = frame

fireButton.MouseButton1Click:Connect(function()
    local nameInput = textBox.Text
    if nameInput == "" then return end

    -- ReplicatedStorage에서 RemoteEvent 검색
    local rs = game:GetService("ReplicatedStorage")
    local found = nil
    for _, obj in pairs(rs:GetDescendants()) do
        if obj:IsA("RemoteEvent") and string.find(obj.Name:lower(), nameInput:lower()) then
            found = obj
            break
        end
    end

    if found then
        -- FireServer 호출
        found:FireServer()
        print("Fired RemoteEvent:", found:GetFullName())
    else
        warn("RemoteEvent 찾을 수 없음")
    end
end)
