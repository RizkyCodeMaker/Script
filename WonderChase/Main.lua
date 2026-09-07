-- =====================================================
-- Wonder Chase | Main Loader v0.04
-- GUI + Engine generik. Config tiap obby di-load dari
-- GitHub via loadstring(game:HttpGet(url))() saat dipilih.
-- =====================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local PG = player:WaitForChild("PlayerGui")

-- =====================================================
-- KONFIGURASI SUMBER OBBY (ganti sesuai repo GitHub kamu)
-- =====================================================
-- Pastikan pakai raw.githubusercontent.com, bukan github.com biasa.
local BASE_URL = "https://raw.githubusercontent.com/RizkyCodeMaker/Script/main/WonderChase/Obbies/"

-- Nama obby -> nama file (tanpa .lua) di folder Obbies/
local OBBY_FILES = {
    ["BBC"]             = "BBC",
    ["Secret Garden"]   = "SecretGarden",
    ["TNS"]             = "TNS",
    ["MOTD"]            = "MOTD",
    ["EastEnders"]      = "EastEnders",
    ["Crook Heaven"]    = "CrookHeaven",
    ["Shaun The Sheep"] = "ShaunTheSheep",
    ["Sciences"]        = "Sciences",
}

-- Cache config yang sudah di-load supaya tidak fetch berulang tiap Start
local obbyConfigCache = {}

local function loadObbyConfig(name)
    if obbyConfigCache[name] then
        return obbyConfigCache[name]
    end

    local fileName = OBBY_FILES[name]
    if not fileName then
        return nil, "Nama obby tidak terdaftar di OBBY_FILES"
    end

    local url = BASE_URL .. fileName .. ".lua"

    local ok, srcOrErr = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        return nil, "Gagal fetch: " .. tostring(srcOrErr)
    end

    local loadOk, chunkOrErr = pcall(function()
        return loadstring(srcOrErr)()
    end)
    if not loadOk then
        return nil, "Gagal load script: " .. tostring(chunkOrErr)
    end

    obbyConfigCache[name] = chunkOrErr
    return chunkOrErr
end

-- =====================================================
-- GUI BUILD
-- =====================================================
pcall(function()
    if PG:FindFirstChild("WonderChaseGUI") then PG.WonderChaseGUI:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WonderChaseGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PG

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(300, 310)
Main.Position = UDim2.fromOffset(60, 150)
Main.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Thickness = 1.5
mainStroke.Color = Color3.fromRGB(80, 85, 120)

-- Header Bar
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 14)
HeaderFix.Position = UDim2.new(0, 0, 1, -14)
HeaderFix.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.fromOffset(12, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Wonder Chase  |  v0.04"
TitleLabel.TextColor3 = Color3.fromRGB(180, 190, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local BtnMin = Instance.new("TextButton")
BtnMin.Size = UDim2.fromOffset(26, 26)
BtnMin.Position = UDim2.new(1, -58, 0.5, -13)
BtnMin.BackgroundColor3 = Color3.fromRGB(60, 65, 90)
BtnMin.Text = "–"
BtnMin.TextColor3 = Color3.fromRGB(210, 215, 255)
BtnMin.Font = Enum.Font.GothamBold
BtnMin.TextSize = 16
BtnMin.BorderSizePixel = 0
BtnMin.Parent = Header
Instance.new("UICorner", BtnMin).CornerRadius = UDim.new(0, 8)

local BtnClose = Instance.new("TextButton")
BtnClose.Size = UDim2.fromOffset(26, 26)
BtnClose.Position = UDim2.new(1, -28, 0.5, -13)
BtnClose.BackgroundColor3 = Color3.fromRGB(160, 40, 50)
BtnClose.Text = "✕"
BtnClose.TextColor3 = Color3.fromRGB(255, 200, 205)
BtnClose.Font = Enum.Font.GothamBold
BtnClose.TextSize = 13
BtnClose.BorderSizePixel = 0
BtnClose.Parent = Header
Instance.new("UICorner", BtnClose).CornerRadius = UDim.new(0, 8)

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, -24, 0, 250)
Body.Position = UDim2.fromOffset(12, 52)
Body.BackgroundTransparency = 1
Body.Parent = Main

local SelectLabel = Instance.new("TextLabel")
SelectLabel.Size = UDim2.new(1, 0, 0, 20)
SelectLabel.Position = UDim2.fromOffset(0, 0)
SelectLabel.BackgroundTransparency = 1
SelectLabel.Text = "Select Obby :"
SelectLabel.TextColor3 = Color3.fromRGB(170, 175, 210)
SelectLabel.Font = Enum.Font.GothamBold
SelectLabel.TextSize = 13
SelectLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectLabel.Parent = Body

local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(1, 0, 0, 34)
DropBtn.Position = UDim2.fromOffset(0, 22)
DropBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 52)
DropBtn.Text = "  ▾  Pilih Obby..."
DropBtn.TextColor3 = Color3.fromRGB(200, 205, 235)
DropBtn.Font = Enum.Font.Gotham
DropBtn.TextSize = 13
DropBtn.TextXAlignment = Enum.TextXAlignment.Left
DropBtn.BorderSizePixel = 0
DropBtn.Parent = Body
Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", DropBtn).Color = Color3.fromRGB(70, 75, 110)

