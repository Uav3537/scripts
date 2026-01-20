local function hook(list)
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        local isTarget = false
        for _, v in pairs(list) do
            if v == self then
                isTarget = true
                break
            end
        end
        
        if isTarget then
            if method == "FireServer" then
                print("\n--------------------------------------")
                print("📤 [Client -> Server (FireServer)]")
                print("이름: [" .. self.Name .. "] -- (RemoteEvent)")
                print("인자: ", unpack(args))
                print("--------------------------------------\n")
            elseif method == "InvokeServer" then
                local results = {oldNamecall(self, ...)}
                print("\n--------------------------------------")
                print("📤 [Client -> Server (InvokeServer)]")
                print("이름: [" .. self.Name .. "] -- (RemoteFunction)")
                print("인자: ", unpack(args))
                print("결과: ", unpack(results))
                print("--------------------------------------\n")
                return unpack(results)
            end
        end
        return oldNamecall(self, ...)
    end)

    for _, v in pairs(list) do
        if v:IsA("RemoteEvent") then
            v.OnClientEvent:Connect(function(...)
                local args = {...}
                print("\n--------------------------------------")
                print("📥 [Server -> Client (FireServer)]")
                print("이름: [" .. v.Name .. "] -- (RemoteEvent)")
                print("인자: ", unpack(args))
                print("--------------------------------------\n")
            end)
        end
    end

    local oldNewIndex
    oldNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
        local isTarget = false
        for _, v in pairs(list) do
            if v == self and self:IsA("RemoteFunction") then
                isTarget = true
                break
            end
        end

        if isTarget and key == "OnClientInvoke" and type(value) == "function" then
            local oldCallback = value

            local hookedCallback = function(...)
                local args = {...}
                local results = {oldCallback(...)}

                print("\n--------------------------------------")
                print("📥 [Server -> Client (InvokeServer)]")
                print("이름: [" .. self.Name .. "] -- (RemoteFunction)")
                print("인자: ", unpack(args))
                print("응답: ", unpack(results))
                print("--------------------------------------\n")
                return unpack(results)
            end

            return oldNewIndex(self, key, hookedCallback)
        end
        
        return oldNewIndex(self, key, value)
    end)
end

local targets = {
    game:GetService("ReplicatedStorage"):WaitForChild("Sans", 5):WaitForChild("Dash"),
    game:GetService("ReplicatedStorage"):WaitForChild("Sans", 5):WaitForChild("Spawn"),
	game:GetService("ReplicatedStorage"):WaitForChild("Sans", 5):WaitForChild("Projectile"),
	game:GetService("ReplicatedStorage"):WaitForChild("Sans", 5):WaitForChild("ProjectileS"),
    game:GetService("ReplicatedStorage"):WaitForChild("ResetDeath", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("Death", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("Kill", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("OnHit", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("CutSceneEvent", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("InCombat", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("MouseInvoke", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("Health", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("tppls", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("YouDead", 5),
	game:GetService("ReplicatedStorage"):WaitForChild("Slash", 5),
}

hook(targets)
print("✅ All-in-One Hook Active!")
