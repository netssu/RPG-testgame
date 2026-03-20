------------------//SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")

------------------//CONSTANTS

------------------//VARIABLES
export type SkillData = {
	Type: string, -- "Passive" ou "Active"
	Name: string,
	Description: string,
	Value: number?,
	Cooldown: number?,
	Icon: string
}

local SkillsConfig: {[string]: SkillData} = {
	-- PASSIVAS
	["JumpBoost_Weak"] = { Type = "Passive", Name = "Pulo Forte", Description = "Aumenta levemente a força do pulo.", Value = 15, Icon = "rbxassetid://82346463581106" },
	["JumpBoost_Strong"] = { Type = "Passive", Name = "Pulo Titânico", Description = "Aumenta drasticamente a força do pulo.", Value = 45, Icon = "rbxassetid://82346463581106" },
	
	["CoinDrop_Weak"] = { Type = "Passive", Name = "Miner", Description = "Gera 5 moedas a cada 15 segundos.", Value = 100, Cooldown = 15, Icon = "rbxassetid://82346463581106" },
	["CoinDrop_Strong"] = { Type = "Passive", Name = "Tesouro", Description = "Gera 25 moedas a cada 10 segundos.", Value = 25, Cooldown = 10, Icon = "rbxassetid://82346463581106" },
	
	["SecondChance"] = { Type = "Passive", Name = "Salva Vidas", Description = "Garante um auto-jump ao errar uma queda. Recarrega em 60s.", Cooldown = 60, Icon = "rbxassetid://82346463581106" },

	-- ATIVAS
	["Dash"] = { Type = "Active", Name = "Dash", Description = "Dá um impulso para frente enquanto está no ar.", Cooldown = 5, Value = 150, Icon = "rbxassetid://82346463581106" },
	["DoubleJump"] = { Type = "Active", Name = "Pulo Duplo", Description = "Permite pular novamente enquanto estiver no ar.", Cooldown = 8, Icon = "rbxassetid://82346463581106" },
	["SuperJump"] = { Type = "Active", Name = "Super Pulo", Description = "O seu próximo pulo será 2.5x mais forte.", Value = 2.5, Cooldown = 30, Icon = "rbxassetid://82346463581106" },
	["TempAutoJump"] = { Type = "Active", Name = "Frenesi", Description = "Ativa o Auto-Jump de graça por 8 segundos.", Value = 8, Cooldown = 45, Icon = "rbxassetid://82346463581106" }
}

local DataSkills = {}

------------------//FUNCTIONS
function DataSkills.GetSkillData(skillName: string): SkillData?
	return SkillsConfig[skillName]
end

------------------//INIT
return DataSkills