local ITEM_H = 34
local MAX_VISIBLE = 5

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(1, -24, 0, 0)
DropList.Position = UDim2.fromOffset(12, 120)
DropList.BackgroundColor3 = Color3.fromRGB(26, 29, 44)
DropList.BorderSizePixel = 0
DropList.ClipsDescendants = true
DropList.Visible = false
DropList.ZIndex = 10
DropList.Parent = Main
DropList.ScrollBarThickness = 4
DropList.ScrollBarImageColor3 = Color3.fromRGB(100, 110, 160)
DropList.CanvasSize = UDim2.new(0, 0, 0, 0)
DropList.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", DropList).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", DropList).Color = Color3.fromRGB(70, 75, 110)

local DropLayout = Instance.new("UIListLayout", DropList)
DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
DropLayout.Padding = UDim.new(0, 2)

-- Populate dropdown dari OBBY_FILES (bukan OBBY_LIST lagi)
local obbyNames = {}
for name in pairs(OBBY_FILES) do table.insert(obbyNames, name) end
table.sort(obbyNames)

for _, name in ipairs(obbyNames) do
    local item = Instance.new("TextButton")
    item.Size = UDim2.new(1, -8, 0, ITEM_H - 2)
    item.BackgroundColor3 = Color3.fromRGB(36, 40, 58)
    item.Text = "  " .. name
    item.TextColor3 = Color3.fromRGB(200, 210, 240)
    item.Font = Enum.Font.Gotham
    item.TextSize = 13
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.BorderSizePixel = 0
    item.Name = name
    item.ZIndex = 10
    item.Parent = DropList
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 6)
end

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.Position = UDim2.fromOffset(0, 62)
Divider.BackgroundColor3 = Color3.fromRGB(55, 60, 90)
Divider.BorderSizePixel = 0
Divider.Parent = Body

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, 0, 0, 40)
TimerLabel.Position = UDim2.fromOffset(0, 72)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Text = "⏱  —"
TimerLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
TimerLabel.Font = Enum.Font.GothamBold
TimerLabel.TextSize = 26
TimerLabel.Parent = Body

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.fromOffset(0, 114)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Pilih obby lalu tekan START"
StatusLabel.TextColor3 = Color3.fromRGB(160, 165, 195)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = Body

local BtnRow = Instance.new("Frame")
BtnRow.Size = UDim2.new(1, 0, 0, 38)
BtnRow.Position = UDim2.fromOffset(0, 142)
BtnRow.BackgroundTransparency = 1
BtnRow.Parent = Body

