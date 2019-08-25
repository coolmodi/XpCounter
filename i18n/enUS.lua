local _addonName, _addon = ...;
local L = _addon:AddLocalization("enUS", true);
if L == nil then return; end

L["CHAT_HEADER"] = "|cFFFFFF00XpCounter commands:";
L["CHAT_CMD_SHOW"] = "|cFFAAFFAA /xpc show |rShow the info box";
L["CHAT_CMD_RESET"] = "|cFFAAFFAA /xpc reset |rReset data";
L["CHAT_CMD_LOCK"] = "|cFFAAFFAA /xpc lock |rLock or unlock the info box";

L["FRAME_TITLE"] = "XpCounter";
L["FRAME_DURATION"] = "Duration:";
L["FRAME_GAINED"] = "XP Gained:";
L["FRAME_PERHOUR"] = "XP/hour:";
L["FRAME_TTLU"] = "Next level:";
L["FRAME_REPSTLU"] = "Kills needed:";