local _addonName, _addon = ...;
local L = _addon:AddLocalization("deDE", true);
if L == nil then return; end

L["CHAT_HEADER"] = "|cFF6666FFXpCounter Kommandos:";
L["CHAT_CMD_SHOW"] = "|cFFAAAAFF /xpc show Zeige die Infobox";
L["CHAT_CMD_RESET"] = "|cFFAAAAFF /xpc reset Setze Daten zurück";
L["CHAT_CMD_LOCK"] = "|cFFAAFFAA /xpc lock |rInfobox (ent)sprerren";

L["FRAME_TITLE"] = "XpCounter";
L["FRAME_DURATION"] = "Laufzeit:";
L["FRAME_GAINED"] = "XP erhalten:";
L["FRAME_PERHOUR"] = "XP/Stunde:";
L["FRAME_TTLU"] = "Nächster Level: ";
L["FRAME_REPSTLU"] = "Kills nötig:";