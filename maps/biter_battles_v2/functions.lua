local Tables = require "maps.biter_battles_v2.tables"
local bb_config = require "maps.biter_battles_v2.config"
local simplex_noise = require 'utils.simplex_noise'.d2
local string_sub = string.sub
local math_random = math.random
local math_round = math.round
local math_abs = math.abs
local math_min = math.min
local math_floor = math.floor
local string_find = string.find
local gui_style = require 'utils.utils'.gui_style

local no_turret_blacklist = {
	["ammo-turret"] = true,
	["artillery-turret"] = true,
	["electric-turret"] = true,
	["fluid-turret"] = true
}

local landfill_biters_vectors = {{0,0}, {1,0}, {0,1}, {-1,0}, {0,-1}}
local landfill_biters = {
	["big-biter"] = true,
	["big-spitter"] = true,
	["behemoth-biter"] = true,	
	["behemoth-spitter"] = true,
}

local spawn_positions = {}
local spawn_r = 7
local spawn_r_square = spawn_r ^ 2
for x = spawn_r * -1, spawn_r, 0.5 do
	for y = spawn_r * -1, spawn_r, 0.5 do
		if x ^ 2 + y ^ 2 < spawn_r_square then
			table.insert(spawn_positions, {x, y})
		end
	end
end
local size_of_spawn_positions = #spawn_positions

local Public = {}

---@param event EventData.on_player_mined_entity|EventData.on_pre_player_crafted_item|EventData.on_player_mined_item
function Public.maybe_set_game_start_tick(event)
	if global.bb_game_start_tick then return end
	if not event.player_index then return end
	local player = game.players[event.player_index]
	if player.force.name ~= "north" and player.force.name ~= "south" then return end
	global.bb_game_start_tick = game.ticks_played
end

function Public.biters_landfill(entity)
	if not landfill_biters[entity.name] then return end	
	local position = entity.position
	if math_abs(position.y) < 8 then return true end
	local surface = entity.surface
	for _, vector in pairs(landfill_biters_vectors) do
		local tile = surface.get_tile({position.x + vector[1], position.y + vector[2]})
		if tile.collides_with("resource-layer") then
			surface.set_tiles({{name = "landfill", position = tile.position}})
			local particle_pos = {tile.position.x + 0.5, tile.position.y + 0.5}
			for _ = 1, 50, 1 do
				surface.create_particle({
					name = "stone-particle",
					position = particle_pos,
					frame_speed = 0.1,
					vertical_speed = 0.12,
					height = 0.01,
					movement = {-0.05 + math_random(0, 100) * 0.001, -0.05 + math_random(0, 100) * 0.001}
				})
			end
		end
	end
	return true
end

function Public.init_player(player)
	if not player.connected then
		if player.force.index ~= 1 then
			player.force = game.forces.player
		end
		return
	end	
		
	if player.character and player.character.valid then
		player.character.destroy()
		player.set_controller({type = defines.controllers.god})
		player.create_character()	
	end
	player.clear_items_inside()
	player.spectator = true
	player.force = game.forces.spectator
	
	local surface = game.surfaces[global.bb_surface_name]
	local p = spawn_positions[math_random(1, size_of_spawn_positions)]
	if surface.is_chunk_generated({0,0}) then
		player.teleport(surface.find_non_colliding_position("character", p, 4, 0.5), surface)
	else
		player.teleport(p, surface)
	end
	if player.character and player.character.valid then player.character.destructible = false end
	game.permissions.get_group("spectator").add_player(player)
end

