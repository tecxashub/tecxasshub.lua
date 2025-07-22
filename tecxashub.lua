-- Tecxas Hub - Localizador Brainots ativado automaticamente
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Listas dos Brainots
local brainotsGods = {
	["tralalero tralala"] = true,
	["matteo"] = true,
	["odin din din dun"] = true,
	["orcalero orcala"] = true,
	["tigroline frutonni"] = true,
	["estatutino libertino"] = true,
	["espresso signora"] = true,
	["trenostruzzo turbo 3000"] = true
}

local brainotsSecretos = {
	["la vacca saturno saturnita"] = true,
	["os tralaleritos"] = true,
	["las tralalelitas"] = true,
	["graipuss medussi"] = true
}

local localizadorAtivo = true -- Já começa ativado

-- Cria GUI base
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TecxasHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 200)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.Text = "Tecxas Hub - Localizador Brainots"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.new(1,1,1)
statusLabel.Text = "Localizador: ATIVADO"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 18
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local resultadoLabel = Instance.new("TextLabel")
resultadoLabel.Size = UDim2.new(1, -20, 0, 80)
resultadoLabel.Position = UDim2.new(0, 10, 0, 85)
resultadoLabel.BackgroundTransparency = 1
resultadoLabel.TextColor3 = Color3.new(1,1,1)
resultadoLabel.Text = "Buscando Brainots..."
resultadoLabel.Font = Enum.Font.Gotham
resultadoLabel.TextSize = 16
resultadoLabel.TextWrapped = true
resultadoLabel.TextYAlignment = Enum.TextYAlignment.Top
resultadoLabel.TextXAlignment = Enum.TextXAlignment.Left
resultadoLabel.Parent = mainFrame

-- Botão ligar/desligar (opcional, pode controlar localizador)
local btnToggle = Instance.new("TextButton")
btnToggle.Size = UDim2.new(0, 150, 0, 30)
btnToggle.Position = UDim2.new(0, 10, 1, -45)
btnToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btnToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
btnToggle.Text = "Desativar Localizador"
btnToggle.Font = Enum.Font.GothamBold
btnToggle.TextSize = 18
btnToggle.Parent = mainFrame

-- Som de alerta
local function tocarSomAlerta()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://911882326"
	sound.Volume = 1
	sound.Parent = workspace
	sound:Play()
	sound.Ended:Connect(function() sound:Destroy() end)
end

-- Função para verificar Brainots no Workspace
local function verificarBrainots()
	local encontrados = {}
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") then
			local nome = string.lower(obj.Name)
			if brainotsGods[nome] then
				table.insert(encontrados, "🟡 GOD: " .. obj.Name)
			elseif brainotsSecretos[nome] then
				table.insert(encontrados, "🔴 SECRETO: " .. obj.Name)
			end
		end
	end
	return encontrados
end

-- Atualiza resultado na GUI e toca som se achar
local function executarBusca()
	if not localizadorAtivo then return end

	local lista = verificarBrainots()
	if #lista > 0 then
		resultadoLabel.Text = "🚨 Brainots encontrados (".. #lista .."):\n" .. table.concat(lista, "\n")
		tocarSomAlerta()
	else
		resultadoLabel.Text = "✅ Nenhum Brainot raro encontrado neste servidor."
	end
end

-- Alterna status localizador via botão
btnToggle.MouseButton1Click:Connect(function()
	localizadorAtivo = not localizadorAtivo
	if localizadorAtivo then
		btnToggle.Text = "Desativar Localizador"
		statusLabel.Text = "Localizador: ATIVADO"
		executarBusca()
	else
		btnToggle.Text = "Ativar Localizador"
		statusLabel.Text = "Localizador: DESATIVADO"
		resultadoLabel.Text = "Localizador desligado."
	end
end)

-- Busca inicial já ao executar o script
executarBusca()

-- Atualiza a busca a cada 15 segundos enquanto ativo
while true do
	wait(15)
	if localizadorAtivo then
		executarBusca()
	end
end
