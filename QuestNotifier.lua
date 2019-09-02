local format = string.format
local GetContainerItemID = GetContainerItemID
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemLink = GetContainerItemLink
local PlaySound = PlaySound
local print = print
local RaidNotice_AddMessage = RaidNotice_AddMessage
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local RaidBossEmoteFrame = RaidBossEmoteFrame

local questItemIDs = {
	[1307] = 123, -- Gold Pickup Schedule
	[1357] = 136, -- Captain Sander's Treasure Map
	[1962] = 178, -- Glowing Shadowhide Pendant
	[1972] = 184, -- Westfall Deed
	[2794] = 337, -- An Old History Book
	[2839] = 361, -- A Letter to Yvette
	[2874] = 373, -- An Unsent Letter
	[3317] = 460, -- A Talking Head
	[3668] = 522, -- Assassin's Contract
	[3706] = 551, -- Ensorcelled Parchment
	[3985] = 8552, -- Monogrammed Sash
	[4056] = 624, -- Cortello's Riddle
	[4098] = 594, -- Carefully Folded Note
	[4433] = 637, -- Waterlogged Envelope
	[4613] = 708, -- Corroded Black Box
	[4614] = 635, -- Pendant of Myzrael
	[4851] = 781, -- Dirt-stained Map
	[4854] = 770, -- Demon Scarred Cloak
	[4881] = 830, -- Aged Envelope
	[4903] = 832, -- Eye of Burning Shadow
	[4926] = 819, -- Chen's Empty Keg
	[5099] = 883, -- Hoof of Lakota'mani
	[5102] = 884, -- Owatanka's Tailspike
	[5103] = 885, -- Washte Pawne's Feather
	[5138] = 897, -- Harvester's Head
	[5179] = 927, -- Moss-twined Heart
	[5352] = 968, -- Book: The Powers Below
	[5791] = 1100, -- Henrig Lonebrow's Journal
	[5877] = 1148, -- Cracked Silithid Carapace
	[6172] = 1423, -- Lost Supplies
	[6196] = 1392, -- Noboru's Cudgel
	[6497] = 1, -- Simple Parchment
	[6766] = 1480, -- Flayed Demon Skin (old2)
	[6775] = 1642, -- Tome of Divinity
	[6776] = 1649, -- Tome of Valor
	[6916] = 1646, -- Tome of Divinity
	[7666] = 2198, -- Shattered Necklace
	[8524] = 654, -- Model 4711-FTZ Power Source
	[8623] = 351, -- OOX-17/TN Distress Beacon
	[8704] = 485, -- OOX-09/HL Distress Beacon
	[8705] = 2766, -- OOX-22/FE Distress Beacon
	[9250] = 2876, -- Ship Schedule
	[9254] = 2882, -- Cuergo's Treasure Map
	[9326] = 2945, -- Grime-Encrusted Ring
	[9370] = 2978, -- Gordunni Scroll
	[10000] = 3181, -- Margol's Horn
	[10441] = 6981, -- Glowing Shard
	[10454] = 3373, -- Essence of Eranikus
	[10590] = 3482, -- Pocked Black Box
	[10621] = 3513, -- Runed Scroll
	[11116] = 3884, -- A Mangled Journal
	[11463] = 4281, -- Undelivered Parcel
	[11668] = 939, -- Flute of Xavaric
	[11818] = 4451, -- Grimesilt Outhouse Key
	[12558] = 4882, -- Blue-feathered Necklace
	[12563] = 4903, -- Warlord Goretooth's Command
	[12564] = 4881, -- Assassination Note
	[12771] = 5083, -- Empty Firewater Flask
	[12780] = 5089, -- General Drakkisath's Command
	[12842] = 5123, -- Crudely-written Log
	[13140] = 5202, -- Blood Red Key
	[13250] = 5262, -- Head of Balnazzar
	[13920] = 5582, -- Healthy Dragon Scale
	[14646] = 5805, -- Northshire Gift Voucher
	[14647] = 5841, -- Coldridge Valley Gift Voucher
	[14648] = 5842, -- Shadowglen Gift Voucher
	[14649] = 5843, -- Valley of Trials Gift Voucher
	[14650] = 5844, -- Camp Narache Gift Voucher
	[14651] = 5847, -- Deathknell Gift Voucher
	[16303] = 23, -- Ursangous's Paw
	[16304] = 24, -- Shadumbra's Head
	[16305] = 2, -- Sharptalon's Claw
	[16408] = 1918, -- Befouled Water Globe
	[16782] = 6922, -- Strange Water Globe
	[16790] = 6564, -- Damp Note
	[17008] = 6522, -- Small Scroll
	[17115] = 6661, -- Squirrel Token
	[17116] = 6662, -- Squirrel Token
	[17126] = 6681, -- Elegant Letter
	[17409] = 1155, -- Encrusted Crystal Fragment
	[18359] = 7501, -- The Light and How to Swing It
	[18401] = 7507, -- Foror's Compendium of Dragon Slaying
	[18422] = 7490, -- Head of Onyxia
	[18423] = 7495, -- Head of Onyxia
	[18628] = 7604, -- Thorium Brotherhood Contract
	[18706] = 7810, -- Arena Master
	[18950] = 7704, -- Chambermaid Pillaclencher's Pillow
	[18969] = 7735, -- Pristine Yeti Hide
	[18972] = 7738, -- Perfect Yeti Hide
	[18987] = 7761, -- Blackhand's Command
	[19002] = 7783, -- Head of Nefarian
	[19003] = 7781, -- Head of Nefarian
	[19016] = 7785, -- Vessel of Rebirth
	[19228] = 7907, -- Beasts Deck
	[19257] = 7928, -- Warlords Deck
	[19267] = 7929, -- Elementals Deck
	[19277] = 7927, -- Portals Deck
	[19423] = 7937, -- Sayge's Fortune #23
	[19424] = 7938, -- Sayge's Fortune #24
	[19443] = 7944, -- Sayge's Fortune #25
	[19452] = 7945, -- Sayge's Fortune #27
	[19802] = 8183, -- Heart of Hakkar
	[20310] = 1480, -- Flayed Demon Skin
	[20460] = 8308, -- Brann Bronzebeard's Lost Letter
	[20461] = 8308, -- Brann Bronzebeard's Lost Letter
	[20644] = 8446, -- Nightmare Engulfed Object
	[20741] = 8470, -- Deadwood Ritual Totem
	[20742] = 8471, -- Winterfall Ritual Totem
	[20806] = 8496, -- Logistics Task Briefing X
	[20807] = 8497, -- Logistics Task Briefing I
	[20939] = 8540, -- Logistics Task Briefing II
	[20940] = 8541, -- Logistics Task Briefing III
	[20941] = 8501, -- Combat Task Briefing XII
	[20942] = 8502, -- Combat Task Briefing III
	[20943] = 8498, -- Tactical Task Briefing X
	[20944] = 8740, -- Tactical Task Briefing IX
	[20945] = 8537, -- Tactical Task Briefing II
	[20946] = 8536, -- Tactical Task Briefing III
	[20947] = 8535, -- Tactical Task Briefing IV
	[20948] = 8538, -- Tactical Task Briefing V
	[21165] = 8534, -- Tactical Task Briefing VI
	[21166] = 8738, -- Tactical Task Briefing VII
	[21167] = 8739, -- Tactical Task Briefing VIII
	[21220] = 8791, -- Head of Ossirian the Unscarred
	[21221] = 8801, -- Eye of C'Thun
	[21230] = 8784, -- Ancient Qiraji Artifact
	[21245] = 8737, -- Tactical Task Briefing I
	[21246] = 8770, -- Combat Task Briefing I
	[21247] = 8771, -- Combat Task Briefing II
	[21248] = 8773, -- Combat Task Briefing IV
	[21249] = 8539, -- Combat Task Briefing V
	[21250] = 8772, -- Combat Task Briefing VI
	[21251] = 8687, -- Combat Task Briefing VII
	[21252] = 8774, -- Combat Task Briefing VIII
	[21253] = 8775, -- Combat Task Briefing IX
	[21255] = 8776, -- Combat Task Briefing X
	[21256] = 8777, -- Combat Task Briefing XI
	[21257] = 8778, -- Logistics Task Briefing IV
	[21258] = 8785, -- Logistics Task Briefing IV
	[21259] = 8779, -- Logistics Task Briefing V
	[21260] = 8781, -- Logistics Task Briefing VI
	[21261] = 8786, -- Logistics Task Briefing VI
	[21262] = 8782, -- Logistics Task Briefing VIII
	[21263] = 8780, -- Logistics Task Briefing VII
	[21264] = 8787, -- Logistics Task Briefing VII
	[21265] = 8783, -- Logistics Task Briefing IX
	[21378] = 8804, -- Logistics Task Briefing I
	[21379] = 8805, -- Logistics Task Briefing II
	[21380] = 8806, -- Logistics Task Briefing III
	[21381] = 8809, -- Logistics Task Briefing IX
	[21382] = 8807, -- Logistics Task Briefing V
	[21384] = 8808, -- Logistics Task Briefing VIII
	[21385] = 8810, -- Logistics Task Briefing X
	[21514] = 8829, -- Logistics Task Briefing XI
	[21749] = 8770, -- Combat Task Briefing I
	[21750] = 8771, -- Combat Task Briefing II
	[21751] = 8536, -- Tactical Task Briefing III
	[22520] = 9120, -- The Phylactery of Kel'Thuzad
	[22723] = 9247, -- A Letter from the Keeper of the Rolls
	[22970] = 9301, -- A Bloodstained Envelope
	[22972] = 9299, -- A Careworn Note
	[22973] = 9302, -- A Crumpled Missive
	[22974] = 9300, -- A Ragged Page
	[22975] = 9304, -- A Smudged Document
	[22977] = 9295, -- A Torn Letter
	[23179] = 9324, -- Flame of Orgrimmar
	[23180] = 9325, -- Flame of Thunder Bluff
	[23181] = 9326, -- Flame of the Undercity
}

local questCache = {}
local activeQuests = {}

local function processBagSlot(bagID, slotID)
	local itemID = GetContainerItemID(bagID, slotID)
	if not itemID then
		return
	end

	local questID = questItemIDs[itemID]
	if not questID then
		return
	end

	if activeQuests[questID] or questCache[questID] then
		return
	end

	local itemLink = GetContainerItemLink(bagID, slotID)
	local itemName = itemLink:match("|H.*|h%[(.*)%]|h")
	if not itemLink or itemName == "" then
		return
	end

	print(format("%s |cffffff00begins a [Quest]!", itemLink))
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

local function updateActiveQuests()
	wipe(activeQuests)

	local numEntries = GetNumQuestLogEntries()
	for i=1, numEntries, 1 do
		local _, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(i)
		if not isHeader and questID then
			activeQuests[questID] = true
		end
	end
end
updateActiveQuests()

local frame = CreateFrame("Frame", "QuestNotifier")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:SetScript("OnEvent", function(_, event)
	if event == "BAG_UPDATE" or event == "UNIT_INVENTORY_CHANGED" then
		processBags()
	end
	if event == "QUEST_LOG_UPDATE" then
		updateActiveQuests()
	end
end)
