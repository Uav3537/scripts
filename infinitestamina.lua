local Players = game:GetService("Players")
local character = Players.LocalPlayer.Character
local RunService = game:GetService("RunService")

local stamina = character.Data.RunStamina
local staminaMax = stamina.Max

RunService.Heartbeat:Connect(function()
    stamina.Value = staminaMax.Value
end)