local BtnLayout = Instance.new("UIListLayout", BtnRow)
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BtnLayout.Padding = UDim.new(0, 8)

local function makeBtn(text, bgColor)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(78, 34)
    b.BackgroundColor3 = bgColor
    b.Text = text
    b.TextColor3 = Color3.fromRGB(240, 245, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = BtnRow
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
    return b
end

local BtnStart = makeBtn("▶ START", Color3.fromRGB(40, 140, 70))
local BtnPause = makeBtn("⏸ PAUSE", Color3.fromRGB(180, 130, 20))
local BtnStop  = makeBtn("■ STOP",  Color3.fromRGB(160, 40, 50))

local BtnRowLB = Instance.new("Frame")
BtnRowLB.Size = UDim2.new(1, 0, 0, 34)
BtnRowLB.Position = UDim2.fromOffset(0, 184)
BtnRowLB.BackgroundTransparency = 1
BtnRowLB.Parent = Body
local BtnLBLayout = Instance.new("UIListLayout", BtnRowLB)
BtnLBLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLBLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
BtnLBLayout.Padding = UDim.new(0, 8)
local BtnLeaderboard = makeBtn("🏆 Leaderboard", Color3.fromRGB(100, 60, 160))
BtnLeaderboard.Size = UDim2.fromOffset(200, 30)
BtnLeaderboard.Parent = BtnRowLB

-- =====================================================
-- MINI ICON
-- =====================================================
local MiniIcon = Instance.new("TextButton")
MiniIcon.Name = "MiniIcon"
MiniIcon.Size = UDim2.fromOffset(48, 48)
MiniIcon.Position = UDim2.fromOffset(20, 150)
MiniIcon.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
MiniIcon.Text = "WC"
MiniIcon.TextColor3 = Color3.fromRGB(180, 190, 255)
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.TextSize = 14
MiniIcon.BorderSizePixel = 0
MiniIcon.Visible = false
MiniIcon.Parent = ScreenGui
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(0, 14)
local miniStroke = Instance.new("UIStroke", MiniIcon)
miniStroke.Thickness = 1.5
miniStroke.Color = Color3.fromRGB(80, 85, 120)

-- =====================================================
-- DRAGGABLE
-- =====================================================
local function makeDraggable(frame)
    local dragging, dragStart, startPos = false, nil, nil
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(Main)
makeDraggable(MiniIcon)

-- =====================================================
-- DROPDOWN LOGIC
-- =====================================================
local dropOpen = false
local selectedObby = nil

local function closeDropdown()
    dropOpen = false
    TweenService:Create(DropList, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, 0)}):Play()
    task.delay(0.15, function() DropList.Visible = false end)
end

local function openDropdown()
    dropOpen = true
    local itemCount = #obbyNames
    local visibleCount = math.min(itemCount, MAX_VISIBLE)
    local listH = visibleCount * (ITEM_H + 2) + 4
    DropList.Visible = true
    TweenService:Create(DropList, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, listH)}):Play()
end

DropBtn.MouseButton1Click:Connect(function()
    if dropOpen then closeDropdown() else openDropdown() end
end)

for _, item in ipairs(DropList:GetChildren()) do
    if item:IsA("TextButton") then
        item.MouseButton1Click:Connect(function()
            selectedObby = item.Name
            DropBtn.Text = "  ✔  " .. item.Name
            DropBtn.TextColor3 = Color3.fromRGB(130, 220, 160)
            StatusLabel.Text = "Siap: " .. item.Name .. " — Tekan START"
            closeDropdown()
        end)
    end
end

-- =====================================================
-- MINIMIZE / CLOSE
-- =====================================================
BtnMin.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniIcon.Visible = true
end)

BtnClose.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MiniIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniIcon.Visible = false
end)

-- =====================================================
-- CORE LOGIC (generik, dipakai semua obby)
-- =====================================================
local running = false
local paused  = false
local warpDone = false
local timerThread = nil
local mainThread  = nil