function Public.get_noise(name, pos)
	local seed = game.surfaces[global.bb_surface_name].map_gen_settings.seed
	local noise_seed_add = 25000
	if name == 1 then
		local noise = simplex_noise(pos.x * 0.0042, pos.y * 0.0042, seed)
		seed = seed + noise_seed_add
		noise = noise + simplex_noise(pos.x * 0.031, pos.y * 0.031, seed) * 0.08
		seed  = seed + noise_seed_add
		noise = noise + simplex_noise(pos.x * 0.1, pos.y * 0.1, seed) * 0.025
		return noise
	end

	if name == 2 then
		local noise = simplex_noise(pos.x * 0.011, pos.y * 0.011, seed)
		seed = seed + noise_seed_add
		noise = noise + simplex_noise(pos.x * 0.08, pos.y * 0.08, seed) * 0.2
		return noise
	end

	if name == 3 then
		local noise = simplex_noise(pos.x * 0.005, pos.y * 0.005, seed)
		noise = noise + simplex_noise(pos.x * 0.02, pos.y * 0.02, seed) * 0.3
		noise = noise + simplex_noise(pos.x * 0.15, pos.y * 0.15, seed) * 0.025
		return noise
	end
end

function Public.is_biter_area(position,noise_Enabled)
	local bitera_area_distance = bb_config.bitera_area_distance * -1
	local biter_area_angle = 0.45
	local a = bitera_area_distance - (math_abs(position.x) * biter_area_angle)
	if position.y - 70 > a then return false end
	if position.y + 70 < a then return true end	
	if noise_Enabled then
		if position.y + (Public.get_noise(3, position) * 64) > a then return false end
	else
		if position.y > a then return false end
	end
	return true
end

function Public.no_turret_creep(event)
	local entity = event.created_entity
	if not entity.valid then return end
	if not no_turret_blacklist[event.created_entity.type] then return end
	
	local posEntity = entity.position
	if posEntity.y > 0 then posEntity.y = (posEntity.y + 100) * -1 end
	if posEntity.y < 0 then posEntity.y = posEntity.y - 100 end
	if not Public.is_biter_area(posEntity,false) then
		return
	end
	
	local surface = event.created_entity.surface				
	local spawners = surface.find_entities_filtered({type = "unit-spawner", area = {{entity.position.x - 70, entity.position.y - 70}, {entity.position.x + 70, entity.position.y + 70}}})
	if #spawners == 0 then return end
	
	local allowed_to_build = true
	
	for _, e in pairs(spawners) do
		if (e.position.x - entity.position.x)^2 + (e.position.y - entity.position.y)^2 < 4096 then
			allowed_to_build = false
			break
		end			
	end
	
	if allowed_to_build then return end
	
	if event.player_index then
		game.players[event.player_index].insert({name = entity.name, count = 1})		
	else	
		local inventory = event.robot.get_inventory(defines.inventory.robot_cargo)
		inventory.insert({name = entity.name, count = 1})													
	end
	
	surface.create_entity({
		name = "flying-text",
		position = entity.position,
		text = "Turret too close to spawner!",
		color = {r=0.98, g=0.66, b=0.22}
	})
	
	entity.destroy()
end

function Public.no_landfill_by_untrusted_user(event, trusted_table)
	local entity = event.created_entity
	if not entity.valid or not event.player_index or entity.name ~= "tile-ghost" or entity.ghost_name ~= "landfill" then return end
	local player = game.players[event.player_index]
	if not trusted_table[player.name] then
		player.print('You have not grown accustomed to this technology yet.', {r = 0.22, g = 0.99, b = 0.99})
		entity.destroy()
		return
	end
end

--- Returns the number of ticks since the game started, or 0 if it has not started.
--- @return integer
function Public.get_ticks_since_game_start()
	local start_tick = global.bb_game_start_tick
	if not start_tick then return 0 end
	return game.ticks_played - start_tick
end

function Public.team_name(force_name)
	local name = global.tm_custom_name[force_name]
	if name == nil then
		if force_name == "north" then
			name = bb_config.north_side_team_name
		elseif force_name == "south" then
			name = bb_config.south_side_team_name
		end
	end
	return name or force_name
end

function Public.team_name_with_color(force_name)
	local name = Public.team_name(force_name)
	if force_name == "north" then
		return "[color=120, 120, 255]" .. name .. "[/color]"
	elseif force_name == "south" then
		return "[color=255, 65, 65]" .. name .. "[/color]"
	else
		return name
	end
end

