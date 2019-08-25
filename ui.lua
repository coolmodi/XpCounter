local _, _addon = ...;
local L = _addon:GetLocalization();
local frame = CreateFrame("Frame", "XPCOUNTER_UIFRAME", UIParent);

frame:SetPoint("CENTER", 0, 0);
frame:SetFrameStrata("MEDIUM");
frame:SetWidth(175);
frame:SetClampedToScreen(true);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);

---------------------------------------------------------------------
-- HEADER
frame.header = CreateFrame("Frame", nil, frame);
frame.header:SetPoint("TOPLEFT", 0, 0);
frame.header:SetPoint("TOPRIGHT", 0, 0);
frame.header:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"});
frame.header:SetBackdropColor(0,0,0,0.5);
frame.title = frame.header:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.title:SetPoint("CENTER", 0, 0);
frame.title:SetText(L["FRAME_TITLE"]);
frame.header:SetHeight(frame.title:GetHeight() + 6);

frame.closeButton = CreateFrame("Button", nil, frame.header);
frame.closeButton:SetWidth(12);
frame.closeButton:SetHeight(12);
frame.closeButton:SetPoint("RIGHT", -5, 0);
frame.closeButton:SetNormalTexture([[Interface\AddOns\XpCounter\iclose]]);
frame.closeButton:SetHighlightTexture([[Interface\AddOns\XpCounter\iclose]]);
frame.closeButton:GetNormalTexture():SetAlpha(0.66);

---------------------------------------------------------------------
-- CONTENT
local content = CreateFrame("Frame", nil, frame);
content:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"});
content:SetBackdropColor(0,0,0,0.5);
content:SetPoint("TOPLEFT", 0, -frame.header:GetHeight());
content:SetPoint("BOTTOMRIGHT", 0, 0);

frame.duration = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.duration:SetPoint("TOPLEFT", frame.header, "BOTTOMLEFT", 5, -2);
frame.duration:SetText(L["FRAME_DURATION"]);

frame.gained = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.gained:SetPoint("TOPLEFT", frame.duration, "BOTTOMLEFT", 0, 0);
frame.gained:SetText(L["FRAME_GAINED"]);

frame.perhour = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.perhour:SetPoint("TOPLEFT", frame.gained, "BOTTOMLEFT", 0, 0);
frame.perhour:SetText(L["FRAME_PERHOUR"]);

frame.ttlu = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.ttlu:SetPoint("TOPLEFT", frame.perhour, "BOTTOMLEFT", 0, 0);
frame.ttlu:SetText(L["FRAME_TTLU"]);

frame.repstlu = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.repstlu:SetPoint("TOPLEFT", frame.ttlu, "BOTTOMLEFT", 0, 0);
frame.repstlu:SetText(L["FRAME_REPSTLU"]);

frame.durationVal = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.durationVal:SetPoint("TOPRIGHT", frame.header, "BOTTOMRIGHT", -5, -2);
frame.durationVal:SetText("0");

frame.gainedVal = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.gainedVal:SetPoint("TOPRIGHT", frame.durationVal, "BOTTOMRIGHT", 0, 0);
frame.gainedVal:SetText("0");

frame.perhourVal = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.perhourVal:SetPoint("TOPRIGHT", frame.gainedVal, "BOTTOMRIGHT", 0, 0);
frame.perhourVal:SetText("0");

frame.ttluVal = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.ttluVal:SetPoint("TOPRIGHT", frame.perhourVal, "BOTTOMRIGHT", 0, 0);
frame.ttluVal:SetText("0");

frame.repstluVal = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
frame.repstluVal:SetPoint("TOPRIGHT", frame.ttluVal, "BOTTOMRIGHT", 0, 0);
frame.repstluVal:SetText("0");

-- Adjust height to fit content
content:SetHeight(4 + frame.duration:GetHeight()*5);
frame:SetHeight(content:GetHeight() + frame.header:GetHeight());