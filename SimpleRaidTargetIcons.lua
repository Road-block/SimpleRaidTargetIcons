-- Simple Raid Target Icons
--
--------------------------------
--                            --
-- Concept originally by Qzot --
--                            --
--------------------------------

local srti = {}
srti.version = GetAddOnMetadata("simpleraidtargeticons","version")

SRTI_TITLE = "SimpleRaidTargetIcons"
SRTI_HEADER = SRTI_TITLE .. " " .. srti.version

SRTI_MSG_OUT_OF_RANGE = SRTI_TITLE .. " - %1Party leader is out of range of target."
SRTI_MSG_PROMOTED = SRTI_TITLE .. " - %1Promoted"
SRTI_MSG_NOT_PROMOTED = SRTI_TITLE .. " - %1Not Promoted"
SRTI_MSG_DEMOTED = SRTI_TITLE .. " - %1Demoted"

SRTI_MSG_HELP_TEXT = SRTI_HEADER .. " - %0/srti\n no command opens the options menu\n commands to set icon on target"

SRTI_UNIT_SRTI = "SRTI"
SRTI_UNIT_ASSISTANTS = "SRTI Assistants"
SRTI_UNIT_ASSISTANT = "SRTI Assistant"
SRTI_UNIT_ASSISTANT_PROMOTE = "Promote SRTI Assistant"
SRTI_UNIT_ASSISTANT_PROMOTE_TEXT = "Promotes party member to SRTI assistant."
SRTI_UNIT_ASSISTANT_DEMOTE = "Demote SRTI Assistant"
SRTI_UNIT_ASSISTANT_DEMOTE_TEXT = "Demotes party member from SRTI assistant."
SRTI_UNIT_ASSISTANT_NOT_PROMOTED = "SRTI Not Promoted"
SRTI_UNIT_ASSISTANT_DISABLED = "SRTI Disabled"

SRTI_OPTIONS_HEADER = "Radial Menu Options"
SRTI_OPTIONS_SINGLE_HEADER = "Left Click"
SRTI_OPTIONS_SINGLE_MODIFIERS = "Modifiers"
SRTI_OPTIONS_SINGLE_CTRL = "Ctrl"
SRTI_OPTIONS_SINGLE_ALT = "Alt"
SRTI_OPTIONS_SINGLE_SHIFT = "Shift"
SRTI_OPTIONS_DOUBLE_HEADER = "Double Left Click"
SRTI_OPTIONS_DOUBLE_ENABLE = "Enable"
SRTI_OPTIONS_DOUBLE_SPEED = "Double Click Speed - %s sec"
SRTI_OPTIONS_DOUBLE_SPEED_MIN = "Quick"
SRTI_OPTIONS_DOUBLE_SPEED_MAX = "Slow"
SRTI_OPTIONS_BINDING_HEADER = "Key Bindings"
SRTI_OPTIONS_HOVER = "Select Icon on Hover"
SRTI_OPTIONS_HOVER_TIME = "Hover Wait Time - %s sec"
SRTI_OPTIONS_HOVER_TIME_MIN = "Quick"
SRTI_OPTIONS_HOVER_TIME_MAX = "Slow"
SRTI_OPTIONS_TEST = "Test Me"
SRTI_OPTIONS_TEST_HELP = "Click above to test settings"

SRTI_BINDINGS_BIND_HELP = "|cffffffffPress a key to bind |r%s"
SRTI_BINDINGS_BIND_WARN_KEY = "|cffff0000%s Function will be Unbound from this Key!"
SRTI_BINDINGS_BIND_WARN_UNBOUND = "|cffff0000%s Function will be Unbound!"
SRTI_BINDINGS_UNBIND_HELP = "|cffff0000You are about to unbind key from |r%s"
SRTI_BINDINGS_ESC = "Press |cffffffffEsc|r to cancel"

BINDING_HEADER_SRTI_TITLE = SRTI_TITLE
BINDING_NAME_SRTI_SHOW = "Show Radial Menu"
BINDING_NAME_SRTI_MOUSEOVER = "Mouseover Mark CC"
BINDING_NAME_SRTI_MOUSEOVER_CLEAR = "Mouseover Clear Marks"
BINDING_NAME_SRTI_MARKORDER = "CC TargetBar"
BINDING_NAME_SRTI_STAR = "Yellow Star Icon"
BINDING_NAME_SRTI_CIRCLE = "Orange Circle Icon"
BINDING_NAME_SRTI_DIAMOND = "Purple Diamond Icon"
BINDING_NAME_SRTI_TRIANGLE = "Green Triangle Icon"
BINDING_NAME_SRTI_MOON = "Silver Moon Icon"
BINDING_NAME_SRTI_SQUARE = "Blue Square Icon"
BINDING_NAME_SRTI_CROSS = "Red Cross Icon"
BINDING_NAME_SRTI_SKULL = "White Skull Icon"
BINDING_NAME_SRTI_TARSTAR = "Target Star"
BINDING_NAME_SRTI_TARCIRCLE = "Target Circle"
BINDING_NAME_SRTI_TARDIAMOND = "Target Diamond"
BINDING_NAME_SRTI_TARTRIANGLE = "Target Triangle"
BINDING_NAME_SRTI_TARMOON = "Target Moon"
BINDING_NAME_SRTI_TARSQUARE = "Target Square"
BINDING_NAME_SRTI_TARCROSS = "Target Cross"
BINDING_NAME_SRTI_TARSKULL = "Target Skull"
BINDING_NAME_SRTI_CLEAR = "Remove Icon"

local iconStrings = {
	none = 0,
	clear = 0,
	remove = 0,
	yellow = 1,
	star = 1,
	orange = 2,
	circle = 2,
	purple = 3,
	diamond = 3,
	green = 4,
	triangle = 4,
	silver = 5,
	moon = 5,
	blue = 6,
	square = 6,
	red = 7,
	x = 7,
	cross = 7,
	white = 8,
	skull = 8,
}

local iconNames = {
	"remove icon",
	"yellow star",
	"orange circle",
	"purple diamond",
	"green triangle",
	"silver moon",
	"blue square",
	"red cross",
	"white skull",
}

local marksCol = {
	{1},{1,2},{1,2,3},{1,2,3,4},
	{1,2,3,4,5},{1,2,3,4,5,6},{1,2,3,4,5,6,7},
	{1,2,3,4,5,6,7,8},
	{8},{8,7},{8,7,6},{8,7,6,5},
	{8,7,6,5,4},{8,7,6,5,4,3},{8,7,6,5,4,3,2},
	{8,7,6,5,4,3,2,1}
}

