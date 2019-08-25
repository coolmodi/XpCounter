local _addonName, _addon = ...;
local L = _addon:GetLocalization();
local frame = XPCOUNTER_UIFRAME;
local sv;

local LAST_GAIN_LEN = 5;
local lastGainInserPos = 1;

--- Convert seconds to a more readable format
-- @param diff Time in seconds
local function ReadableTimeDiff(diff)
	return ("%02d:%02d:%02d"):format(math.floor(diff/3600), math.floor((diff%3600)/60), diff%60);
end

--- Update all values
-- @param duration Human readable time for session duration
-- @param gained Total XP gained in session
-- @param perhour XP per hour
-- @param ttlu Human readable time to level up
-- @param repstlu Repeat las gain to level up
function frame:SetValues(duration, gained, perhour, ttlu, repstlu)
	self.durationVal:SetText(duration);
	self.gainedVal:SetText(gained);
    self.perhourVal:SetText(perhour);
    self.ttluVal:SetText(ttlu);
    self.repstluVal:SetText(repstlu);
end

--- Lock or unlock teh frame
-- Hides the header and makes immovable
-- @param locked
function frame:LockFrame(locked)
	if locked then
		self.header:Hide();
	else
		self.header:Show();
	end
	frame:SetMovable(not locked);
	frame:EnableMouse(not locked);
end

--- Update data in display
function frame:UpdateDisplay()
	if not self:IsShown() then
		return;
	end

	if sv.startTime == 0 then
		self:SetValues("0", 0, 0, "0", 0);
		return;
	end

	local secondsPassed = time() - sv.startTime;
	local perSecond = sv.xpGained / secondsPassed;
	local xpNeeded = UnitXPMax("player") - UnitXP("player");
	local killgainAvg = 0;
	for i = 1, LAST_GAIN_LEN, 1 do
		killgainAvg = killgainAvg + sv.lastXPGain[i];
	end
	killgainAvg = killgainAvg / LAST_GAIN_LEN;
	local reps = math.ceil(xpNeeded / killgainAvg);

	self:SetValues(ReadableTimeDiff(secondsPassed), sv.xpGained, math.floor(perSecond*3600), ReadableTimeDiff(xpNeeded / perSecond), reps);
end

-- Handle CHAT_MSG_COMBAT_XP_GAIN
function frame.CHAT_MSG_COMBAT_XP_GAIN(self, text)
	local gained = tonumber(string.match(text, "(%d+)"));

	if gained == nil or gained == 0 then
		return;
	end

	if sv.startTime == 0 then
		sv.startTime = time();
	end

	sv.lastXPGain[lastGainInserPos] = gained;
	lastGainInserPos = lastGainInserPos + 1;
	if lastGainInserPos > LAST_GAIN_LEN then
		lastGainInserPos = 1;
	end

	sv.xpGained = sv.xpGained + gained;

	self:UpdateDisplay();
end

-- Handle ADDON_LOADED
function frame.ADDON_LOADED(self, addonname) 
	if addonname ~= _addonName then 
		return; 
	end
	self:UnregisterEvent("ADDON_LOADED");

	if XpCounter_SVData == nil then
		XpCounter_SVData = {
			locked = false;
			startTime = 0,
			xpGained = 0,
			lastXPGain = {}
		}
		for i = 1, LAST_GAIN_LEN, 1 do
			XpCounter_SVData.lastXPGain[i] = 0;
		end
	end

	sv = XpCounter_SVData;
	frame:LockFrame(sv.locked);
end

frame:SetScript("OnEvent",function(self, event, ...) 
	self[event](self, ...);
end)

frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");

-- Update display
frame.sinceLastUpdate = 0;
frame:SetScript("OnUpdate", function(self, elapsed)
	self.sinceLastUpdate = self.sinceLastUpdate + elapsed;
	if self.sinceLastUpdate > 3 then
		self:UpdateDisplay();
		self.sinceLastUpdate = 0;
	end
end);

-- Hide on click on close button
frame.closeButton:SetScript("OnClick", function()
	frame:Hide();
end);

-- Slash command
SLASH_XPCOUNTER1 = "/xpc";
SlashCmdList["XPCOUNTER"] = function(arg)
	if arg == "show" then
		frame:Show();
		return;
	end

	if arg == "reset" then
		wipe(sv.lastXPGain);
		for i = 1, LAST_GAIN_LEN, 1 do
			sv.lastXPGain[i] = 0;
		end
		sv.xpGained = 0;
		sv.startTime = 0;
		frame:UpdateDisplay();
		return;
	end

	if arg == "lock" then
		sv.locked = not sv.locked;
		frame:LockFrame(sv.locked);
		return;
	end

	print(L["CHAT_HEADER"]);
	print(L["CHAT_CMD_SHOW"]);
	print(L["CHAT_CMD_LOCK"]);
	print(L["CHAT_CMD_RESET"]);
end