local function resolvePath(pathArr)
    local node = workspace
    for _, name in ipairs(pathArr) do
        node = node:FindFirstChild(name)
        if not node then return nil end
    end
    return node
end

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function getPortalCFrame(portal)
    if portal:IsA("BasePart") then
        return portal.CFrame
    elseif portal:IsA("Model") then
        if portal.PrimaryPart then return portal.PrimaryPart.CFrame end
        local ok, piv = pcall(function() return portal:GetPivot() end)
        if ok and piv then return piv end
        for _, d in ipairs(portal:GetDescendants()) do
            if d:IsA("BasePart") then return d.CFrame end
        end
    end
    return nil
end

local function clickReplay()
    local PlayerGui = player:WaitForChild("PlayerGui")
    local maxWait = 30
    local elapsed = 0
    local obbyResults = nil

    StatusLabel.Text = "⏳ Menunggu Results..."

    while elapsed < maxWait do
        local ok, res = pcall(function()
            local ui = PlayerGui:FindFirstChild("PlayerUi")
            if not ui then error("no PlayerUi") end
            local popups = ui:FindFirstChild("Popups")
            if not popups then error("no Popups") end
            local results = popups:FindFirstChild("ObbyResults")
            if not results then error("no ObbyResults") end
            return results
        end)
        if ok and res then obbyResults = res break end
        task.wait(0.5)
        elapsed = elapsed + 0.5
    end

    if not obbyResults then
        StatusLabel.Text = "⚠ Results tidak muncul"
        return false
    end

    elapsed = 0
    while elapsed < maxWait do
        if obbyResults.Visible then break end
        task.wait(0.3)
        elapsed = elapsed + 0.3
    end

    if not obbyResults.Visible then
        StatusLabel.Text = "⚠ Results tidak visible"
        return false
    end

    StatusLabel.Text = "✅ Results muncul! Klik Replay..."
    task.wait(0.5)

    local replayBtn = obbyResults:FindFirstChild("ReplayButton")
    if not replayBtn then
        StatusLabel.Text = "⚠ ReplayButton tidak ditemukan"
        return false
    end

    task.wait(0.5)
    local btnPos = replayBtn.AbsolutePosition
    local btnSize = replayBtn.AbsoluteSize
    local centerX = btnPos.X + btnSize.X / 2
    local centerY = btnPos.Y + btnSize.Y / 2 + 60

    local VIM = game:GetService("VirtualInputManager")
    VIM:SendMouseMoveEvent(centerX, centerY, game)
    task.wait(0.1)
    VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.08)
    VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)

    StatusLabel.Text = "🔄 Replay diklik! Menunggu reset..."
    TimerLabel.Text = "⏱  —"
    return true
end