local party, raid = {}, {}
local playerName = (UnitName("player"))
local CC_ClassCount = {}
local ClickFrames,ClickFramesNames = {
	["WorldFrame"] = {["Script"]="OnMouseUp",["OnMouseUp"]=false},
	-- pfUI
	["pfTarget"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
	["pfTargetTarget"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
	["pfPlayer"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
	-- Luna
	["LUFUnitplayer"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
	["LUFUnittarget"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
	["LUFUnittargettarget"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false},
},{}
do
	for i=1,MAX_PARTY_MEMBERS do
		party[i] = {}
		party[i].unit = "party"..i
		party[i].target = "party"..i.."target"
		-- pfUI clickframes
		ClickFrames["pfGroup"..i] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
		ClickFrames["pfParty"..i.."Target"] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
		-- Luna
		ClickFrames["LUFUnitparty"..i] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
		ClickFrames["LUFUnitpartytarget"..i] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
	end
	for i=1,MAX_RAID_MEMBERS do
		raid[i] = {}
		raid[i].unit = "raid"..i
		raid[i].target = "raid"..i.."target"
		-- pfUI clickframes
		ClickFrames["pfRaid"..i] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
	end
	-- Luna
	for i=1,NUM_RAID_GROUPS do
		for k=1,MEMBERS_PER_RAID_GROUP do
			ClickFrames["LUFUnitraid"..i.."member"..k] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
		end
	end
end

UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo or loadstring("local t = {} return function() for k in pairs(t) do t[k] = nil end return t end")()

function srti.Print(msg)
	for text in string.gmatch(msg, "[^\n]+") do
		text = string.gsub(text,"%%1","|cffffcc00")
		text = string.gsub(text,"%%0(%S+)","|cff9999ff%1|r")
		DEFAULT_CHAT_FRAME:AddMessage(text,0.7,0.7,0.7)
	end
end

local function print(msg)
	srti.Print(msg)
end

local function camelCase(word)
  return string.gsub(word,"(%a)([%w_']*)",function(head,tail) 
    return string.format("%s%s",string.upper(head),string.lower(tail)) 
    end)
end

function srti.PrintHelp()
	print(SRTI_MSG_HELP_TEXT)
	for i=0, 8 do
		local text = ""
		for string, index in pairs(iconStrings) do
			if ( index == i ) then
				text = text.." / %0"..string
			end
		end

		print("  %0"..i..text.." - %1"..iconNames[i+1])
	end
end

srti.defaults = {
	["ctrl"] = true,
	["alt"] = false,
	["shift"] = false,
	["singlehover"] = false,

	["double"] = true,
	["speed"] = 0.25,
	["doublehover"] = false,

	["bindinghover"] = false,

	["hovertime"] = 0.2,
}
srti.cursor = "Interface\\AddOns\\SimpleRaidTargetIcons\\Cursor\\%03d.blp"
-- srti.promoted
-- promotion / srti status

-- srti.assistants
-- list of promoted people

-- srti.frame
-- the main menu frame and event catcher

srti.frame = CreateFrame("button", "SRTIRadialMenu", UIParent)

srti.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
srti.frame:RegisterEvent("VARIABLES_LOADED")
srti.frame:RegisterEvent("ADDON_LOADED")
srti.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
srti.frame:RegisterEvent("CHAT_MSG_ADDON")
srti.frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
srti.frame:RegisterEvent("RAID_ROSTER_UPDATE")
srti.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

srti.frame:SetFrameStrata("DIALOG")
srti.frame:SetClampedToScreen(true)

srti.frame:SetWidth(100)
srti.frame:SetHeight(100)
srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", 0, 0 )

srti.frame:Hide()
srti.frame.origShow = srti.frame.Show

srti.barFrame = CreateFrame("frame", "SRTIBarFrame", UIParent)
srti.barFrame:SetWidth(182)
srti.barFrame:SetHeight(30)
srti.barFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
srti.barFrame:SetBackdropBorderColor(0, 0, 0)
srti.barFrame:SetBackdropColor(0.15, 0.15, 0.15)
srti.barFrame:SetClampedToScreen(true)
for i=8,1,-1 do
	local btnName = "SRTIBarFrameBtn"..i
	local btn = CreateFrame("CheckButton", btnName, srti.barFrame, "ActionButtonTemplate")
	btn:SetID(i)
	--btn:RegisterForClicks()
	btn.tex = getglobal(btnName.."Icon")
	btn.border = getglobal(btnName.."Border")
	btn.name = getglobal(btnName.."Name")
	local fontpath--[[,fontheight,fontflags]] = btn.name:GetFont()
	btn.name:SetFont(fontpath,12,"THICKOUTLINE")
	btn.tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	SetRaidTargetIconTexture(btn.tex,i)
	btn.border:SetTexture("")
	btn:SetNormalTexture("")
	btn:SetCheckedTexture("")
	--btn:SetHighlightTexture("")
	btn.name:SetText(i)
	btn:SetScript("OnMouseDown", function()
			srti.barFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
			local mark = this:GetID()
			srti.TargetScan(mark)
			SRTI.ShowCursorCompanion(mark)
		end)
	btn:SetScript("OnMouseUp", function()
			srti.barFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
			srti.scanTarget = nil
			SRTI.ShowCursorCompanion()
		end)
	btn:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText("Simple Raid Target Icons")
			local markName = getglobal("RAID_TARGET_"..this:GetID())
			GameTooltip:AddDoubleLine(string.format("Click to target %s",markName),"Group Target Scan",0,1,0,0.5,0.5,0.5)
			GameTooltip:AddDoubleLine("Click and drag over units.",string.format("Targets %s",markName),0,1,0,0.5,0.5,0.5)
			GameTooltip:Show()
		end)
	btn:SetScript("OnLeave", function()
			if GameTooltip:IsOwned(this) then
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
		end)
	btn:SetScript("OnHide", function()
			if GameTooltip:IsOwned(this) then
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
		end)
	btn:SetWidth(20)
	btn:SetHeight(20)
	srti.barFrame[i] = btn
	if i == 8 then
		btn:SetPoint("LEFT",4,0)
	else
		btn:SetPoint("LEFT",srti.barFrame[(i+1)],"RIGHT",2,0)
	end
end
srti.barFrame:SetScript("OnEvent",function()
	if event == "UPDATE_MOUSEOVER_UNIT" and srti.scanTarget ~= nil then
		if UnitExists("mouseover") then
			local mark = GetRaidTargetIndex("mouseover")
			if mark and (mark == srti.scanTarget) then
				srti.Target("mouseover")
			end
		end
	end
end)
srti.barFrame:SetScript("OnHide", function()
	srti.scanTarget = nil
	srti.barFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end)
srti.barFrame:Hide()

function srti.frame:Show()
	srti.frame.p = srti.frame:CreateTexture("SRTIRadialMenuPortrait","BORDER")
	srti.frame.p:SetWidth(40)
	srti.frame.p:SetHeight(40)
	srti.frame.p:SetPoint("CENTER", srti.frame, "CENTER", 0, 0 )
	srti.frame.b = srti.frame:CreateTexture("SRTIRadialMenuBorder", "BACKGROUND")
	srti.frame.b:SetTexture("Interface\\Minimap\\UI-TOD-Indicator")
	srti.frame.b:SetWidth(80)
	srti.frame.b:SetHeight(80)
	srti.frame.b:SetTexCoord(0.5,1,0,1)
	srti.frame.b:SetPoint("CENTER", srti.frame, "CENTER", 10, -10 )
	for i=1, 8 do
		srti.frame[i] = srti.frame:CreateTexture("SRTIRadialMenu"..i,"OVERLAY")
	end

	srti.frame:origShow()
	srti.frame.Show = srti.frame.origShow
	srti.frame.origShow = nil

	srti.frame:SetScript("OnUpdate", function()
			local portrait = srti.frame.portrait
			srti.frame.portrait = nil
			local saved, index = this.i, GetRaidTargetIndex("target")
			if ( this.test ) then
				index = srti.menu.test.index or 0
			end
			local curtime = GetTime()
			if ( not this.h ) then
				if ( this.test ) then
					SetPortraitTexture( srti.frame.p, "player" )
				elseif ( not UnitExists("target") or ( not UnitPlayerOrPetInRaid("target") and UnitIsDeadOrGhost("target") ) ) then
					if ( portrait ) then
						this:Hide()
						return
					else
						this.h = curtime
					end
				elseif ( portrait ) then
					if ( portrait == 0 and not UnitIsUnit("target","mouseover") ) then
						this:Hide()
						return
					end
					PlaySound("igMainMenuOptionCheckBoxOn")
					SetPortraitTexture( srti.frame.p, "target" )
				end

				local x, y = GetCursorPosition()
				local s = srti.frame:GetEffectiveScale()
				local mx, my = srti.frame:GetCenter()
				x = x / s
				y = y / s

				local a, b = y - my, x - mx

				local dist = floor(math.sqrt( a*a + b*b ))

				this.i = nil

				if ( dist > 60 ) then
					if ( dist > 200 ) then
						this.l = nil
						this.h = curtime
						this.s = nil
						PlaySound("igMainMenuOptionCheckBoxOff")
					elseif ( not this.l ) then
						this.l = curtime
					end
				else
					this.l = nil

					if ( dist > 20 and dist < 50 ) then
						local pos = math.deg(math.atan2( a, b )) + 27.5
						this.i = mod(11-ceil(pos/45),8)+1
					end
				end

				for i=1, 8 do
					local t = this[i]
					if ( index == i ) then
						t:SetTexCoord(0,1,0,1)
						t:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
					else
						t:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
						SetRaidTargetIconTexture(t,i)
					end
				end

				if ( this.c ) then
					if ( this.i and ( not saved or saved == this.i ) ) then
						this.c = this.c + arg1
						if ( this.c > ( SRTISaved.hovertime or 0.2 ) ) then
							this:Click()
						end
					else
						this.c = 0
					end
				end
			end

			if ( this.s ) then
				local status = curtime - this.s
				if ( status > 0.1 ) then
					srti.frame.p:SetAlpha(1)
					srti.frame.b:SetAlpha(1)
					for i=1, 8 do
						local t, radians = this[i], (0.375 - i/8) * 360
						t:SetPoint("CENTER", this, "CENTER", 36*cos(radians), 36*sin(radians) )
						t:SetAlpha(0.5)
						t:SetWidth(18)
						t:SetHeight(18)
					end
					this.s = nil
				else
					status = status / 0.1
					srti.frame.p:SetAlpha(status)
					srti.frame.b:SetAlpha(status)
					for i=1, 8 do
						local t, radians = this[i], (0.375 - i/8) * 360
						t:SetPoint("CENTER", this, "CENTER", (20*status + 16)*cos(radians), (20*status + 16)*sin(radians) )
						if ( i == index ) then
							t:SetAlpha(status)
						else
							t:SetAlpha(0.5*status)
						end
						t:SetWidth(9*status + 9)
						t:SetHeight(9*status + 9)
					end
				end
			elseif ( this.h ) then
				local status = curtime - this.h
				if ( status > 0.1 ) then
					this.h = nil
					this:Hide()
				else
					status = 1 - status / 0.1
					srti.frame.p:SetAlpha(status)
					srti.frame.b:SetAlpha(status)
					for i=1, 8 do
						local t, radians = this[i], (0.375 - i/8) * 360
						if ( this.i == i ) then
							t:SetWidth(36-18*status)
							t:SetHeight(36-18*status)
							t:SetAlpha(min(4*status,1))
						else
							t:SetPoint("CENTER", this, "CENTER", (20*status + 16)*cos(radians), (20*status + 16)*sin(radians) )
							t:SetAlpha(0.75*status)
							t:SetWidth(18*status)
							t:SetHeight(18*status)
						end
					end
				end
			else
				for i=1, 8 do
					local t = this[i]
					if ( i == index ) then
						t:SetAlpha(1)
					else
						t:SetAlpha(0.75)
					end
					t:SetWidth(18)
					t:SetHeight(18)
				end
			end

			if ( this.i ) then
				local t = this[this.i]
				local a, w = t:GetAlpha(), t:GetWidth()

				if ( not this.t or saved ~= this.i ) then
					this.t = curtime
				end
				local s = 1 + min( (curtime - this.t)/0.05, 1 )

				t:SetAlpha(min(a+0.125*s,1))
				t:SetWidth(w*s)
				t:SetHeight(w*s)
			end

			if ( this.l ) then
				local status = curtime - this.l
				if ( status > 0.75 ) then
					this.h = curtime
					this.l = nil
					this.s = nil
					this.i = nil
					PlaySound("igMainMenuOptionCheckBoxOff")
				end
			end
		end
		)

	srti.frame:SetScript("OnClick", function()
			if ( not this.h ) then
				local index = GetRaidTargetIndex("target")
				if ( this.test ) then
					index = srti.menu.test.index
				end
				if ( ( arg1 == "RightButton" and index and index > 0 ) or ( this.i and this.i == index ) ) then
					this.i = index
					PlaySound("igMiniMapZoomOut")
					srti.SetRaidTarget(0)
				elseif ( this.i ) then
					PlaySound("igMiniMapZoomIn")
					srti.SetRaidTarget(this.i)
				else
					PlaySound("igMainMenuOptionCheckBoxOff")
				end
				this.s = nil
				this.h = GetTime()
			end
		end
		)
end

function srti.UpdateSaved()
	if ( not SRTISaved ) then
		SRTISaved = {}
	end
	for k, v in pairs(srti.defaults) do
		if ( SRTISaved[k] == nil ) then
			SRTISaved[k] = v
		end
	end
	SRTISaved.assistants = SRTISaved.assistants or {}

	srti.saved = SRTISaved
end

srti.frame:SetScript("OnEvent", function()
	if ( event == "CHAT_MSG_ADDON" ) then
		if (arg1 ~= "SRTI") then return end -- not from this addon
		if (arg4 == playerName) then return end -- our message
		if ( IsPartyLeader() ) then
			if ( arg2 == "REQUEST" ) then
				srti.UpdateAssistants()
			elseif ( SRTISaved.assistants[arg4] ) then
				local _,name,unit,target,index
				local _,_,index = string.find(arg2,"^ICON (%d+)$")
				index = tonumber(index)
				if ( index ) then
					target = 1
					name = arg4
				else
					_, _, name, index = string.find(arg2,"^PARTY (%S+) (%d)$")
					index = tonumber(index)
				end
				if ( name ) then
					if ( name == playerName ) then
						unit = "player"
					else
						for i=1, GetNumPartyMembers() do
							if ( name == UnitName(party[i].unit) ) then
								unit = party[i].unit
								break
							end
						end
					end
				end
				if ( unit and index ) then
					if ( target ) then
						if ( UnitExists(unit.."target") ) then
							SetRaidTarget( unit.."target", index )
						else
							SendAddonMessage("SRTI","FAILED "..arg4,"PARTY")
						end
					else
						SetRaidTarget( unit, index )
					end
				end
			end
		else
			local promote = string.find(arg2,"PROMOTE "..playerName)
			local demote  = string.find(arg2,"DEMOTE "..playerName)
			local failed  = string.find(arg2,"FAILED "..playerName)
			if ( promote ) then
				if ( srti.lastpromoted ~= 1 ) then
					print(SRTI_MSG_PROMOTED)
				end
				srti.promoted = 1
			elseif ( demote ) then
				if ( srti.lastpromoted == 1 ) then
					print(SRTI_MSG_DEMOTED)
				elseif ( srti.lastpromoted == nil ) then
					print(SRTI_MSG_NOT_PROMOTED)
				end
				srti.promoted = 0
			elseif ( failed ) then
				print(SRTI_MSG_OUT_OF_RANGE)
			end
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if ( GetNumPartyMembers() > 0 and GetNumRaidMembers() == 0 and not IsPartyLeader() ) then
			SendAddonMessage("SRTI","REQUEST","PARTY")
		end
		srti.UpdateClassCount()
		if IsAddOnLoaded("LunaUnitFrames") then
			srti.UpdateClickHandlers()
		end
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		srti.lastpromoted = srti.promoted or srti.lastpromoted
		srti.promoted = nil
		if ( GetNumPartyMembers() > 0 and GetNumRaidMembers() == 0 and not IsPartyLeader() ) then
			SendAddonMessage("SRTI","REQUEST","PARTY")
		else
			srti.lastpromoted = nil
		end
		srti.UpdateClassCount()
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		srti.UpdateClassCount()
	elseif (event == "ADDON_LOADED" ) then
		if arg1 == "Blizzard_RaidUI" or arg1 == "oRA2" then
			srti.SetupFrameRegistration()
		end
		if arg1 == "pfUI" or arg1 == "LunaUnitFrames" then
			srti.UpdateClickHandlers()
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		this:UnregisterEvent("VARIABLES_LOADED")
		srti.UpdateSaved()
		srti.SetupFrameRegistration()
		srti.UpdateClickHandlers()
	elseif ( event == "UPDATE_MOUSEOVER_UNIT" ) then
		srti.MassMark()
	else
		if ( this:IsVisible() and not this.e and not this.h ) then
			this.i = nil
			this.s = nil
			this.h = GetTime()
			PlaySound("igMainMenuOptionCheckBoxOff")
			this.e = nil
		elseif ( this.e ) then
			this.e = nil
		end
	end
end
)

function srti.ShowFromBinding()
	if ( not srti.frame:IsVisible() ) then
		local c = nil
		if ( SRTISaved.bindinghover ) then
			c = 0
		end
		if ( srti.menu and srti.menu:IsVisible() ) then
			srti.menu.test.ShowRadial(c)
		else
			srti.frame.c = c
			srti.Show(1)
		end
	end
end

function srti.Show(frombinding)
	if ( SRTISaved.debug == nil and not IsPartyLeader() and srti.promoted ~= 1 ) then
		local num = GetNumRaidMembers()
		if ( num == 0 ) then
			return
		end

		local _, rank = GetRaidRosterInfo(num)
		if ( rank == 0 ) then return end
	end

	srti.frame.s = GetTime()
	srti.frame.h = nil
	srti.frame.i = nil
	srti.frame.l = nil
	srti.frame.test = nil
	if ( UnitExists("target") and (frombinding or UnitIsUnit("target","mouseover")) ) then
		srti.frame.e = nil
	else
		srti.frame.e = 1
	end
	srti.frame.portrait = frombinding or 0

	local x,y = GetCursorPosition()
	local s = srti.frame:GetEffectiveScale()
	srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x/s, y/s )
	srti.frame:Show()
end

function srti.AreModifiersDown()
	if ( not SRTISaved.ctrl and not SRTISaved.alt and not SRTISaved.shift ) then
		return
	elseif ( SRTISaved.ctrl ~= (IsControlKeyDown() == 1) ) then
		return
	elseif ( SRTISaved.alt ~= (IsAltKeyDown() == 1) ) then
		return
	elseif ( SRTISaved.shift ~= (IsShiftKeyDown() == 1) ) then
		return
	end
	return 1
end

function srti.SetRaidTarget(index,unit)
	index = index or 0
	if ( srti.frame.test ) then
		if ( index == 0 ) then
			srti.menu.test.icon:Hide()
			srti.menu.test.index = nil
		else
			srti.menu.test.icon:Show()
			srti.menu.test.index = index
			SetRaidTargetIconTexture(srti.menu.test.icon,index)
		end
		return
	elseif ( not IsPartyLeader() ) then
		local num = GetNumRaidMembers()
		if ( num == 0 ) then
			if ( unit ) then
				local unitName = UnitName(unit)
				if ( unitName ) then
					SendAddonMessage("SRTI","PARTY "..unitName.." "..index,"PARTY")
				end
			else
				SendAddonMessage("SRTI","ICON "..index,"PARTY")
			end
			return
		end

		local _, rank = GetRaidRosterInfo(num)
		if ( rank == 0 ) then return end
	end
	SetRaidTarget("target", index)
end

function srti.UpdateAssistants()
	for i=1, GetNumPartyMembers() do
		local text = ""
		if ( SRTISaved.assistants[(UnitName(party[i].unit))] ) then
			text = text .. " PROMOTE "..(UnitName(party[i].unit))
		else
			text = text .. " DEMOTE "..(UnitName(party[i].unit))
		end
		if ( text ~= "" ) then
			SendAddonMessage("SRTI", text, "PARTY")
		end
	end
end

function srti.GenericRaidDropdown(unit,unitName)
	local info
	for index, value in ipairs( UnitPopupMenus["RAID_TARGET_ICON"] ) do
		info = {}
		info.text = UnitPopupButtons[value].text
		info.owner = UIDROPDOWNMENU_MENU_VALUE
		-- Set the text color
		local color = UnitPopupButtons[value].color
		if ( color ) then
			info.textR = color.r
			info.textG = color.g
			info.textB = color.b
		else
			info.textR = nil
			info.textG = nil
			info.textB = nil
		end
		-- Icons
		info.icon = UnitPopupButtons[value].icon
		info.tCoordLeft = UnitPopupButtons[value].tCoordLeft
		info.tCoordRight = UnitPopupButtons[value].tCoordRight
		info.tCoordTop = UnitPopupButtons[value].tCoordTop
		info.tCoordBottom = UnitPopupButtons[value].tCoordBottom
		-- Checked conditions
		local raidTargetIndex = GetRaidTargetIndex(unit)
		if ( raidTargetIndex == index ) then
			info.checked = 1
			info.arg1 = nil
		elseif ( index == 9 ) then
			info.arg1 = nil
		else
			info.arg1 = index
		end
		info.func = srti.SetRaidTarget
		if ( unitName ) then
			info.arg2 = unit
		end
		UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL)
	end
end

function srti.TogglePlayer(player)
	if ( SRTISaved.assistants[player] ) then
		SRTISaved.assistants[player] = nil
	else
		SRTISaved.assistants[player] = 1
	end
	srti.UpdateAssistants()
end

UnitPopupMenus["SRTI"] = {}
srti.orig_UnitPopup_ShowMenu = UnitPopup_ShowMenu
function srti.UnitPopup_ShowMenuHook(dropdownMenu, which, unit, name, userData, a6, a7, a8, a9, a10, a11)
	if ( GetNumRaidMembers() == 0 ) then
		local info = {}
		if ( which == "PARTY" or ( which == "PLAYER" and unit == "target" and UnitCanCooperate("player",unit) ) ) then
			if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
				if ( which == "PARTY" and UIDROPDOWNMENU_MENU_VALUE == "RAID_TARGET_ICON" and IsPartyLeader() ) then
					info.notClickable = 1
					UIDropDownMenu_AddButton(info,2)

					info = {}
					info.text = SRTI_UNIT_ASSISTANT
					info.arg1 = UnitName(unit)
					info.func = srti.TogglePlayer
					if ( SRTISaved.assistants[info.arg1] ) then
						info.checked = 1
						info.tooltipTitle = SRTI_UNIT_ASSISTANT_DEMOTE
						info.tooltipText = SRTI_UNIT_ASSISTANT_DEMOTE_TEXT
					else
						info.tooltipTitle = SRTI_UNIT_ASSISTANT_PROMOTE
						info.tooltipText = SRTI_UNIT_ASSISTANT_PROMOTE_TEXT
					end
					UIDropDownMenu_AddButton(info,2)
				elseif ( UIDROPDOWNMENU_MENU_VALUE == "SRTI" ) then
					srti.GenericRaidDropdown(unit,1)
				end
			elseif ( not IsPartyLeader() and srti.promoted == 1 ) then
				info.notCheckable = 1
				info.text = SRTI_UNIT_ASSISTANT
				info.hasArrow = 1
				info.tooltipTitle = SRTI_UNIT_SRTI
				info.tooltipText = SRTI_TITLE
				info.value = SRTI_UNIT_SRTI
				info.owner = which
				UIDropDownMenu_AddButton(info)
			end
		elseif ( which == "SELF" ) then
			local num = GetNumPartyMembers()
			if ( num == 0 ) then return end

			if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
				if ( IsPartyLeader() or srti.promoted == 1 ) then
					info.notCheckable = 1
					if ( srti.promoted == 1 ) then
						info.text = SRTI_UNIT_ASSISTANT
						info.hasArrow = 1
					else
						info.text = SRTI_UNIT_SRTI
						info.hasArrow = 1
					end
					info.tooltipTitle = SRTI_UNIT_SRTI
					info.tooltipText = SRTI_TITLE
					info.value = SRTI_UNIT_SRTI
					info.owner = which
					UIDropDownMenu_AddButton(info)
				else
					info.notCheckable = 1
					info.disabled = 1
					if ( srti.promoted == 0 ) then
						info.text = SRTI_UNIT_ASSISTANT_NOT_PROMOTED
					else
						info.text = SRTI_UNIT_ASSISTANT_DISABLED
					end
					UIDropDownMenu_AddButton(info)
				end
			elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 and UIDROPDOWNMENU_MENU_VALUE == "SRTI" ) then
				if ( IsPartyLeader() ) then
					info.text = SRTI_UNIT_ASSISTANTS
					info.clickable = 0
					info.isTitle = 1
					info.notCheckable = 1
					info.notClickable = 1
					UIDropDownMenu_AddButton(info,2)
					info = {}

					for i=1, num do
						local name = UnitName(party[i].unit)
						info.text = name
						if ( SRTISaved.assistants[name] ) then
							info.checked = 1
							info.tooltipTitle = SRTI_UNIT_ASSISTANT_DEMOTE
							info.tooltipText = SRTI_UNIT_ASSISTANT_DEMOTE_TEXT
						else
							info.checked = nil
							info.tooltipTitle = SRTI_UNIT_ASSISTANT_PROMOTE
							info.tooltipText = SRTI_UNIT_ASSISTANT_PROMOTE_TEXT
						end
						info.func = srti.TogglePlayer
						info.arg1 = name
						UIDropDownMenu_AddButton(info,2)
						info = UIDropDownMenu_CreateInfo()
					end
				elseif ( srti.promoted == 1 ) then
					srti.GenericRaidDropdown("player",1)
				end
			end
		elseif ( ( which == "RAID_TARGET_ICON" or ( which == "PLAYER" and not UnitCanCooperate("player",unit) ) ) and unit == "target" and not IsPartyLeader() and srti.promoted == 1 ) then
			info.text = SRTI_UNIT_ASSISTANT
			info.isTitle = 1
			info.notClickable = 1
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL)
			srti.GenericRaidDropdown(unit)
		end
	end
	return srti.orig_UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, a6, a7, a8, a9, a10, a11)
