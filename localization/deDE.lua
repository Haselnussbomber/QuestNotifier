local addonName, addon = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale(addonName, "deDE")
if not L then return end

L["%s |cffffff00begins a |Hquest:%s:%s|h[Quest]|h!|r"] = "%s |cffffff00vergibt eine |Hquest:%s:%s|h[Quest]|h!|r"
L["%s begins a quest!"] = "%s vergibt eine Quest!"
