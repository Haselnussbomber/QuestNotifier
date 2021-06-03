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
	[4056] = 624, -- Cortello's Riddle
	[4098] = 594, -- Carefully Folded Note
	[4433] = 637, -- Waterlogged Envelope
	[4613] = 708, -- Corroded Black Box
	[4851] = 781, -- Dirt-stained Map
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
	[10589] = 3374, -- Oathstone of Ysera's Dragonflight
	[10590] = 3482, -- Pocked Black Box
	[11116] = 3884, -- A Mangled Journal
	[11446] = 4264, -- A Crumpled Up Note
	[11463] = 4281, -- Undelivered Parcel
	[11668] = 939, -- Flute of Xavaric
	[11818] = 4451, -- Grimesilt Outhouse Key
	[12558] = 4882, -- Blue-feathered Necklace
	[12563] = 4903, -- Warlord Goretooth's Command
	[12564] = 4881, -- Assassination Note
	[12771] = 5083, -- Empty Firewater Flask
	[12780] = 5089, -- General Drakkisath's Command
	[12842] = 5123, -- Crudely-written Log
	[13250] = 5262, -- Head of Balnazzar
	[13920] = 5582, -- Healthy Dragon Scale
	[14646] = 5805, -- Goldshire Gift Voucher
	[14647] = 5841, -- Kharanos Gift Voucher
	[14648] = 5842, -- Dolanaar Gift Voucher
	[14649] = 5843, -- Razor Hill Gift Voucher
	[14650] = 5844, -- Bloodhoof Village Gift Voucher
	[14651] = 5847, -- Brill Gift Voucher
	[16303] = 23, -- Ursangous's Paw
	[16304] = 24, -- Shadumbra's Head
	[16305] = 2, -- Sharptalon's Claw
	[16408] = 1918, -- Befouled Water Globe
	[16782] = 6922, -- Strange Water Globe
	[17008] = 6522, -- Small Scroll
	[17115] = 6661, -- Squirrel Token
	[17116] = 6662, -- Squirrel Token
	[17126] = 6681, -- Elegant Letter
	[17409] = 1155, -- Encrusted Crystal Fragment
	[18356] = 7498, -- Garona: A Study on Stealth and Treachery
	[18357] = 7499, -- Codex of Defense
	[18358] = 7500, -- The Arcanist's Cookbook
	[18359] = 7501, -- The Light and How to Swing It
	[18360] = 7502, -- Harnessing Shadows
	[18361] = 7503, -- The Greatest Race of Hunters
	[18362] = 7504, -- Holy Bologna: What the Light Won't Tell You
	[18363] = 7505, -- Frost Shock and You
	[18364] = 7506, -- The Emerald Dream
	[18401] = 7507, -- Foror's Compendium of Dragon Slaying
	[18422] = 7490, -- Head of Onyxia
	[18423] = 7495, -- Head of Onyxia
	[18513] = 7508, -- A Dull and Flat Elven Blade
	[18628] = 7604, -- Thorium Brotherhood Contract
	[18703] = 7632, -- Ancient Petrified Leaf
	[18769] = 7649, -- Enchanted Thorium Platemail
	[18770] = 7650, -- Enchanted Thorium Platemail
	[18771] = 7651, -- Enchanted Thorium Platemail
	[18950] = 7704, -- Chambermaid Pillaclencher's Pillow
	[18969] = 7735, -- Pristine Yeti Hide
	[18972] = 7738, -- Perfect Yeti Hide
	[18987] = 7761, -- Blackhand's Command
	[19002] = 7783, -- Head of Nefarian
	[19003] = 7781, -- Head of Nefarian
	[19016] = 7785, -- Vessel of Rebirth
	[19018] = 7787, -- Dormant Wind Kissed Blade
	[19228] = 7907, -- Beasts Deck
	[19257] = 7928, -- Warlords Deck
	[19267] = 7929, -- Elementals Deck
	[19277] = 7927, -- Portals Deck
	[19423] = 7937, -- Sayge's Fortune #23
	[19443] = 7944, -- Sayge's Fortune #25
	[19452] = 7945, -- Sayge's Fortune #27
	[19802] = 8183, -- Heart of Hakkar
	[20310] = 1480, -- Flayed Demon Skin
	[20460] = 8308, -- Brann Bronzebeard's Lost Letter
	[20461] = 8308, -- Brann Bronzebeard's Lost Letter
	[20483] = 8338, -- Tainted Arcane Sliver
	[20644] = 8446, -- Nightmare Engulfed Object
	[20741] = 8470, -- Deadwood Ritual Totem
	[20742] = 8471, -- Winterfall Ritual Totem
	[20765] = 8482, -- Incriminating Documents
	[20798] = 8489, -- Intact Arcane Converter
	[20806] = 8496, -- Logistics Task Briefing X
	[20807] = 8497, -- Logistics Task Briefing I
	[20938] = 8547, -- Falconwing Square Gift Voucher
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
	[20949] = 8575, -- Magical Ledger
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
	[21776] = 8887, -- Captain Kelisendra's Lost Rutters
	[22520] = 9120, -- The Phylactery of Kel'Thuzad
	[22597] = 9175, -- The Lady's Necklace
	[22600] = 9178, -- Craftsman's Writ - Dense Weightstone
	[22601] = 9179, -- Craftsman's Writ - Imperial Plate Chest
	[22602] = 9181, -- Craftsman's Writ - Volcanic Hammer
	[22603] = 9182, -- Craftsman's Writ - Huge Thorium Battleaxe
	[22604] = 9183, -- Craftsman's Writ - Radiant Circlet
	[22605] = 9184, -- Craftsman's Writ - Wicked Leather Headband
	[22606] = 9185, -- Craftsman's Writ - Rugged Armor Kit
	[22607] = 9186, -- Craftsman's Writ - Wicked Leather Belt
	[22608] = 9187, -- Craftsman's Writ - Runic Leather Pants
	[22609] = 9188, -- Craftsman's Writ - Brightcloth Pants
	[22610] = 9190, -- Craftsman's Writ - Runecloth Boots
	[22611] = 9191, -- Craftsman's Writ - Runecloth Bag
	[22612] = 9194, -- Craftsman's Writ - Runecloth Robe
	[22613] = 9195, -- Craftsman's Writ - Goblin Sapper Charge
	[22614] = 9196, -- Craftsman's Writ - Thorium Grenade
	[22615] = 9197, -- Craftsman's Writ - Gnomish Battle Chicken
	[22616] = 9198, -- Craftsman's Writ - Thorium Tube
	[22617] = 9200, -- Craftsman's Writ - Major Mana Potion
	[22618] = 9202, -- Craftsman's Writ - Major Healing Potion
	[22620] = 9201, -- Craftsman's Writ - Greater Arcane Protection Potion
	[22621] = 9203, -- Craftsman's Writ - Flask of Petrification
	[22622] = 9204, -- Craftsman's Writ - Stonescale Eel
	[22623] = 9205, -- Craftsman's Writ - Plated Armorfish
	[22624] = 9206, -- Craftsman's Writ - Lightning Eel
	[22719] = 9233, -- Omarion's Handbook
	[22723] = 9247, -- A Letter from the Keeper of the Rolls
	[22727] = 9250, -- Frame of Atiesh
	[22888] = 9278, -- Azure Watch Gift Voucher
	[22970] = 9301, -- A Bloodstained Envelope
	[22972] = 9299, -- A Careworn Note
	[22973] = 9302, -- A Crumpled Missive
	[22974] = 9300, -- A Ragged Page
	[22975] = 9304, -- A Smudged Document
	[22977] = 9295, -- A Torn Letter
	[23179] = 9324, -- Flame of Orgrimmar
	[23180] = 9325, -- Flame of Thunder Bluff
	[23181] = 9326, -- Flame of the Undercity
	[23182] = 9330, -- Flame of Stormwind
	[23183] = 9331, -- Flame of Ironforge
	[23184] = 9332, -- Flame of Darnassus
	[23228] = 8474, -- Old Whitebark's Pendant
	[23249] = 9360, -- Amani Invasion Plans
	[23338] = 9373, -- Eroded Leather Case
	[23580] = 9418, -- Avruu's Orb
	[23678] = 9455, -- Faintly Glowing Crystal
	[23759] = 9514, -- Rune Covered Tablet
	[23777] = 9520, -- Diabolical Plans
	[23797] = 9535, -- Diabolical Plans
	[23837] = 9550, -- Weathered Treasure Map
	[23850] = 9564, -- Gurf's Dignity
	[23870] = 9576, -- Red Crystal Pendant
	[23890] = 9587, -- Ominous Letter
	[23892] = 9588, -- Ominous Letter
	[23900] = 9594, -- Tzerak's Armor Plate
	[23910] = 9616, -- Blood Elf Communication
	[24132] = 9672, -- A Letter from the Admiral
	[24228] = 9695, -- The Sun King's Command
	[24367] = 9764, -- Orders from Lady Vashj
	[24414] = 9798, -- Blood Elf Plans
	[24483] = 9827, -- Withered Basidium
	[24484] = 9828, -- Withered Basidium
	[24504] = 9861, -- Howling Wind
	[24558] = 9872, -- Murkblood Invasion Plans
	[24559] = 9871, -- Murkblood Invasion Plans
	[25459] = 9911, -- "Count" Ungula's Mandible
	[25705] = 9984, -- Luanga's Orders
	[25706] = 9985, -- Luanga's Orders
	[25752] = 10014, -- (Deprecated)Mana Bomb Schematics
	[25753] = 10015, -- (Deprecated)Mana Bomb Schematics
	[28113] = 10130, -- Warboss Nekrogg's Orders
	[28114] = 10152, -- Warboss Nekrogg's Orders
	[28552] = 10229, -- A Mysterious Tome
	[28598] = 10244, -- Fel Reaver Construction Manual
	[29233] = 10182, -- Dathric's Blade
	[29234] = 10305, -- Belmara's Tome
	[29235] = 10306, -- Luminrath's Mantle
	[29236] = 10307, -- Cohlien's Cap
	[29476] = 10134, -- Crimson Crystal Shard
	[29588] = 10395, -- Burning Legion Missive
	[29590] = 10393, -- Burning Legion Missive
	[29738] = 10413, -- Vial of Void Horror Ooze
	[30431] = 10524, -- Thunderlord Clan Artifact
	[30579] = 10623, -- Illidari-Bane Shard
	[30756] = 10621, -- Illidari-Bane Shard
	[31120] = 10719, -- Meeting Note
	[31239] = 10754, -- Primed Key Mold
	[31241] = 10755, -- Primed Key Mold
	[31345] = 10793, -- The Journal of Val'zareq
	[31363] = 10797, -- Gorgrom's Favor
	[31384] = 10810, -- Damaged Mask
	[31489] = 10825, -- Orb of the Grishna
	[31707] = 10880, -- Cabal Orders
	[31890] = 10938, -- Blessings Deck
	[31891] = 10939, -- Storms Deck
	[31907] = 10940, -- Furies Deck
	[31914] = 10941, -- Lunacy Deck
	[32385] = 11002, -- Magtheridon's Head
	[32386] = 11003, -- Magtheridon's Head
	[32405] = 11007, -- Verdant Sphere
	[32523] = 11021, -- Ishaal's Almanac
	[33102] = 11178, -- Blood of Zul'jin
	[33114] = 11185, -- Sealed Letter
	[33115] = 11186, -- Sealed Letter
	[33978] = 11400, -- "Honorary Brewer" Hand Stamp
	[34028] = 11419, -- "Honorary Brewer" Hand Stamp
	[34469] = 11531, -- Strange Engine Part
	[35568] = 11935, -- Flame of Silvermoon
	[35569] = 11933, -- Flame of the Exodar
	[35723] = 11972, -- Shards of Ahune
	[37571] = 12278, -- "Brew of the Month" Club Membership Form
	[37599] = 12306, -- "Brew of the Month" Club Membership Form
	[37736] = 12420, -- "Brew of the Month" Club Membership Form
	[38280] = 12491, -- Direbrew's Dire Brew
	[38281] = 12492, -- Direbrew's Dire Brew
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

	print(format("%s |cffffff00begins a Quest!", itemLink))
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