end
UnitPopup_ShowMenu = srti.UnitPopup_ShowMenuHook

function srti.SetupFrameRegistration()
	-- for addons that have no global frames or frames created on demand
	-- 1. oRA
	if (oRA) then
		if not srti._oRA then
			srti._oRA = {}
			srti._oRA.MTCreateUnitFrame = oRAOMainTank.CreateUnitFrame
			srti._oRA.PTCreateUnitFrame = oRAOPlayerTarget.CreateUnitFrame
			srti.MTCreateUnitFrame = function(oRAOMainTank,parent,id,type) 
				local frame = srti._oRA.MTCreateUnitFrame(oRAOMainTank,parent,id,type)
				if type=="mt" or type=="mtt" then
					local frameKey = "oRA_MainTankFrames_"..type..id
					ClickFrames[frameKey] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false,["frame"]=frame}
					ClickFramesNames[frame]=frameKey
					srti.UpdateClickHandlers()
				end
				return frame
			end
			srti.PTCreateUnitFrame = function(oRAOPlayerTarget,parent,id,type) 
				local frame = srti._oRA.PTCreateUnitFrame(oRAOPlayerTarget,parent,id,type)
				if type=="pt" or type=="ptt" then
					local frameKey = "oRA_PlayerTargetFrames_"..type..id
					ClickFrames[frameKey] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false,["frame"]=frame}
					ClickFramesNames[frame]=frameKey
					srti.UpdateClickHandlers()
				end
				return frame
			end
			oRAOMainTank.CreateUnitFrame = srti.MTCreateUnitFrame
			oRAOPlayerTarget.CreateUnitFrame = srti.PTCreateUnitFrame
		end
	end
	-- 2. Blizzard_RaidUI Blizzard player,target,party
	for i=1,MAX_RAID_MEMBERS do
		ClickFrames["RaidGroupButton"..i] = {["Script"]="OnDoubleClick",["OnDoubleClick"]=false}
	end
	if not srti._blizzRaidPullout then
		srti._blizzRaidPullout = {}
		srti._blizzRaidPullout.RaidPulloutButton_OnClick = RaidPulloutButton_OnClick
		srti.RaidPulloutButton_OnClick = function()
			srti._blizzRaidPullout.RaidPulloutButton_OnClick(this,arg1)
			srti.OnClick(this,arg1)	
		end
		RaidPulloutButton_OnClick = srti.RaidPulloutButton_OnClick
	end
	if not srti._blizzGroupFrames then
		srti._blizzGroupFrames = {}
		
		srti._blizzGroupFrames.PlayerFrame_OnClick = PlayerFrame_OnClick
		srti.PlayerFrame_OnClick = function()
			srti._blizzGroupFrames.PlayerFrame_OnClick(arg1)
			srti.OnClick(PlayerFrame,arg1)
		end
		PlayerFrame_OnClick = srti.PlayerFrame_OnClick

		srti._blizzGroupFrames.TargetFrame_OnClick = TargetFrame_OnClick
		srti.TargetFrame_OnClick = function()
			srti._blizzGroupFrames.TargetFrame_OnClick(arg1)
			srti.OnClick(TargetFrame,arg1)
		end
		TargetFrame_OnClick = srti.TargetFrame_OnClick 

		srti._blizzGroupFrames.PartyMemberFrame_OnClick = PartyMemberFrame_OnClick
		srti.PartyMemberFrame_OnClick = function()
			srti._blizzGroupFrames.PartyMemberFrame_OnClick(this,arg1)
			srti.OnClick(this,arg1)
		end
		PartyMemberFrame_OnClick = srti.PartyMemberFrame_OnClick		
	end
