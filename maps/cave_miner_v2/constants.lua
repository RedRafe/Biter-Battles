local Public = {}

Public.starting_items = {
	["pistol"] = 1,
	["firearm-magazine"] = 8,
	["explosives"] = 16,
	["raw-fish"] = 8,	
}

Public.reveal_chain_brush_sizes = {
	["unit"] = 7,
	["unit-spawner"] = 15,
	["turret"] = 9,
}

Public.spawn_market_items = {
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'rail', count = 4}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'rail-signal', count = 2}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'rail-chain-signal', count = 2}},
	{price = {{"raw-fish", 10}}, offer = {type = 'give-item', item = 'train-stop'}},
	{price = {{"raw-fish", 94}}, offer = {type = 'give-item', item = 'locomotive'}},
	{price = {{"raw-fish", 35}}, offer = {type = 'give-item', item = 'cargo-wagon'}},
	{price = {{"raw-fish", 1}}, offer = {type = 'give-item', item = 'red-wire', count = 1}},
	{price = {{"raw-fish", 1}}, offer = {type = 'give-item', item = 'green-wire', count = 1}},
	{price = {{"raw-fish", 4}}, offer = {type = 'give-item', item = 'decider-combinator'}},
	{price = {{"raw-fish", 4}}, offer = {type = 'give-item', item = 'arithmetic-combinator'}},
	{price = {{"raw-fish", 2}}, offer = {type = 'give-item', item = 'constant-combinator'}},
	{price = {{"raw-fish", 4}}, offer = {type = 'give-item', item = 'programmable-speaker'}},
	{price = {{"raw-fish", 2}}, offer = {type = 'give-item', item = 'small-lamp'}},
	{price = {{"raw-fish", 2}}, offer = {type = 'give-item', item = 'firearm-magazine'}},
	{price = {{"raw-fish", 4}}, offer = {type = 'give-item', item = 'piercing-rounds-magazine'}},
	{price = {{"raw-fish", 3}}, offer = {type = 'give-item', item = 'grenade'}},
	{price = {{"raw-fish", 2}}, offer = {type = 'give-item', item = 'land-mine'}},
	{price = {{"raw-fish", 1}}, offer = {type = 'give-item', item = 'explosives', count = 2}},	
	{price = {{"raw-fish", 40}}, offer = {type = 'give-item', item = 'cliff-explosives'}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'wood', count = 25}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'iron-ore', count = 25}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'copper-ore', count = 25}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'stone', count = 25}},
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'coal', count = 25}},	
	{price = {{"raw-fish", 5}}, offer = {type = 'give-item', item = 'uranium-ore', count = 20}},
	{price = {{'wood', 25}}, offer = {type = 'give-item', item = "raw-fish", count = 2}},	
	{price = {{'iron-ore', 25}}, offer = {type = 'give-item', item = "raw-fish", count = 2}},
	{price = {{'copper-ore', 25}}, offer = {type = 'give-item', item = "raw-fish", count = 2}},
	{price = {{'stone', 25}}, offer = {type = 'give-item', item = "raw-fish", count = 2}},
	{price = {{'coal', 25}}, offer = {type = 'give-item', item = "raw-fish", count = 2}},	
	{price = {{'uranium-ore', 20}}, offer = {type = 'give-item', item = "raw-fish", count = 2}}
}

Public.pickaxe_tiers = {
	"Wood",
	"Plastic",
	"Bone",
	"Alabaster",
	"Lead",
	"Zinc",	
	"Tin",
	"Salt",	
	"Bauxite",
	"Borax",
	"Bismuth",
	"Amber",
	"Galena",	
	"Calcite",
	"Aluminium",
	"Silver",
	"Gold",
	"Copper",
	"Marble",
	"Brass",
	"Flourite",
	"Platinum",
	"Nickel",	
	"Iron",	
	"Manganese",
	"Apatite",
	"Uraninite",
	"Turquoise",
	"Hematite",
	"Glass",
	"Magnetite",
	"Concrete",
	"Pyrite",
	"Steel",
	"Zircon",
	"Titanium",
	"Silicon",
	"Quartz",
	"Garnet",
	"Flint",
	"Tourmaline",
	"Beryl",
	"Topaz",
	"Chrysoberyl",
	"Chromium",
	"Tungsten",
	"Corundum",
	"Tungsten",
	"Diamond",	
	"Penumbrite",
	"Meteorite",
	"Crimtane",
	"Obsidian",
	"Demonite",
	"Mythril",
	"Adamantite",
	"Chlorophyte",
	"Densinium",
	"Luminite",
}

return Public