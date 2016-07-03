local addonName, addon = ...

LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local format = string.format
local GetContainerItemID = GetContainerItemID
local GetContainerItemQuestInfo = GetContainerItemQuestInfo
local GetContainerNumSlots = GetContainerNumSlots
local GetItemInfo = GetItemInfo
local PlaySound = PlaySound
local print = print
local RaidNotice_AddMessage = RaidNotice_AddMessage
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local RaidBossEmoteFrame = RaidBossEmoteFrame

--  serves as exclude list and prevents notifications from repeating
local questCache = {
	-- Darkmoon Faire
	[29443] = true, -- A Curious Crystal
	[29444] = true, -- An Exotic Egg
	[29445] = true, -- An Intriguing Grimoire
	[29446] = true, -- A Wondrous Weapon
	[29451] = true, -- The Master Strategist
	[29456] = true, -- A Captured Banner
	[29457] = true, -- The Enemy's Insignia
	[29458] = true, -- The Captured Journal
	[29464] = true, -- Tools of Divination

	-- Love is in the Air
	[14483] = true, [24745] = true, -- Faded Lovely Greeting Card

	-- WoD Garrison: Scouting Missives
	[38180] = true, [38193] = true, -- Missive: Assault on the Broken Precipice
	[38182] = true, [38196] = true, -- Missive: Assault on Darktide Roost
	[38179] = true, [38192] = true, -- Missive: Assault on the Everbloom Wilds
	[38178] = true, [38191] = true, -- Missive: Assault on the Iron Siegeworks
	[38184] = true, [38198] = true, -- Missive: Assault on Lost Veil Anzu
	[38177] = true, [38190] = true, -- Missive: Assault on Magnarok
	[38181] = true, [38195] = true, -- Missive: Assault on Mok'gol Watchpost
	[38185] = true, [38199] = true, -- Missive: Assault on Pillars of Fate
	[38187] = true, [38201] = true, -- Missive: Assault on Shattrath Harbor
	[38186] = true, [38200] = true, -- Missive: Assault on Skettis
	[38183] = true, [38197] = true, -- Missive: Assault on Socrethar's Rise
	[38176] = true, [38189] = true, -- Missive: Assault on Stonefury Cliffs
}

function addon:OnEnable()
	self:RegisterEvent("BAG_UPDATE", "ITEMS_UPDATED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "ITEMS_UPDATED")
end

local function processBagSlot(bagid, slotid)
	local _, questId, isActive = GetContainerItemQuestInfo(bagid, slotid)

	if isActive or not questId or questCache[questId] then
		return
	end

	local itemId = GetContainerItemID(bagid, slotid)

	if not itemId then
		return
	end

	local _, itemLink, _, itemLevel = GetItemInfo(itemId)

	print(format(L["%s |cffffff00begins a |Hquest:%s:%s|h[Quest]|h!|r"], itemLink, questId, itemLevel))
	RaidNotice_AddMessage(RaidBossEmoteFrame, format(L["%s begins a quest!"], itemLink), ChatTypeInfo["SYSTEM"], 3)
	PlaySound("AlarmClockWarning1")

	questCache[questId] = true
end

local function processBag(bagid)
	local size = GetContainerNumSlots(bagid)

	if not size then
		return
	end

	for slotid = 1, size do
		processBagSlot(bagid, slotid)
	end
end

function addon:ITEMS_UPDATED(...)
	for bagid = 0, NUM_BAG_SLOTS do
		processBag(bagid)
	end
end