end
function srti.UpdateClickHandlers()
	for frameName,script in pairs(ClickFrames) do
		local ScriptName = ClickFrames[frameName].Script
		local frame = getglobal(frameName) or ClickFrames[frameName].frame
		if (frame) and not (frame._srti_done) then
			ClickFrames[frameName][ScriptName] = frame:GetScript(ScriptName) or false
			frame:SetScript(ScriptName,srti[ScriptName])
			frame._srti_done = true
		end
	end
end

function srti.OnClick(this,arg1)
	if arg1=="LeftButton" then
		local curtime = GetTime()
		local x, y = GetCursorPosition()
		local modifiers = srti.AreModifiersDown()
		local double = ( SRTISaved.double and srti.click and curtime - srti.click < (SRTISaved.speed or 0.25) and abs(x-srti.clickX) < 20 and abs(y-srti.clickY) < 20 )
		if ( modifiers or double ) then
			if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
				srti.frame.c = 0
			else
				srti.frame.c = nil
			end
			srti.click = nil
			srti.Show(true)
		else
			srti.click = curtime
		end
		srti.clickX, srti.clickY = x, y		
	end
end
function srti.OnDoubleClick()
	local frameName = this:GetName() or ClickFramesNames[this]
	local script = ClickFrames[frameName].OnDoubleClick
	if arg1=="LeftButton" then
		local x, y = GetCursorPosition()
		local modifiers = srti.AreModifiersDown()
		local double = true
		if ( modifiers or double ) then
			if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
				srti.frame.c = 0
			else
				srti.frame.c = nil
			end
			srti.click = nil
			srti.Show(true)
		end
		srti.clickX, srti.clickY = x, y		
	end
	if (script) then
		script(this,arg1)
	end	
