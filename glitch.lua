local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()

local TimeMulti = character.Data.TimeMulti
TimeMulti.Value = 5
