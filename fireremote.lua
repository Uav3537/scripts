local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI 생성
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "FireRemoteGUI"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 220)
frame.Position = UDim2.new(0.5, -175, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.Parent = screenGui

-- 닫기 버튼
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 30)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.Text = "X"
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Remote 이름 입력
local nameBox = Instance.new("TextBox")
nameBox.PlaceholderText = "RemoteEvent 이름 입력"
nameBox.Size = UDim2.new(0, 330, 0, 40)
nameBox.Position = UDim2.new(0, 10, 0, 40)
nameBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
nameBox.TextColor3 = Color3.fromRGB(255,255,255)
nameBox.Parent = frame

-- 인자 입력
local argsBox = Instance.new("TextBox")
argsBox.PlaceholderText = '인자 입력 (쉼표로 구분, 예: true, Workspace.Players.PlayerName, "Punch")'
argsBox.Size = UDim2.new(0, 330, 0, 40)
argsBox.Position = UDim2.new(0, 10, 0, 90)
argsBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
argsBox.TextColor3 = Color3.fromRGB(255,255,255)
argsBox.Parent = frame

-- 실행 버튼
local fireButton = Instance.new("TextButton")
fireButton.Text = "실행"
fireButton.Size = UDim2.new(0, 100, 0, 30)
fireButton.Position = UDim2.new(0.5, -50, 0, 150)
fireButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
fireButton.TextColor3 = Color3.fromRGB(255,255,255)
fireButton.Parent = frame

-- FireServer 실행
fireButton.MouseButton1Click:Connect(function()
    local nameInput = nameBox.Text
    local argsInput = argsBox.Text
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

    if not found then
        warn("RemoteEvent 찾을 수 없음")
        return
    end

    -- 인자 처리 (loadstring로 실제 Lua 값으로 평가)
    local args = {}
    if argsInput ~= "" then
        for str in string.gmatch(argsInput, '([^,]+)') do
            str = str:match("^%s*(.-)%s*$") -- 앞뒤 공백 제거

            local value
            local success, result = pcall(function()
                return loadstring("return " .. str)()
            end)
            if success then
                value = result
            else
                value = str -- 실패하면 그냥 문자열
            end

            table.insert(args, value)
        end
    end

    -- RemoteEvent FireServer 호출
    found:FireServer(unpack(args))
    print("Fired RemoteEvent:", found:GetFullName(), "with args:", unpack(args))
end)