end
function srti.OnMouseUp()
	local frameName = this:GetName()
	local script = ClickFrames[frameName].OnMouseUp
	if arg1=="LeftButton" then
		local curtime = GetTime()
		local x, y = GetCursorPosition()
		local modifiers = srti.AreModifiersDown()
		local double = ( SRTISaved.double and srti.click and curtime - srti.click < (SRTISaved.speed or 0.25) and abs(x-srti.clickX) < 20 and abs(y-srti.clickY) < 20 )
		if ( modifiers or double ) then
			if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
				srti.frame.c = 0
			else
				srti.frame.c = nil
			end
			srti.click = nil
			srti.Show()
		else
			srti.click = curtime
		end
		srti.clickX, srti.clickY = x, y		
	end
	if (script) then
		script(this,arg1)
	end
end

SlashCmdList["SRTI"] = function(msg)
	msg = string.lower(msg)
	local num = tonumber(msg)
	if ( msg == "" ) then
		srti.Options()
	elseif ( num and num < 9 ) then
		srti.SetRaidTarget(num)
	elseif ( msg == "debug" ) then
		if ( SRTISaved.debug ) then
			SRTISaved.debug = nil
		else
			SRTISaved.debug = 1
		end
	else
		for string, index in pairs(iconStrings) do
			if ( msg == string ) then
				srti.SetRaidTarget(index)
				return
			end
		end

		srti.PrintHelp()
	end
end

SLASH_SRTI1 = "/srti"