local function waitResetAndLoop(cfg, loopFunc)
    task.spawn(function()
        StatusLabel.Text = "⏳ Menunggu spawn (Y~" .. tostring(cfg.SPAWN_Y) .. ")..."

        local targetY = cfg and cfg.SPAWN_Y or 0
        local tolerance = 3
        local timeout = 60
        local elapsed = 0

        while elapsed < timeout and running do
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local currentY = hrp.Position.Y
                if math.abs(currentY - targetY) <= tolerance then
                    break
                end
            end
            task.wait(0.3)
            elapsed = elapsed + 0.3
        end

        if not running then return end

        StatusLabel.Text = "Spawn terdeteksi! Delay 2s..."
        task.wait(2)

        if not running then return end

        -- Fire proximity prompt(s) setelah spawn (data-driven, dulu khusus EastEnders)
        if cfg.SPAWN_PROXIMITY_PROMPTS then
            for _, promptPath in ipairs(cfg.SPAWN_PROXIMITY_PROMPTS) do
                StatusLabel.Text = "Fire " .. promptPath[#promptPath - 1] .. "..."
                pcall(function()
                    local node = workspace
                    for _, name in ipairs(promptPath) do
                        node = node:WaitForChild(name, 5)
                    end
                    if node and node:IsA("ProximityPrompt") then
                        fireproximityprompt(node)
                    end
                end)
                task.wait(1)
            end
        end

        if not running then return end

        StatusLabel.Text = "Mulai ulang..."
        loopFunc()
    end)
end

local function doPortalTeleport(cfg, loopFunc)
    warpDone = true
    TimerLabel.Text = "⏱  0s"
    StatusLabel.Text = "Teleport ke Portal..."
    local hrp = getHRP()
    local portalObj = resolvePath(cfg.PATH_PORTAL)
    local cf = portalObj and getPortalCFrame(portalObj) or nil
    if hrp and cf then
        hrp.CFrame = cf + Vector3.new(0, 5, 0)
    end

    task.spawn(function()
        local success = clickReplay()
        if success and running then
            waitResetAndLoop(cfg, loopFunc)
        end
    end)
end

local function waitUnpaused()
    while paused and running do task.wait(0.1) end
end

local function stopAll()
    running = false
    paused = false
    warpDone = true
    if timerThread then task.cancel(timerThread) timerThread = nil end
    if mainThread  then task.cancel(mainThread)  mainThread  = nil end
    TimerLabel.Text = "⏱  —"
    StatusLabel.Text = "Dihentikan."
    BtnStart.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
    BtnStart.Text = "▶ START"
end

-- Ambil BasePart representatif dari sebuah object (dipakai sweep mode)
local function getPartFromObj(obj)
    if obj:IsA("BasePart") then
        return obj
    elseif obj:IsA("Model") then
        if obj.PrimaryPart then return obj.PrimaryPart end
        local ok, piv = pcall(function() return obj:GetPivot() end)
        if ok and piv then
            for _, d in ipairs(obj:GetDescendants()) do
                if d:IsA("BasePart") then return d end
            end
        end
        return obj:FindFirstChildOfClass("BasePart")
    end
    return nil
end

local function resolveSweepFolder(cfg, folderName)
    local folder = nil
    if cfg.SWEEP_FOLDER_PATHS and cfg.SWEEP_FOLDER_PATHS[folderName] then
        local pathArr = cfg.SWEEP_FOLDER_PATHS[folderName]
        if #pathArr == 1 then
            folder = workspace:FindFirstChild(pathArr[1])
        else
            local node = workspace
            local ok2 = true
            for _, name in ipairs(pathArr) do
                node = node:FindFirstChild(name)
                if not node then ok2 = false break end
            end
            if ok2 and node then folder = node end
        end
    end
    if not folder then
        folder = workspace:FindFirstChild(folderName)
    end
    return folder
end

local function getCFrameFromObj(obj, fallbackPart)
    if obj:IsA("BasePart") then
        return obj.CFrame
    elseif obj:IsA("Model") then
        local ok2, piv = pcall(function() return obj:GetPivot() end)
        if ok2 and piv then
            return piv
        elseif obj.PrimaryPart then
            return obj.PrimaryPart.CFrame
        elseif fallbackPart then
            return fallbackPart.CFrame
        end
    end
    return nil
end

-- Jalankan mode sweep folder (Secret Garden, TNS, dll)
local function runSweepMode(cfg)
    if cfg.START_POS then
        local hrp = getHRP()
        hrp.CFrame = CFrame.new(cfg.START_POS + Vector3.new(0, 3, 0))
        StatusLabel.Text = "Start -> " .. (selectedObby or "?")
        task.wait(1)
    end

    local floatActive = cfg.FLOAT_ON_SWEEP == true

    local function stopFloat()
        floatActive = false
        pcall(function()
            local hrp2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp2 then
                local bv = hrp2:FindFirstChild("SG_Float")
                if bv then bv:Destroy() end
            end
        end)
    end

    task.spawn(function()
        while running and not warpDone and floatActive do
            local hrp2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp2 then
                local bv = hrp2:FindFirstChild("SG_Float")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "SG_Float"
                    bv.MaxForce = Vector3.new(0, 1e5, 0)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.Parent = hrp2
                end
                bv.Velocity = Vector3.new(0, 0.5, 0)
            end
            task.wait(0.05)
        end
        stopFloat()
    end)

    local sweepStopped = false

    if cfg.SWEEP_STOP_ITEM then
        task.spawn(function()
            while running and not warpDone and not sweepStopped do
                task.wait(0.2)
            end
            if not running or warpDone then return end
            floatActive = false
            stopFloat()
            StatusLabel.Text = cfg.SWEEP_STOP_ITEM .. " done! Float mati. Tunggu timer..."
            while running and not warpDone do task.wait(0.5) end
        end)
    end

    if cfg.INITIAL_TELEPORT then
        local hrp = getHRP()
        hrp.CFrame = CFrame.new(cfg.INITIAL_TELEPORT)
        StatusLabel.Text = "Start -> " .. (selectedObby or "?")
        task.wait(1)
    end

    if cfg.INITIAL_CHECKPOINT_PATH then
        local ok, cpObj = pcall(function()
            local node = workspace
            for _, name in ipairs(cfg.INITIAL_CHECKPOINT_PATH) do
                node = node:WaitForChild(name, 5)
            end
            return node
        end)
        if ok and cpObj then
            local hrp = getHRP()
            local cf = getCFrameFromObj(cpObj)
            if cf then
                hrp.CFrame = cf * CFrame.new(0, 2, 0)
                StatusLabel.Text = "Start -> Checkpoint"
                task.wait(1)
            end
        end
    end

    local visitedStickers = {}

    while running and not warpDone and not sweepStopped do
        waitUnpaused()
        if not running or warpDone then break end

        local hrp = getHRP()

        -- Kumpulkan semua item dari semua folder sweep
        local allItems = {}
        local seen = {}
        for _, folderName in ipairs(cfg.SWEEP_FOLDERS) do
            local folder = resolveSweepFolder(cfg, folderName)
            if folder then
                for _, child in ipairs(folder:GetChildren()) do
                    if not seen[child] then
                        seen[child] = true
                        local part = getPartFromObj(child)
                        if part then
                            table.insert(allItems, {obj = child, part = part, folder = folderName})
                        end
                    end
                end
            end
        end

        -- Filter: "Pickups" boleh dikunjungi berkali-kali, folder lain cuma 1x
        local items = {}
        for _, it in ipairs(allItems) do
            if it.folder == "Pickups" then
                table.insert(items, it)
            elseif not visitedStickers[it.obj] then
                table.insert(items, it)
            end
        end

        if #items == 0 then
            StatusLabel.Text = "Semua item selesai!"
            task.wait(1)
            break
        end

        table.sort(items, function(a, b)
            local da = (a.part.Position - hrp.Position).Magnitude
            local db = (b.part.Position - hrp.Position).Magnitude
            return da < db
        end)

        local countP, countS = 0, 0
        for _, it in ipairs(items) do
            if it.folder == "Pickups" then countP += 1 else countS += 1 end
        end
        StatusLabel.Text = ("P:%d S:%d | Total:%d"):format(countP, countS, #items)

        local target = items[1]
        if target and target.obj and target.obj.Parent then
            local cf = getCFrameFromObj(target.obj, target.part)
            if cf then
                hrp = getHRP()
                hrp.CFrame = cf * CFrame.new(0, 2, 0)
                StatusLabel.Text = ("-> %s [%s]"):format(target.obj.Name, target.folder)
            end

            if target.folder ~= "Pickups" then
                visitedStickers[target.obj] = true

                if cfg.FLOAT_STOP_ITEM and target.obj.Name == cfg.FLOAT_STOP_ITEM then
                    floatActive = false
                    stopFloat()
                    StatusLabel.Text = cfg.FLOAT_STOP_ITEM .. " reached! Float mati."
                end

                if cfg.SWEEP_STOP_ITEM and target.obj.Name == cfg.SWEEP_STOP_ITEM then
                    sweepStopped = true
                    StatusLabel.Text = cfg.SWEEP_STOP_ITEM .. " reached! Sweep selesai."
                    task.wait(1)
                    break
                end
            end
        end

        task.wait(1)
    end

    if not warpDone and running then
        local hrp = getHRP()
        local gstObj = resolvePath(cfg.PATH_GAME_STOP)
        if gstObj then hrp.CFrame = gstObj.CFrame + Vector3.new(0, 5, 0) end
        StatusLabel.Text = "GameStop OK - Menunggu timer..."
        while running and not warpDone do task.wait(0.5) end
    end
end

-- Jalankan mode waypoint biasa
local function runWaypointMode(cfg)
    local hrp
    for i, entry in ipairs(cfg.waypoints) do
        if not running or warpDone then break end
        waitUnpaused()
        if not running or warpDone then break end

        local pos, customDelay, isWalk, hasFloat
        if typeof(entry) == "Vector3" then
            pos = entry
            customDelay = 1
            isWalk = false
            hasFloat = false
        else
            pos = entry.pos
            customDelay = entry.delay or 1
            isWalk = entry.walk or false
            hasFloat = entry.float or false
        end

        hrp = getHRP()
        StatusLabel.Text = ("Waypoint %d/%d"):format(i, #cfg.waypoints)

        if isWalk then
            local char = hrp.Parent
            local Humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if Humanoid and hrp then
                local target = Vector3.new(pos.X, hrp.Position.Y, pos.Z)
                local speed = Humanoid.WalkSpeed > 0 and Humanoid.WalkSpeed or 16
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e5, 0, 1e5)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = hrp
                local maxTime = 15
                local elapsed = 0
                while elapsed < maxTime do
                    if not running or warpDone then break end
                    local current = hrp.Position
                    local diff = Vector3.new(target.X - current.X, 0, target.Z - current.Z)
                    if diff.Magnitude < 2 then break end
                    local dir = diff.Unit
                    bv.Velocity = dir * speed
                    hrp.CFrame = CFrame.lookAt(hrp.CFrame.Position, hrp.CFrame.Position + dir)
                    task.wait(0.05)
                    elapsed = elapsed + 0.05
                end
                bv.Velocity = Vector3.new(0, 0, 0)
                bv:Destroy()
            end
        else
            local floatBV = nil
            if hasFloat then
                floatBV = Instance.new("BodyVelocity")
                floatBV.Name = "WP_Float"
                floatBV.MaxForce = Vector3.new(0, 1e5, 0)
                floatBV.Velocity = Vector3.new(0, 0.5, 0)
                floatBV.Parent = hrp
            end

            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            task.wait(customDelay)

            if floatBV then
                floatBV:Destroy()
            end
            continue
        end

        task.wait(customDelay)
    end

    if warpDone or not running then return end

    local hrp2 = getHRP()
    local gstObj2 = resolvePath(cfg.PATH_GAME_STOP)
    if gstObj2 then hrp2.CFrame = gstObj2.CFrame + Vector3.new(0, 5, 0) end
    StatusLabel.Text = "GameStop OK - Menunggu timer..."

    while running and not warpDone do
        task.wait(0.5)
    end
end

-- START
BtnStart.MouseButton1Click:Connect(function()
    if running then return end
    if not selectedObby then
        StatusLabel.Text = "⚠ Pilih obby dulu!"
        return
    end

    BtnStart.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BtnStart.Text = "Loading..."
    StatusLabel.Text = "⏳ Mengambil script " .. selectedObby .. "..."

    local cfg, err = loadObbyConfig(selectedObby)
    if not cfg then
        StatusLabel.Text = "⚠ " .. tostring(err)
        BtnStart.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
        BtnStart.Text = "▶ START"
        return
    end

    running = true
    paused  = false
    warpDone = false

    BtnStart.Text = "Running..."

    local function runOneLap()
        if not running then return end
        warpDone = false

        if timerThread then task.cancel(timerThread) timerThread = nil end
        if mainThread  then task.cancel(mainThread)  mainThread  = nil end

        -- Random waktu per lap (data-driven lewat cfg.RANDOM_TIME)
        if cfg.RANDOM_TIME then
            cfg.TOTAL_TIME = math.random(cfg.RANDOM_TIME[1], cfg.RANDOM_TIME[2])
        end

        local startTime = os.clock()

        timerThread = task.spawn(function()
            while running and not warpDone do
                waitUnpaused()
                if not running then break end
                local elapsed = os.clock() - startTime
                local remain = math.max(0, cfg.TOTAL_TIME - elapsed)
                TimerLabel.Text = ("⏱  %ds"):format(math.ceil(remain))
                if remain <= 0 then
                    if not warpDone then doPortalTeleport(cfg, runOneLap) end
                    break
                end
                task.wait(0.5)
            end
        end)

        mainThread = task.spawn(function()
            pcall(function()
                local chatDev = workspace:FindFirstChild("ChatDev")
                if chatDev then chatDev:Destroy() end
            end)

            local hrp = getHRP()
            local gsObj = resolvePath(cfg.PATH_GAME_START)
            if gsObj then hrp.CFrame = gsObj.CFrame + Vector3.new(0, 5, 0) end
            StatusLabel.Text = "GameStart OK"
            task.wait(1)

            if cfg.SWEEP_MODE then
                runSweepMode(cfg)
            else
                runWaypointMode(cfg)
            end
        end)
    end

    runOneLap()
end)

-- PAUSE / RESUME
BtnPause.MouseButton1Click:Connect(function()
    if not running then return end
    paused = not paused
    if paused then
        BtnPause.Text = "▶ RESUME"
        BtnPause.BackgroundColor3 = Color3.fromRGB(40, 140, 70)
        StatusLabel.Text = "⏸ Dijeda..."
    else
        BtnPause.Text = "⏸ PAUSE"
        BtnPause.BackgroundColor3 = Color3.fromRGB(180, 130, 20)
        StatusLabel.Text = "Dilanjutkan..."
    end
end)

-- STOP
BtnStop.MouseButton1Click:Connect(function()
    stopAll()
end)

-- LEADERBOARD
BtnLeaderboard.MouseButton1Click:Connect(function()
    if not selectedObby then
        StatusLabel.Text = "⚠ Pilih obby dulu!"
        return
    end

    local cfg = obbyConfigCache[selectedObby]
    if not cfg then
        local loadedCfg, err = loadObbyConfig(selectedObby)
        if not loadedCfg then
            StatusLabel.Text = "⚠ " .. tostring(err)
            return
        end
        cfg = loadedCfg
    end

    if not cfg.LEADERBOARD then
        StatusLabel.Text = "⚠ Obby ini tidak punya leaderboard"
        return
    end

    local lb = cfg.LEADERBOARD

    if lb.type == "ProximityPrompt" then
        local ok, target = pcall(function()
            local node = workspace
            for _, name in ipairs(lb.path) do
                node = node:WaitForChild(name, 5)
                if not node then error("path not found: " .. name) end
            end
            return node
        end)

        if not ok or not target then
            StatusLabel.Text = "! Leaderboard tidak ditemukan"
            return
        end

        if target:IsA("ProximityPrompt") then
            pcall(function() fireproximityprompt(target) end)
            pcall(function() target.Triggered:Fire(player) end)
            StatusLabel.Text = "Leaderboard dibuka!"
        else
            StatusLabel.Text = "! Target bukan ProximityPrompt: " .. target.ClassName
        end
    end
end)
