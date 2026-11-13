-- [[ Tdou ouop Script ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- สร้าง ScreenGui และหน้าต่างหลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TdouOuopGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 260)
mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- ทำให้ลากหน้าต่างไปมาได้
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- ชื่อหัวข้อสคริปต์
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Tdou ouop"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- ฟังก์ชันสำหรับสร้างปุ่ม Toggle
local function createButton(name, posY, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 45)
	btn.Position = UDim2.new(0.05, 0, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamSemibold
	btn.Text = name .. ": OFF"
	btn.Parent = mainFrame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn
	
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(75, 180, 100)
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.Text = name .. ": ON"
		else
			btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
			btn.TextColor3 = Color3.fromRGB(200, 200, 200)
			btn.Text = name .. ": OFF"
		end
		callback(state)
	end)
end

-- ตัวแปรสถานะฟังก์ชัน
local invisibleActive = false
local noclipActive = false
local wallWalkActive = false

-- 1. ฟังก์ชันหายตัว (Invisibility)
createButton("หายตัว (Invisible)", 50, function(state)
	invisibleActive = state
	local character = player.Character
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Decal") then
				if part.Name ~= "HumanoidRootPart" then
					part.Transparency = invisibleActive and 1 or 0
				end
			end
		end
	end
end)

-- รีเซ็ตความโปร่งใสเมื่อตัวละครเกิดใหม่
player.CharacterAdded:Connect(function(newChar)
	task.wait(0.5)
	if invisibleActive then
		for _, part in ipairs(newChar:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("Decal") then
				if part.Name ~= "HumanoidRootPart" then
					part.Transparency = 1
				end
			end
		end
	end
end)

-- 2. ฟังก์ชันทะลุกำแพง (Noclip)
createButton("ทะลุกำแพง (Noclip)", 105, function(state)
	noclipActive = state
end)

RunService.Stepped:Connect(function()
	if noclipActive then
		local character = player.Character
		if character then
			for _, part in ipairs(character:GetDesc
          