function srti.Options()
	srti.menu = CreateFrame("FRAME","SRTIOptionsMenu",UIParent)
	srti.menu:SetWidth(460)
	srti.menu:SetHeight(31)
	srti.menu:SetPoint("CENTER",UIParent,"CENTER",0,0)
	srti.menu:EnableMouse(1)
	srti.menu:SetMovable(1)

	tinsert(UISpecialFrames,"SRTIOptionsMenu")

	srti.menu:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu:SetBackdropColor(0.15, 0.15, 0.15)

	srti.menu.titleregion = srti.menu:CreateTitleRegion(srti.menu)
	srti.menu.titleregion:SetAllPoints(srti.menu)

	srti.menu.title = srti.menu:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	srti.menu.title:SetText(SRTI_HEADER)
	srti.menu.title:SetPoint("TOPLEFT",srti.menu,"TOPLEFT",8,-8)

	srti.menu.close = CreateFrame("BUTTON",nil,srti.menu,"UIPanelCloseButton")
	srti.menu.close:SetPoint("TOPRIGHT",srti.menu,"TOPRIGHT")

	srti.menu.options = CreateFrame("FRAME",nil,srti.menu)
	srti.menu.options:SetWidth(272)
	srti.menu.options:SetHeight(348)
	srti.menu.options:SetPoint("TOPLEFT",srti.menu,"BOTTOMLEFT")
	srti.menu.options:EnableMouse(1)
	srti.menu.options:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu.options:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu.options:SetBackdropColor(0.15, 0.15, 0.15)

	srti.menu.optionheader = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.optionheader:SetText(SRTI_OPTIONS_HEADER)
	srti.menu.optionheader:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",8,-8)


	srti.menu.options.singleframe = CreateFrame("FRAME",nil,srti.menu.options)
	srti.menu.options.singleframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -40)
	srti.menu.options.singleframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -94)
	srti.menu.options.singleframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.singleframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.singleframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.singletext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.singletext:SetText(SRTI_OPTIONS_SINGLE_HEADER)
	srti.menu.singletext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-28)

	srti.menu.modifiertext = srti.menu.options.singleframe:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.modifiertext:SetText(SRTI_OPTIONS_SINGLE_MODIFIERS)
	srti.menu.modifiertext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-49)

	srti.menu.shift = CreateFrame("CheckButton","SRTIcb3",srti.menu.options.singleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.shift:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",82,-42)
	srti.menu.shift:SetHitRectInsets(0,-30,5,5)
	srti.menu.shift.option = "shift"
	SRTIcb3Text:SetText(SRTI_OPTIONS_SINGLE_SHIFT)

	srti.menu.ctrl = CreateFrame("CheckButton","SRTIcb1",srti.menu.options.singleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.ctrl:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",142,-42)
	srti.menu.ctrl:SetHitRectInsets(0,-30,5,5)
	srti.menu.ctrl.option = "ctrl"
	SRTIcb1Text:SetText(SRTI_OPTIONS_SINGLE_CTRL)

	srti.menu.alt = CreateFrame("CheckButton","SRTIcb2",srti.menu.options.singleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.alt:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",202,-42)
	srti.menu.alt:SetHitRectInsets(0,-30,5,5)
	srti.menu.alt.option = "alt"
	SRTIcb2Text:SetText(SRTI_OPTIONS_SINGLE_ALT)

	srti.menu.singlehover = CreateFrame("CheckButton","SRTIcb4",srti.menu.options.singleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.singlehover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-66)
	srti.menu.singlehover:SetHitRectInsets(0,-130,5,5)
	srti.menu.singlehover.option = "singlehover"
	SRTIcb4Text:SetText(SRTI_OPTIONS_HOVER)


	srti.menu.options.doubleframe = CreateFrame("FRAME",nil,srti.menu.options)
	srti.menu.options.doubleframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -113)
	srti.menu.options.doubleframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -194)
	srti.menu.options.doubleframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.doubleframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.doubleframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.doubletext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.doubletext:SetText(SRTI_OPTIONS_DOUBLE_HEADER)
	srti.menu.doubletext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-101)

	srti.menu.doublecb = CreateFrame("CheckButton","SRTIcb5",srti.menu.options.doubleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.doublecb:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-115)
	srti.menu.doublecb:SetHitRectInsets(0,-30,5,5)
	SRTIcb5Text:SetText(SRTI_OPTIONS_DOUBLE_ENABLE)

	srti.menu.doublehover = CreateFrame("CheckButton","SRTIcb6",srti.menu.options.doubleframe,"UIOptionsCheckButtonTemplate")
	srti.menu.doublehover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",90,-115)
	srti.menu.doublehover:SetHitRectInsets(0,-130,5,5)
	srti.menu.doublehover.option = "doublehover"
	SRTIcb6Text:SetText(SRTI_OPTIONS_HOVER)

	srti.menu.doublespeed = CreateFrame("Slider","SRTIslider1",srti.menu.options.doubleframe,"OptionsSliderTemplate")
	srti.menu.doublespeed:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-160)
	srti.menu.doublespeed:SetPoint("TOPRIGHT",srti.menu.options,"TOPRIGHT",-18,-160)
	srti.menu.doublespeed:SetMinMaxValues(0.15,0.5)
	srti.menu.doublespeed:SetValueStep(0.01)
	srti.menu.doublespeed.option = "speed"
	SRTIslider1Low:SetText(SRTI_OPTIONS_DOUBLE_SPEED_MIN)
	SRTIslider1High:SetText(SRTI_OPTIONS_DOUBLE_SPEED_MAX)


	srti.menu.options.bindingframe = CreateFrame("FRAME",nil,srti.menu.options)
	srti.menu.options.bindingframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -213)
	srti.menu.options.bindingframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -296)
	srti.menu.options.bindingframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.bindingframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.bindingframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.bindingtext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.bindingtext:SetText(SRTI_OPTIONS_BINDING_HEADER)
	srti.menu.bindingtext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-201)

	srti.menu.bindingkey1 = CreateFrame("Button","SRTIkb1",srti.menu.options.bindingframe,"UIPanelButtonTemplate2")
	srti.menu.bindingkey1:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-219)
	srti.menu.bindingkey1:SetWidth(220)
	srti.menu.bindingkey1:SetTextFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey1:SetHighlightFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey1:SetScript("OnClick",function() srti.SetKeyBinding(arg1,"SRTI_SHOW",1) end)

	srti.menu.unbindingkey1 = CreateFrame("Button",nil,srti.menu.options.bindingframe)
	srti.menu.unbindingkey1:SetPoint("LEFT",srti.menu.bindingkey1,"RIGHT",-6,-1.5)
	srti.menu.unbindingkey1:SetWidth(32)
	srti.menu.unbindingkey1:SetHeight(32)
	--clear:SetHitRectInsets(9,7,-7,10)
	srti.menu.unbindingkey1:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
	srti.menu.unbindingkey1:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
	local h = srti.menu.unbindingkey1:CreateTexture(nil,"HIGHLIGHT")
	h:SetTexture("Interface\\Buttons\\CancelButton-Highlight")
	h:SetAllPoints()
	h:SetBlendMode("ADD")
	srti.menu.unbindingkey1:SetHighlightTexture(h)
	srti.menu.unbindingkey1:SetScript("OnClick",function() srti.SetKeyBinding(arg1,"SRTI_SHOW",1,1) end)

	srti.menu.bindingkey2 = CreateFrame("Button","SRTIkb2",srti.menu.options.bindingframe,"UIPanelButtonTemplate2")
	srti.menu.bindingkey2:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-242)
	srti.menu.bindingkey2:SetWidth(220)
	srti.menu.bindingkey2:SetTextFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey2:SetHighlightFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey2:SetScript("OnClick",function() srti.SetKeyBinding(arg1,"SRTI_SHOW",2) end)

	srti.menu.unbindingkey2 = CreateFrame("Button",nil,srti.menu.options.bindingframe)
	srti.menu.unbindingkey2:SetPoint("LEFT",srti.menu.bindingkey2,"RIGHT",-6,-1.5)
	srti.menu.unbindingkey2:SetWidth(32)
	srti.menu.unbindingkey2:SetHeight(32)
	--clear:SetHitRectInsets(9,7,-7,10)
	srti.menu.unbindingkey2:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
	srti.menu.unbindingkey2:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
	h = srti.menu.unbindingkey2:CreateTexture(nil,"HIGHLIGHT")
	h:SetTexture("Interface\\Buttons\\CancelButton-Highlight")
	h:SetAllPoints()
	h:SetBlendMode("ADD")
	srti.menu.unbindingkey2:SetHighlightTexture(h)
	srti.menu.unbindingkey2:SetScript("OnClick",function() srti.SetKeyBinding(arg1,"SRTI_SHOW",2,1) end)

	srti.menu.bindinghover = CreateFrame("CheckButton","SRTIcb7",srti.menu.options.bindingframe,"UIOptionsCheckButtonTemplate")
	srti.menu.bindinghover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-268)
	srti.menu.bindinghover:SetHitRectInsets(0,-130,5,5)
	srti.menu.bindinghover.option = "bindinghover"
	SRTIcb7Text:SetText(SRTI_OPTIONS_HOVER)


	srti.menu.options.hoverframe = CreateFrame("FRAME",nil,srti.menu.options)
	srti.menu.options.hoverframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -298)
	srti.menu.options.hoverframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -342)
	srti.menu.options.hoverframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.hoverframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.hoverframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.hovertime = CreateFrame("Slider","SRTIslider2",srti.menu.options,"OptionsSliderTemplate")
	srti.menu.hovertime:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-312)
	srti.menu.hovertime:SetPoint("TOPRIGHT",srti.menu.options,"TOPRIGHT",-18,-312)
	srti.menu.hovertime:SetMinMaxValues(0.0,0.5)
	srti.menu.hovertime:SetValueStep(0.05)
	srti.menu.hovertime.option = "hovertime"
	SRTIslider2Low:SetText(SRTI_OPTIONS_HOVER_TIME_MIN)
	SRTIslider2High:SetText(SRTI_OPTIONS_HOVER_TIME_MAX)

	srti.menu.test = CreateFrame("FRAME",nil,srti.menu)
	srti.menu.test:EnableMouse(1)
	srti.menu.test:SetMovable(1)
	srti.menu.test:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu.test:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu.test:SetBackdropColor(0.15, 0.15, 0.15)
	srti.menu.test:SetPoint("TOPRIGHT",srti.menu,"BOTTOMRIGHT",0,0)
	srti.menu.test:SetPoint("BOTTOMLEFT",srti.menu.options,"BOTTOMRIGHT",0,0)

	srti.menu.test.model = CreateFrame("PLAYERMODEL",nil,srti.menu.test)
	srti.menu.test.model:SetPoint("TOPRIGHT",srti.menu.test,"TOPRIGHT",0,-48)
	srti.menu.test.model:SetPoint("BOTTOMLEFT",srti.menu.test,"BOTTOMLEFT",0,0)
	srti.menu.test.model:RegisterEvent("DISPLAY_SIZE_CHANGED")
	srti.menu.test.model:SetRotation(0.61)
	srti.menu.test.model:SetUnit("player")
	srti.menu.test.model:SetScript("OnEvent", function() this:RefreshUnit() end )

	srti.menu.test.icon = srti.menu.test:CreateTexture(nil,"BORDER")
	srti.menu.test.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	srti.menu.test.icon:SetWidth(42)
	srti.menu.test.icon:SetHeight(42)
	srti.menu.test.icon:SetPoint("TOP",srti.menu.test,"TOP",0,-8)
	srti.menu.test.icon:Hide()

	srti.menu.test.text = srti.menu.test:CreateFontString(nil,"ARTWORK","NumberFontNormal")
	srti.menu.test.text:SetText(SRTI_OPTIONS_TEST)
	srti.menu.test.text:SetPoint("TOP",srti.menu.test.icon,"BOTTOM")

	srti.menu.test.help = srti.menu.test:CreateFontString(nil,"ARTWORK","GameFontDisable")
	srti.menu.test.help:SetText(SRTI_OPTIONS_TEST_HELP)
	srti.menu.test.help:SetPoint("BOTTOM",srti.menu.test,"BOTTOM",0,8)
	srti.menu.test.help:SetPoint("LEFT",srti.menu.test,"LEFT",0,8)
	srti.menu.test.help:SetPoint("RIGHT",srti.menu.test,"RIGHT",0,-8)


	srti.menu.test.ShowRadial = function(c)
		srti.frame.c = c
		srti.frame.s = GetTime()
		srti.frame.h = nil
		srti.frame.i = nil
		srti.frame.l = nil
		srti.frame.test = 1
		srti.frame.portrait = nil

		local x,y = GetCursorPosition()
		local s = srti.frame:GetEffectiveScale()
		srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x/s, y/s )
		srti.frame:Show()
	end

	srti.menu.test:SetScript("OnMouseUp",function()
		if ( arg1 == "LeftButton" ) then
			local time = GetTime()
			local x, y = GetCursorPosition()
			local modifiers = srti.AreModifiersDown()
			local double = ( SRTISaved.double and srti.click and time - srti.click < (SRTISaved.speed or 0.25) and abs(x-srti.clickX) < 20 and abs(y-srti.clickY) < 20 )
			if ( modifiers or double ) then
				if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
					srti.menu.test.ShowRadial(0)
				else
					srti.menu.test.ShowRadial()
				end
			else
				srti.click = time
			end
			srti.clickX, srti.clickY = x, y
		end
	end
	)

	srti.menu.UpdateCB = function()
		if ( SRTISaved.ctrl or SRTISaved.alt or SRTISaved.shift ) then
			srti.menu.singletext:SetFontObject("GameFontHighlightSmall")
			srti.menu.modifiertext:SetFontObject("GameFontHighlightSmall")
			SRTIcb4Text:SetFontObject("GameFontNormalSmall")
		else
			srti.menu.singletext:SetFontObject("GameFontDisableSmall")
			srti.menu.modifiertext:SetFontObject("GameFontDisableSmall")
			SRTIcb4Text:SetFontObject("GameFontDisableSmall")
		end
	end

	srti.menu.ModiferCB = function()
		SRTISaved[this.option] = this:GetChecked() == 1
		srti.menu.UpdateCB()
	end

	srti.menu.UpdateDouble = function()
		if ( SRTISaved.double ) then
			srti.menu.doubletext:SetFontObject("GameFontHighlightSmall")
			SRTIslider1Text:SetFontObject("GameFontNormalSmall")
			SRTIslider1Low:SetFontObject("GameFontHighlightSmall")
			SRTIslider1High:SetFontObject("GameFontHighlightSmall")
			SRTIcb6Text:SetFontObject("GameFontNormalSmall")
		else
			srti.menu.doubletext:SetFontObject("GameFontDisableSmall")
			SRTIslider1Text:SetFontObject("GameFontDisableSmall")
			SRTIslider1Low:SetFontObject("GameFontDisableSmall")
			SRTIslider1High:SetFontObject("GameFontDisableSmall")
			SRTIcb6Text:SetFontObject("GameFontDisableSmall")
		end
	end

	srti.menu.DoubleCB = function()
		SRTISaved.double = this:GetChecked() == 1
		srti.menu.UpdateDouble()
	end

	srti.menu.UpdateSlider = function()
		SRTIslider1Text:SetText(string.format(SRTI_OPTIONS_DOUBLE_SPEED,string.sub(SRTISaved.speed,1,4) or 0.25))
		SRTIslider2Text:SetText(string.format(SRTI_OPTIONS_HOVER_TIME,string.sub(SRTISaved.hovertime,1,4) or 0.2))
	end

	srti.menu.DoubleSlider = function()
		SRTISaved[this.option] = this:GetValue()
		srti.menu.UpdateSlider()
	end

	srti.menu.ctrl:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.alt:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.shift:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.singlehover:SetScript("OnClick",srti.menu.ModiferCB)

	srti.menu.doublecb:SetScript("OnClick",srti.menu.DoubleCB)
	srti.menu.doublespeed:SetScript("OnValueChanged",srti.menu.DoubleSlider)
	srti.menu.hovertime:SetScript("OnValueChanged",srti.menu.DoubleSlider)
	srti.menu.doublehover:SetScript("OnClick",srti.menu.ModiferCB)

	srti.menu.bindinghover:SetScript("OnClick",srti.menu.ModiferCB)

	srti.menu.UpdateBindings = function()
		local binding1, binding2 = GetBindingKey("SRTI_SHOW")

		if ( binding1 ) then
			srti.menu.bindingkey1:SetText(GetBindingText(binding1, "KEY_"))
			srti.menu.bindingkey1:SetAlpha(1)
		else
			srti.menu.bindingkey1:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
			srti.menu.bindingkey1:SetAlpha(0.8)
		end
		if ( binding2 ) then
			srti.menu.bindingkey2:SetText(GetBindingText(binding2, "KEY_"))
			srti.menu.bindingkey2:SetAlpha(1)
		else
			srti.menu.bindingkey2:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
			srti.menu.bindingkey2:SetAlpha(0.8)
		end
	end

	srti.menu.Update = function()
		srti.menu.ctrl:SetChecked(SRTISaved.ctrl or 0)
		srti.menu.alt:SetChecked(SRTISaved.alt or 0)
		srti.menu.shift:SetChecked(SRTISaved.shift or 0)
		srti.menu.singlehover:SetChecked(SRTISaved.singlehover or 0)

		srti.menu.doublespeed:SetValue(SRTISaved.speed or 0.25)
		srti.menu.hovertime:SetValue(SRTISaved.hovertime or 0.2)
		srti.menu.doublecb:SetChecked(SRTISaved.double or 0)
		srti.menu.doublehover:SetChecked(SRTISaved.doublehover or 0)

		srti.menu.UpdateCB()
		srti.menu.UpdateSlider()
		srti.menu.UpdateDouble()
		srti.menu.UpdateBindings()
	end

	srti.menu:SetScript("OnShow", srti.menu.Update)

	srti.menu.Update()

	srti.Options = function()
		if ( srti.menu:IsVisible() ) then
			srti.menu:Hide()
		else
			srti.menu:Show()
		end
	end