function Public.print_message_to_players(forcePlayerList, playerNameSendingMessage, msgToPrint, colorChosen)
	for _, playerOfForce in pairs(forcePlayerList) do
		if playerOfForce.connected then
			if global.ignore_lists[playerOfForce.name] == nil or (global.ignore_lists[playerOfForce.name] and not global.ignore_lists[playerOfForce.name][playerNameSendingMessage]) then
				if colorChosen == nil then
					playerOfForce.print(msgToPrint)
				else
					playerOfForce.print(msgToPrint, colorChosen)
				end
			end
		end
	end
end

function Public.spy_fish(player, event)
	local button = event.button
	local shift = event.shift
	if not player.character then return end
	if event.control then return end
	local duration_per_unit = 2700
	local i2 = player.get_inventory(defines.inventory.character_main)
	if not i2 then return end
	local owned_fish = i2.get_item_count("raw-fish")
	local send_amount = 1
	if owned_fish == 0 then
		player.print("You have no fish in your inventory.",{ r=0.98, g=0.66, b=0.22})
	else
		if shift then
			if button == defines.mouse_button_type.left then
				send_amount = owned_fish
			elseif button == defines.mouse_button_type.right then
				send_amount = math_floor(owned_fish / 2)
			end
		else
			if button == defines.mouse_button_type.left then
				send_amount = 1
			elseif button == defines.mouse_button_type.right then
				send_amount = math_min(owned_fish, 5)
			end
		end

		local x = i2.remove({name="raw-fish", count=send_amount})
		if x == 0 then i2.remove({name="raw-fish", count=send_amount}) end
		local enemy_team = "south"
		if player.force.name == "south" then enemy_team = "north" end													 
		if global.spy_fish_timeout[player.force.name] - game.tick > 0 then 
			global.spy_fish_timeout[player.force.name] = global.spy_fish_timeout[player.force.name] + duration_per_unit * send_amount
			spy_time_seconds = math_floor((global.spy_fish_timeout[player.force.name] - game.tick) / 60)
			if spy_time_seconds > 60 then
				local minute_label = " minute and "
				if spy_time_seconds > 120 then
					minute_label = " minutes and "
				end
				player.print(math_floor(spy_time_seconds / 60) .. minute_label .. math_floor(spy_time_seconds % 60) .. " seconds of enemy vision left.", { r=0.98, g=0.66, b=0.22})
			else
				player.print(spy_time_seconds .. " seconds of enemy vision left.", { r=0.98, g=0.66, b=0.22})
			end
		else
			game.print(player.name .. " sent " .. send_amount .. " fish to spy on " .. enemy_team .. " team!", {r=0.98, g=0.66, b=0.22})
			global.spy_fish_timeout[player.force.name] = game.tick + duration_per_unit * send_amount
		end		
	end
end

function Public.create_map_intro_button(player)
	if player.gui.top["map_intro_button"] then return end
	local b = player.gui.top.add({type = "sprite-button", caption = "?", name = "map_intro_button", tooltip = "Map Info"})
	b.style.font_color = {r=0.5, g=0.3, b=0.99}
	b.style.font = "heading-1"
	gui_style(b, {width = 38, height = 38, padding = -2})
end

function Public.show_intro(player)
	if player.gui.center["map_intro_frame"] then player.gui.center["map_intro_frame"].destroy() end
	local frame = player.gui.center.add {type = "frame", name = "map_intro_frame", direction = "vertical"}
	local frame = frame.add {type = "frame"}
	local l = frame.add {type = "label", caption = {"biter_battles.map_info"}, name = "biter_battles_map_intro"}
	l.style.single_line = false
	l.style.font_color = {r=255, g=255, b=255}
end

function Public.map_intro_click(player, element)
	if element.name == "close_map_intro_frame" then player.gui.center["map_intro_frame"].destroy() return true end	
	if element.name == "biter_battles_map_intro" then player.gui.center["map_intro_frame"].destroy() return true end	
	if element.name == "map_intro_button" then
		if player.gui.center["map_intro_frame"] then
			player.gui.center["map_intro_frame"].destroy()
			return true
		else
			Public.show_intro(player)
			return true
		end
	end	
end

return Public
