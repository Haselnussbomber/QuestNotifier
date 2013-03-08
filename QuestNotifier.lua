local QuestNotifier = LibStub("AceAddon-3.0"):NewAddon("QuestNotifier", "AceEvent-3.0")

local alerted = {} -- session cache

function QuestNotifier:OnEnable()
	self:RegisterEvent("BAG_UPDATE", "ITEMS_UPDATED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "ITEMS_UPDATED")
end

function QuestNotifier:ITEMS_UPDATED(...)
	for bagid = 0, 4 do
		local size = GetContainerNumSlots(bagid)
		if size then
			for slotid = 1, size do
				local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagid, slotid)
				if questId and not isActive then
					local itemId = GetContainerItemID(bagid, slotid)
					if itemId and not alerted[itemId] then
						local itemName, itemLink, _, itemLevel, _, _, _, _, _, _, _ = GetItemInfo(itemId)
						DEFAULT_CHAT_FRAME:AddMessage(itemLink.." \124cffffff00vergibt eine \124Hquest:"..questId..":"..itemLevel.."\124h[Quest]\124h!\124r");
						RaidNotice_AddMessage(RaidBossEmoteFrame, itemLink.." vergibt eine Quest!", ChatTypeInfo["SYSTEM"], 3)
						PlaySound("AlarmClockWarning1")
						alerted[itemId] = true
						return
					end
				end
			end
		end
	end
end