end

function srti.SetKeyBinding(button,binding,index,mode)
	srti.keybindings = CreateFrame("FRAME","SRTIKeyBindingsFrame",UIParent)
	srti.keybindings:EnableKeyboard(1)
	srti.keybindings:EnableMouse(1)
	srti.keybindings:EnableMouseWheel(1)
	srti.keybindings:SetFrameStrata("FULLSCREEN_DIALOG")
	srti.keybindings:SetAllPoints()

	srti.keybindings.bg = srti.keybindings:CreateTexture(nil,"BACKGROUND")
	srti.keybindings.bg:SetTexture(0.15,0.15,0.15)
	srti.keybindings.bg:SetAlpha(0.75)
	srti.keybindings.bg:SetAllPoints()

	srti.keybindings.frame = CreateFrame("FRAME",nil,srti.keybindings)
	srti.keybindings.frame:SetPoint("CENTER",srti.keybindings,"CENTER", 0, 50)
	srti.keybindings.frame:SetWidth(400)
	srti.keybindings.frame:SetHeight(100)
	srti.keybindings.frame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.keybindings.frame:SetBackdropBorderColor(0, 0, 0)
	srti.keybindings.frame:SetBackdropColor(0.1, 0.1, 0.1)

	srti.keybindings.keytext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontHighlightLarge")
	srti.keybindings.keytext:SetPoint("CENTER",srti.keybindings.frame,"CENTER",0,0)

	srti.keybindings.helptext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
	srti.keybindings.helptext:SetPoint("TOP",srti.keybindings.frame,"TOP",0,-4)

	srti.keybindings.warntext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
	srti.keybindings.warntext:SetPoint("BOTTOM",srti.keybindings.frame,"BOTTOM",0,4)

	srti.keybindings.acceptframe = CreateFrame("FRAME",nil,srti.keybindings.frame)
	srti.keybindings.acceptframe:SetPoint("TOP",srti.keybindings.frame,"BOTTOM", 0, 0)
	srti.keybindings.acceptframe:SetWidth(400)
	srti.keybindings.acceptframe:SetHeight(28)
	srti.keybindings.acceptframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.keybindings.acceptframe:SetBackdropBorderColor(0, 0, 0)
	srti.keybindings.acceptframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.keybindings.esctext = srti.keybindings.acceptframe:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	srti.keybindings.esctext:SetPoint("CENTER",srti.keybindings.acceptframe,"CENTER",0)
	srti.keybindings.esctext:SetText(SRTI_BINDINGS_ESC)

	srti.keybindings.accept = CreateFrame("BUTTON",nil,srti.keybindings.acceptframe,"UIPanelButtonTemplate")
	srti.keybindings.accept:SetPoint("RIGHT",srti.keybindings.acceptframe,"RIGHT",-2,0)
	srti.keybindings.accept:SetText(ACCEPT)
	srti.keybindings.accept:SetWidth(80)
	srti.keybindings.accept:SetHeight(22)
	srti.keybindings.accept:Disable()

	srti.keybindings.accept:SetScript("OnClick", function()
			srti.keybindings:Hide()
			if ( srti.keybindings.mode ) then
				if ( srti.keybindings.key ) then
					SetBinding(srti.keybindings.key)
				end
			elseif ( srti.keybindings.key and srti.keybindings.binding ) then
				local key1, key2 = GetBindingKey(srti.keybindings.binding)
				if ( key1 ) then
					SetBinding(key1)
				end
				if ( key2 ) then
					SetBinding(key2)
				end
				if ( srti.keybindings.index == 1 ) then
					SetBinding(srti.keybindings.key, srti.keybindings.binding)
					if ( key2 ) then
						SetBinding(key2, srti.keybindings.binding)
					end
				else
					if ( key1 ) then
						SetBinding(key1, srti.keybindings.binding)
					end
					SetBinding(srti.keybindings.key, srti.keybindings.binding)
				end
			end
			SaveBindings(GetCurrentBindingSet())
			srti.menu.UpdateBindings()
		end)

	function srti.keybindings.OnShow()
		if ( srti.keybindings.mode ) then
			if ( not srti.keybindings.key ) then
				srti.keybindings:Hide()
			end
			srti.keybindings.helptext:SetText(format(SRTI_BINDINGS_UNBIND_HELP, GetBindingText(binding, "BINDING_NAME_")))
			srti.keybindings.keytext:SetText(srti.keybindings.key)
			srti.keybindings.warntext:SetText("")
			srti.keybindings.accept:Enable()
		else
			srti.keybindings.helptext:SetText(format(SRTI_BINDINGS_BIND_HELP, GetBindingText(binding, "BINDING_NAME_")))
			srti.keybindings.keytext:SetText(srti.keybindings.key or NOT_BOUND)
			srti.keybindings.warntext:SetText("")
			if ( srti.keybindings.key ) then
				srti.keybindings.accept:Enable()
			else
				srti.keybindings.accept:Disable()
			end
		end
	end

	function srti.keybindings.OnKeyDown(key)
		local screenshotKey = GetBindingKey("SCREENSHOT")
		if ( screenshotKey and key == screenshotKey ) then
			Screenshot()
			return
		end
		if ( key=="ESCAPE" ) then
			srti.keybindings:Hide()
		elseif ( not srti.keybindings.mode and key ~= "LeftButton" and key ~= "RightButton" and key ~= "SHIFT" and key ~= "ALT" and key ~= "CTRL" and key ~= "UNKNOWN" ) then
			srti.keybindings.OnShow()
			if ( key == "MiddleButton" ) then
				key = "BUTTON3"
			elseif ( key == "Button4" ) then
				key = "BUTTON4"
			elseif ( key == "Button5" ) then
				key = "BUTTON5"
			end
			if ( srti.keybindings.modifier ) then
				if IsLeftShiftKeyDown() then
					key = "LSHIFT-"..key
				end
				if IsLeftAltKeyDown() then
					key = "LALT-"..key
				end
				if IsLeftControlKeyDown() then
					key = "LCTRL-"..key
				end
				if IsRightShiftKeyDown() then
					key = "RSHIFT-"..key
				end
				if IsRightAltKeyDown() then
					key = "RALT-"..key
				end
				if IsRightControlKeyDown() then
					key = "RCTRL-"..key
				end
			else
				if IsShiftKeyDown() then
					key = "SHIFT-"..key
				end
				if IsAltKeyDown() then
					key = "ALT-"..key
				end
				if IsControlKeyDown() then
					key = "CTRL-"..key
				end
			end

			srti.keybindings.keytext:SetText( key )
			srti.keybindings.key = key
			srti.keybindings.accept:Enable()

			local oldAction = GetBindingAction(key)
			if ( oldAction ~= "" and oldAction ~= srti.keybindings.binding ) then
				local oldkeys = table.getn({GetBindingKey(oldAction)})
				if ( oldkeys > 1 ) then
					srti.keybindings.warntext:SetText(format(SRTI_BINDINGS_BIND_WARN, GetBindingText(oldAction, "BINDING_NAME_")))
				else
					srti.keybindings.warntext:SetText(format(SRTI_BINDINGS_BIND_WARN_UNBOUND, GetBindingText(oldAction, "BINDING_NAME_")))
				end
			end
		end
	end

	srti.keybindings:SetScript("OnKeyDown", function() srti.keybindings.OnKeyDown(arg1) end)
	srti.keybindings:SetScript("OnMouseUp", function() srti.keybindings.OnKeyDown(arg1) end)
	srti.keybindings:SetScript("OnMouseWheel", function()
			if ( arg1 > 0 ) then
				srti.keybindings.OnKeyDown("MOUSEWHEELUP")
			else
				srti.keybindings.OnKeyDown("MOUSEWHEELDOWN")
			end
		end)

	srti.SetKeyBinding = function(button,binding,index,mode)
		srti.keybindings.binding = binding or "SRTI_SHOW"
		srti.keybindings.index = index or 1
		local t = {GetBindingKey(srti.keybindings.binding)}
		srti.keybindings.key = t[srti.keybindings.index]
		srti.keybindings.mode = mode

		srti.keybindings.accept:Disable()
		srti.keybindings:Show()
		srti.keybindings.OnShow()
		srti.keybindings.OnKeyDown(button)
	end

	srti.SetKeyBinding(button, binding, index, mode)
