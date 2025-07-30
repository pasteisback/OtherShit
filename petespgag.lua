--// ESP script for my pookie
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer
local Pets = workspace:WaitForChild("PetsPhysical")

local Drawings = {}

Drawing = Drawing

local function getEquippedPets()
	local pets_equipped = {}
	for _, petmover in pairs(Pets:GetChildren()) do
		for _, pet in pairs(petmover:GetChildren()) do
			if pet:IsA("Model") and pet.Name ~= "RootPart_PetMover_WELD" then
				table.insert(pets_equipped, pet)
			end
		end
	end
	return pets_equipped
end

local function formatTime(seconds)
	if not seconds then return "N/A" end
	seconds = math.floor(tonumber(seconds))
	local minutes = math.floor(seconds / 60)
	local remaining = seconds % 60
	return string.format("%d:%02d", minutes, remaining)
end

local function getPetCooldown(petId)
	local result = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("GetPetCooldown"):InvokeServer(petId)
	local inner = result[1]
	if typeof(inner) == "table" then
		for _, v in pairs(inner) do
			return formatTime(v)
		end
	end
	return "N/A"
end

local function getPetName(petId)
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	local activePetUI = playerGui:FindFirstChild("ActivePetUI")
	if not activePetUI then return nil end

	local frame = activePetUI:FindFirstChild("Frame")
	if not frame then return nil end

	local scrollingFrame = frame:FindFirstChild("Main")
	if not scrollingFrame then return nil end

	scrollingFrame = scrollingFrame:FindFirstChild("ScrollingFrame")
	if not scrollingFrame then return nil end

	local petFrame = scrollingFrame:FindFirstChild(petId)
	if not petFrame then return nil end

	local petTypeLabel = petFrame:FindFirstChild("PET_TYPE")
	if not petTypeLabel then return nil end

	return petTypeLabel.Text
end

local function getPetHookPart(petId)
	for _, petmover in pairs(Pets:GetChildren()) do
		for _, pet in pairs(petmover:GetChildren()) do
			if pet.Name == petId then
				local baseParts = {}
				for _, part in pairs(pet:GetChildren()) do
					if part:IsA("BasePart") then
						table.insert(baseParts, part)
					end
				end
				if #baseParts > 0 then
					return baseParts[math.random(1, #baseParts)]
				end
			end
		end
	end
	return nil
end

local function playerOwnPet(petId)
	return getPetName(petId) ~= nil
end

for _, pet in ipairs(getEquippedPets()) do
	local petId = pet.Name
	local cooldown = getPetCooldown(petId)
	local hookPart = getPetHookPart(petId)
	if hookPart and playerOwnPet(petId) then
		local text = Drawing.new("Text")
		text.Center = true
		text.Outline = true
		text.Size = 16
		text.Color = Color3.fromRGB(255, 255, 255)
		text.Text = "⌛ " .. cooldown
		text.Visible = true

		Drawings[petId] = {
			part = hookPart,
			drawing = text
		}
	end
end

RunService.RenderStepped:Connect(function()
	for petId, data in pairs(Drawings) do
		local hookPart = data.part
		local drawing = data.drawing

		if hookPart and hookPart:IsDescendantOf(workspace) then
			local screenPos, onScreen = Camera:WorldToViewportPoint(hookPart.Position)
			drawing.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
			drawing.Visible = onScreen
		else
			drawing.Visible = false
		end
	end
end)

task.spawn(function()
	while true do
		for petId, data in pairs(Drawings) do
			if playerOwnPet(petId) then
				local cooldown = getPetCooldown(petId)
				data.drawing.Text = "⌛ " .. cooldown
			end
		end
		task.wait(1)
	end
end)
