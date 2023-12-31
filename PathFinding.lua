--file stored inside an npc/player model with a Humanoid and HumanoidRootPart

local Players = game:GetService("Players")

local npc = script.Parent
local hrp = npc:WaitForChild("HumanoidRootPart")
local npcHumanoid = npc:WaitForChild("Humanoid")

local DETECTION_DISTANCE = 50


local function GetNearestChar(proximity: number)
	local playerhrp = nil
	
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character or p.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if char and char:FindFirstChild("HumanoidRootPart") and humanoid and humanoid.Health > 0 then
			local distance = (hrp.Position - char:FindFirstChild("HumanoidRootPart").Position).Magnitude
			if distance < proximity then
				proximity = distance
				playerhrp = char:FindFirstChild("HumanoidRootPart")
			end
		end
	end
	
	return playerhrp, proximity --return proximity because it could be useful if you want to know it (I don't but could be useful at somepoint)
end


while task.wait(1) do
	local target, _ = GetNearestChar(DETECTION_DISTANCE)
	
	if target then
		npcHumanoid:MoveTo(target.Position, target) --second argument added for smoother movement
	end
end
