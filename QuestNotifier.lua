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

local function processBagSlot(bagID, slotID)
	local _, questID, isActive = GetContainerItemQuestInfo(bagID, slotID)

	if isActive or not questID or questCache[questID] then
		return
	end

	local itemID = GetContainerItemID(bagID, slotID)
	if not itemID then
		return
	end

	local _, itemLink, _, itemLevel = GetItemInfo(itemID)

	print(format("%s |cffffff00begins a |Hquest:%s:%s|h[Quest]|h!|r", itemLink, questID, itemLevel))
	RaidNotice_AddMessage(RaidBossEmoteFrame, format("%s begins a quest!", itemLink), ChatTypeInfo["SYSTEM"], 3)
	PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_1)

	questCache[questID] = true
end

local function processBags()
	for bagID = 0, NUM_BAG_SLOTS do
		local size = GetContainerNumSlots(bagID)
		if size then
			for slotID = 1, size do
				processBagSlot(bagID, slotID)
			end
		end
	end
end

local frame = CreateFrame("Frame", "QuestNotifier")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
frame:SetScript("OnEvent", function(_, event)
	if event == "BAG_UPDATE" or event == "UNIT_INVENTORY_CHANGED" then
		processBags()
	end
end)
