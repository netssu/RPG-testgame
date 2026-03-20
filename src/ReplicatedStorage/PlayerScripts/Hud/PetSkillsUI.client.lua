------------------//SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

------------------//VARIABLES
local SkillsData = require(ReplicatedStorage.Modules.Datas.PetsSkillsData)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local uiRoot = playerGui:WaitForChild("UI")
local hud = uiRoot:WaitForChild("GameHUD")

local petSkillsUI = hud:WaitForChild("PetSkills")
local skillIcon = petSkillsUI:WaitForChild("Icon")
local skillBindText = petSkillsUI:WaitForChild("BindText")
local skillName = petSkillsUI:WaitForChild("SkillName")
local skillCooldownOverlay = petSkillsUI:WaitForChild("CooldownOverlay")
local skillTimerText = petSkillsUI:WaitForChild("TimerText")

local currentTween = nil
local timerConnection = nil

------------------//FUNCTIONS
local function startCooldownAnim(duration)
	if currentTween then currentTween:Cancel() end
	if timerConnection then timerConnection:Disconnect() timerConnection = nil end
	
	skillTimerText.Visible = true
	skillCooldownOverlay.Visible = true
	
	skillCooldownOverlay.AnchorPoint = Vector2.new(0.5, 1)
	skillCooldownOverlay.Position = UDim2.new(0.5, 0, 1, 0)
	skillCooldownOverlay.Size = UDim2.new(1, 0, 1, 0) 
	
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	currentTween = TweenService:Create(skillCooldownOverlay, tweenInfo, { Size = UDim2.new(1, 0, 0, 0) })
	currentTween:Play()
	
	local endTime = os.clock() + duration
	
	timerConnection = RunService.RenderStepped:Connect(function()
		local remaining = endTime - os.clock()
		
		if remaining > 0 then
			skillTimerText.Text = string.format("%.1f", remaining)
		else
			skillTimerText.Visible = false
			skillCooldownOverlay.Visible = false
			if timerConnection then
				timerConnection:Disconnect()
				timerConnection = nil
			end
		end
	end)
end

local function updateUI()
	local equippedSkillId = player:GetAttribute("EquippedSkill")
	
	if equippedSkillId and equippedSkillId ~= "" then
		local skillInfo = SkillsData.GetSkillData(equippedSkillId)
		
		if skillInfo then
			petSkillsUI.Visible = true
			skillIcon.Image = skillInfo.Icon
			skillName.Text = skillInfo.Name
			
			if skillInfo.Type == "Active" then
				skillBindText.Visible = true
			else
				skillBindText.Visible = false
			end
		end
	else
		petSkillsUI.Visible = false
	end
end

------------------//INIT
skillCooldownOverlay.Visible = false
skillTimerText.Visible = false
skillCooldownOverlay.Size = UDim2.new(1, 0, 0, 0)

player:GetAttributeChangedSignal("EquippedSkill"):Connect(updateUI)

player:GetAttributeChangedSignal("SkillCooldownEnd"):Connect(function()
	local endTime = player:GetAttribute("SkillCooldownEnd")
	if endTime then
		local remaining = endTime - os.clock()
		if remaining > 0 then
			startCooldownAnim(remaining)
		end
	end
end)

updateUI()