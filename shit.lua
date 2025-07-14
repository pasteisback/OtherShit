local Executor = Instance.new("ScreenGui")
local ExecutorUI = Instance.new("Frame")
local title = Instance.new("TextLabel")
local scriptbox = Instance.new("TextBox")
local exec = Instance.new("TextButton")
local cls = Instance.new("TextButton")
local search = Instance.new("TextBox")
local scriptlist = Instance.new("ScrollingFrame")
local HighlightingLabel = Instance.new("TextLabel")

Executor.Name = "Executor"
Executor.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Executor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ExecutorUI.Name = "ExecutorUI"
ExecutorUI.Parent = Executor
ExecutorUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ExecutorUI.BorderSizePixel = 0
ExecutorUI.Position = UDim2.new(0.35221675, 0, 0.295501024, 0)
ExecutorUI.Size = UDim2.new(0.295566499, 0, 0.408997953, 0)

title.Name = "title"
title.Parent = ExecutorUI
title.BackgroundTransparency = 1.000
title.Size = UDim2.new(1, 0, 0.100000001, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "Script Executor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24.000

scriptbox.Name = "scriptbox"
scriptbox.Parent = ExecutorUI
scriptbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scriptbox.Position = UDim2.new(0.0166666675, 0, 0.125, 0)
scriptbox.Size = UDim2.new(0.966666639, 0, 0.400000006, 0)
scriptbox.ClearTextOnFocus = false
scriptbox.Font = Enum.Font.Code
scriptbox.MultiLine = true
scriptbox.Text = ""
scriptbox.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptbox.TextSize = 16.000
scriptbox.TextWrapped = true
scriptbox.TextXAlignment = Enum.TextXAlignment.Left
scriptbox.TextYAlignment = Enum.TextYAlignment.Top

exec.Name = "exec"
exec.Parent = ExecutorUI
exec.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
exec.Position = UDim2.new(0.0166666675, 0, 0.550000012, 0)
exec.Size = UDim2.new(0.150000006, 0, 0.075000003, 0)
exec.Font = Enum.Font.SourceSans
exec.Text = "Execute"
exec.TextColor3 = Color3.fromRGB(255, 255, 255)
exec.TextSize = 16.000

cls.Name = "cls"
cls.Parent = ExecutorUI
cls.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
cls.Position = UDim2.new(0.183333337, 0, 0.550000012, 0)
cls.Size = UDim2.new(0.150000006, 0, 0.075000003, 0)
cls.Font = Enum.Font.SourceSans
cls.Text = "Clear"
cls.TextColor3 = Color3.fromRGB(255, 255, 255)
cls.TextSize = 16.000

search.Name = "search"
search.Parent = ExecutorUI
search.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
search.Position = UDim2.new(0.0166666675, 0, 0.649999976, 0)
search.Size = UDim2.new(0.966666639, 0, 0.075000003, 0)
search.Font = Enum.Font.SourceSans
search.PlaceholderText = "Search ScriptBlox (e.g. Blox Fruits)"
search.Text = ""
search.TextColor3 = Color3.fromRGB(255, 255, 255)
search.TextSize = 16.000

scriptlist.Name = "scriptlist"
scriptlist.Parent = ExecutorUI
scriptlist.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
scriptlist.Position = UDim2.new(0.0166666675, 0, 0.75, 0)
scriptlist.Size = UDim2.new(0.966666639, 0, 0.25, 0)
scriptlist.CanvasSize = UDim2.new(0, 0, 0, 2000)
scriptlist.ScrollBarThickness = 8

HighlightingLabel.Name = "HighlightingLabel"
HighlightingLabel.Parent = ExecutorUI
HighlightingLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HighlightingLabel.BackgroundTransparency = 0.950
HighlightingLabel.ClipsDescendants = true
HighlightingLabel.Position = UDim2.new(0.0166666675, 0, 0.125, 0)
HighlightingLabel.Size = UDim2.new(0.966666639, 0, 0.400000006, 0)
HighlightingLabel.Font = Enum.Font.Code
HighlightingLabel.Text = ""
HighlightingLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
HighlightingLabel.TextSize = 16.000
HighlightingLabel.TextWrapped = true
HighlightingLabel.TextXAlignment = Enum.TextXAlignment.Left
HighlightingLabel.TextYAlignment = Enum.TextYAlignment.Top

local function YTDSSE_fake_script()
	local script = Instance.new('LocalScript', ExecutorUI)

	local UIS = game:GetService("UserInputService")
	local gui = script.Parent
	local dragging, startPos, dragStart
	
	gui.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging, dragStart, startPos = true, i.Position, gui.Position
			i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	
	UIS.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end
coroutine.wrap(YTDSSE_fake_script)()
local function BTBBONW_fake_script()
	local script = Instance.new('LocalScript', ExecutorUI)

	local HttpService = game:GetService("HttpService")
	local UIS = game:GetService("UserInputService")
	
	local resultsFrame = script.Parent.scriptlist
	local scriptBox = script.Parent.scriptbox
	local searchBox = script.Parent.search
	local executeButton = script.Parent.exec
	local clearButton = script.Parent.cls
	local highlightFrame = script.Parent.HighlightingLabel
	
	local function displayResults(results)
		for _, child in ipairs(resultsFrame:GetChildren()) do
			if child:IsA("Frame") then child:Destroy() end
		end
	
		for i, script in ipairs(results) do
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 60)
			frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			frame.Position = UDim2.new(0, 0, 0, (i - 1) * 65)
			frame.Parent = resultsFrame
	
			local label = Instance.new("TextLabel")
			label.Text = script.title
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Size = UDim2.new(1, -100, 1, 0)
			label.Position = UDim2.new(0, 10, 0, 0)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Font = Enum.Font.SourceSansBold
			label.TextSize = 16
			label.Parent = frame
	
			local execute = Instance.new("TextButton")
			execute.Text = "Execute"
			execute.Size = UDim2.new(0, 90, 0, 30)
			execute.Position = UDim2.new(1, -100, 0.5, -15)
			execute.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
			execute.TextColor3 = Color3.fromRGB(255, 255, 255)
			execute.Font = Enum.Font.SourceSans
			execute.TextSize = 14
			execute.Parent = frame
	
			execute.MouseButton1Click:Connect(function()
				local code = game:HttpGet("https://scriptblox.com/api/script/fetch/" .. script.slug)
				local json = HttpService:JSONDecode(code)
				scriptBox.Text = json.result.script
			end)
		end
	end
	
	scriptBox:GetPropertyChangedSignal("Text"):Connect(function()
		local text = scriptBox.Text
		local lastChar = text:sub(-1)
		local autoClose = {
			["("] = ")",
			["["] = "]",
			["{"] = "}",
			["\""] = "\"",
			["'"] = "'"
		}
	
		if autoClose[lastChar] then
			local cursor = scriptBox.CursorPosition
			scriptBox.Text = text .. autoClose[lastChar]
			scriptBox.CursorPosition = cursor
		end
	end)
	
	searchBox.FocusLost:Connect(function(enter)
		if searchBox.Text == "" then return end
	
		local query = HttpService:UrlEncode(searchBox.Text)
		local success, result = pcall(function()
			return HttpService:JSONDecode(game:HttpGet("https://scriptblox.com/api/script/search?q=" .. query))
		end)
	
		if success and result.result and result.result.scripts then
			displayResults(result.result.scripts)
		else
			game.StarterGui:SetCore("SendNotification", {
				Title = "Error",
				Text = "Failed to connect to ScriptBlox.",
				Duration = 5,
			})
		end
	end)
	
	executeButton.MouseButton1Click:Connect(function()
		if scriptBox.Text == "" then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Error",
				Text = "Please enter a password!",
				Duration = 5,
			})
		end
		local success, err = pcall(function()
			loadstring(scriptBox.Text)()
		end)
		if not success then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Error",
				Text = err,
				Duration = 5,
			})
		end
	end)
	
	clearButton.MouseButton1Click:Connect(function()
		scriptBox.Text = ""
	end)
end
coroutine.wrap(BTBBONW_fake_script)()
local function LXDLIFT_fake_script()
	local script = Instance.new('LocalScript', Executor)

	local UIS = game:GetService("UserInputService")
	
	local frame = script.Parent
	local visible = false
	
	frame.Enabled = false
	
	UIS.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Insert then
			visible = not visible
			if visible then
				frame.Enabled = true
			else
				if not visible then frame.Enabled = false end
			end
		end
	end)
end
coroutine.wrap(LXDLIFT_fake_script)()
