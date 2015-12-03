local addonName, addon = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale(addonName, "enUS", true)
if not L then return end

L["%s |cffffff00begins a |Hquest:%s:%s|h[Quest]|h!|r"] = true
L["%s begins a quest!"] = true
