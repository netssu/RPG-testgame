-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

-- CONSTANTS
local SKIP_CENTER_POSITION = UDim2.fromScale(0.5, 0.5)

-- VARIABLES
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Referenciando a nova UI que configuramos anteriormente
local SkipUI = playerGui:WaitForChild("NewUI"):WaitForChild("Skip")
SkipUI.AnchorPoint = Vector2.new(0.5, 0.5)
SkipUI.Position = SKIP_CENTER_POSITION

local UIHandler = require(ReplicatedStorage.Modules.Client.UIHandler)

-- FUNCTIONS
local function setInteractionContext(context)
	SkipUI:SetAttribute("InteractionContext", context)
end

-- INIT
repeat task.wait() until player:FindFirstChild("DataLoaded")

ReplicatedStorage.Events.SkipGui.OnClientEvent:Connect(function(visible, SecondArgument: {})

	if SecondArgument then
		if SecondArgument.Yes then
			-- Verifica se o texto existe antes de alterar para evitar erros na nova UI
			local voteText = SkipUI:FindFirstChild("PlayersVoteText", true)
			if voteText then
				voteText.Text = `{SecondArgument.Yes}/{math.ceil(#Players:GetPlayers()) }`
			end
			UIHandler.PlaySound("Skip")
			return
		end

		if SecondArgument.Required then
			local voteText = SkipUI:FindFirstChild("PlayersVoteText", true)
			if voteText then
				voteText.Text = `{0}/{math.ceil(#Players:GetPlayers())}`
			end
		end
	end

	if visible == true then
		setInteractionContext("WaveSkip")
		SkipUI.Position = SKIP_CENTER_POSITION
	elseif visible == false then
		setInteractionContext(nil)
	end

	SkipUI.Visible = visible

	if visible == true and UserInputService.GamepadEnabled then
		local btnToSelect = SkipUI:IsA("GuiButton") and SkipUI or SkipUI:FindFirstChildWhichIsA("GuiButton", true)
		if btnToSelect then
			GuiService.SelectedObject = btnToSelect
		end
	end

end)
