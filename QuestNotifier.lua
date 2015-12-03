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

local itemCache = {} -- prevents from

function addon:OnEnable()
	self:RegisterEvent("BAG_UPDATE", "ITEMS_UPDATED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "ITEMS_UPDATED")
end

local function processBagSlot(bagid, slotid)
	local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagid, slotid)

	if isActive or not questId then
		return
	end

	local itemId = GetContainerItemID(bagid, slotid)

	if not itemId or itemCache[itemId] then
		return
	end

	local itemName, itemLink, _, itemLevel = GetItemInfo(itemId)

	print(format(L["%s |cffffff00begins a |Hquest:%s:%s|h[Quest]|h!|r"], itemLink, questId, itemLevel));
	RaidNotice_AddMessage(RaidBossEmoteFrame, format(L["%s begins a quest!"], itemLink), ChatTypeInfo["SYSTEM"], 3)
	PlaySound("AlarmClockWarning1")

	itemCache[itemId] = true
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