end

local cc_marks = {
	["MAGE"] = {5,6,2,1}, 	-- "moon", "square", "circle", "star"
	["WARLOCK"] = {3,6}, 	-- "diamond", "square"
	["HUNTER"] = {4,6},	-- "triangle", "square"
	["PRIEST"] = {1,2,3},		-- "star", "circle", "diamond"
	["DRUID"] = {2,4},		-- "circle", "triangle"
	["SHAMAN"] = {6,4}		-- "square", "triangle"
}
local cc_type_class = {
	["Humanoid"] = {"MAGE","HUNTER","WARLOCK","PRIEST"},
	["Giant"] = {"HUNTER","WARLOCK"},
	["Beast"] = {"MAGE","HUNTER","DRUID"},
	["Dragonkin"] = {"HUNTER","DRUID"},
	["Demon"] = {"WARLOCK","HUNTER"},
	["Elemental"] = {"WARLOCK","HUNTER"},
	["Undead"] = {"PRIEST","HUNTER"},
	["Mechanical"] = {"HUNTER"}
}
local cc_immune = { -- individual npc exclusions
	-- ZG
  ["Gurubashi Champion"] = true,
  ["Gurubashi Berserker"] = true,
  -- MC
  ["Ancient Core Hound"] = true,
  ["Firelord"] = true,
  ["Flameguard"] = true,
  ["Firewalker"] = true,
  -- BWL
  ["Death Talon Captain"] = true,
  ["Death Talon Wyrmguard"] = true,
  ["Death Talon Flamescale"] = true,
  ["Death Talon Seether"] = true,
  ["Death Talon Overseer"] = true,
  ["Blackwing Spellbinder"] = true,
  ["Blackwing Technician"] = true,
  ["Blackwing Warlock"] = true,  
}
local kill_targets = { -- this will have specific kill prio npcs
	["Firewalker"] = 8,
	["Flameguard"] = 7,
	["Lava Elemental"] = 6,
	["Lava Reaver"] = 5,
	["Gurubashi Berserker"] = 8,
}
function srti.UpdateClassCount()
	CC_ClassCount = {}
	local inRaid
	for i=1,GetNumRaidMembers() do
		inRaid = true
		local _, class = UnitClass(raid[i].unit)
		if cc_marks[class] then
			CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
		end
	end
	if not inRaid then
		local _,class = UnitClass("player")
		if cc_marks[class] then
			CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
		end
		for i=1,GetNumPartyMembers() do
			_,class = UnitClass(party[i].unit)
			if cc_marks[class] then
				CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
			end
		end
	end
end

local lastMarkAction = 0
function srti.MouseOverMark(mark)
	local unit = UnitExists("mouseover") and "mouseover"
	if not (unit) then return false end
	local now = GetTime()
	if (now - lastMarkAction) >= TOOLTIP_UPDATE_TIME then
		lastMarkAction = now
		SetRaidTarget(unit,mark)
		return true
	end
	return false
end

local assigned_cc_class, assigned_cc_marks, assigned_mark_class = {},{},{}
function srti.MassMark()
	if UnitExists("mouseover") then
		-- don't clobber existing marks
		local alreadyMarked = GetRaidTargetIndex("mouseover")
		if (alreadyMarked) then 
			if not (assigned_cc_marks[alreadyMarked]) then
				assigned_cc_marks[alreadyMarked] = true
			end
			return 
		end		
    -- don't cc mark bosses
		if (UnitClassification("mouseover") == "worldboss") or (UnitLevel("mouseover")==-1) then return end 
		-- only mark enemies we can attack
		if not UnitCanAttack("player","mouseover") then return end
		-- don't try cc known immune mobs
		local unitName = (UnitName("mouseover"))
		if cc_immune[unitName] then return end
		-- pass the name to our special pack marker
		if srti.PackMark(unitName) then return end
		-- do we have another CCer we haven't assigned?
    if not next(CC_ClassCount) then return end
		local creatureType = UnitCreatureType("mouseover")
		local ccers = cc_type_class[creatureType]
		if (ccers) then -- is it a type that can be cc
			for _, class in ipairs(ccers) do
				if (CC_ClassCount[class] ~= nil) and (CC_ClassCount[class] > 0) and CC_ClassCount[class] > (assigned_cc_class[class] or 0) then -- do we have the class that can cc it
					local marks = cc_marks[class]
					for _, mark in ipairs(marks) do
						if not (assigned_cc_marks[mark]) and srti.MouseOverMark(mark) then
							assigned_cc_marks[mark]=true
							assigned_cc_class[class] = (assigned_cc_class[class] ~= nil) and (assigned_cc_class[class]+1) or 1
							assigned_mark_class[getglobal("RAID_TARGET_"..mark)] = class
							return
						end
					end
				end
			end
		end
	end
end

local pack_marks = { -- negative index does reverse order, eg -1 marks skull, -2 marks skull>cross etc
	["Slavering Ghoul"] = 8, -- just for debug
	["Firesworn"] = 8,
	["Core Hound"] = 5,
	-- mixed group Majordomo adds
	["Flamewaker Healer"] = 4,
	["Flamewaker Elite"] = -4,
}
function srti.PackMark(name)
	-- for debug
	local pack = pack_marks[name]
	if pack ~= nil then
		if pack < 0 then
			pack = 8-pack
		end
    for _, mark in ipairs(marksCol[pack]) do
      if not (assigned_cc_marks[mark]) and srti.MouseOverMark(mark) then
        assigned_cc_marks[mark] = true
        return true
      end
    end		
	end
  return false
end

function srti.StartMouseoverMark()
	srti.frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.StopMouseoverMark()
	srti.frame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	assigned_cc_class,assigned_cc_marks = {}, {}
	for mark,class in pairs(assigned_mark_class) do
		print(camelCase(class).."> "..mark)
	end
	assigned_mark_class = {}
end

srti.clearFrame = CreateFrame("Frame")
srti.clearFrame:SetScript("OnEvent",function()
	if event == "UPDATE_MOUSEOVER_UNIT" then
		if UnitExists("mouseover") then
			if (GetRaidTargetIndex("mouseover")) then
				SetRaidTarget("mouseover",0)
				return
			end
		end
	end
end)
function srti.StartMouseoverClear()
	srti.clearFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.StopMouseoverClear()
	srti.clearFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.Target(unit)
	TargetUnit(unit)
	srti.scanTarget = nil
	PlaySound("igCharacterNPCSelect")
	SRTI.ShowCursorCompanion()
end

function srti.TargetScan(icon,fromBinding)
	if not (icon) then return end
	local inRaid = UnitInRaid("player")
	local numMembers = GetNumPartyMembers()
	local inParty = not (inRaid) and (numMembers > 0)
	if not (inParty or inRaid) then return end
	srti.scanTarget = icon
	if (inParty) then
		for i=1,numMembers do
			if UnitExists(party[i].target) then
				local mark = GetRaidTargetIndex(party[i].target)
				if mark and mark == icon then
					srti.Target(party[i].target)
					break
				end
			end
		end
		return
	else
		local numRaidMembers = GetNumRaidMembers()
		for i=1,numRaidMembers do
			if not UnitIsUnit("player", raid[i].unit) then
				if UnitExists(raid[i].target) then
					local mark = GetRaidTargetIndex(raid[i].target)
					if mark and mark == icon then
						srti.Target(raid[i].target)
						break
					end
				end
			end
		end
		return
	end
end

function srti.ShowMarkOrderBar(show)
	if (show) then
		local x,y = GetCursorPosition()
		local s = srti.barFrame:GetEffectiveScale()
		srti.barFrame:ClearAllPoints()
		srti.barFrame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", (x/s)+75, (y/s)-30 )
		srti.barFrame:Show()
	else
		srti.barFrame:Hide()
	end
end

srti.cursorFrame = CreateFrame("Frame","SRTICursorCompanionFrame",UIParent)
srti.cursorFrame:SetWidth(24)
srti.cursorFrame:SetHeight(24)
srti.cursorFrame.tex = srti.cursorFrame:CreateTexture("SRTICursorCompanionFrameTex","OVERLAY")
srti.cursorFrame.tex:SetWidth(24)
srti.cursorFrame.tex:SetHeight(24)
srti.cursorFrame.tex:SetPoint("CENTER",srti.cursorFrame,"CENTER",0,0)
srti.cursorFrame.tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
srti.cursorFrame:Hide()
srti.cursorFrame._lastUpdate = 0
srti.cursorFrame:SetScript("OnUpdate",function()
		this._lastUpdate = this._lastUpdate + arg1
		--if (this._lastUpdate >= TOOLTIP_UPDATE_TIME) then
			this._lastUpdate = 0
			local x,y = GetCursorPosition()
			local s = UIParent:GetEffectiveScale()
			this:ClearAllPoints()
			this:SetPoint("CENTER",UIParent,"BOTTOMLEFT",(x/s)+24,(y/s)-24)
		--end
	end)
function srti.ShowCursorCompanion(mark)
	if (mark) then
		SetRaidTargetIconTexture(srti.cursorFrame.tex,mark)
		srti.cursorFrame:Show()
	else
		srti.cursorFrame:Hide()
	end
end

SRTI = srti