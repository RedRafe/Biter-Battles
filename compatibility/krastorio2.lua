local Color = require 'utils.color_presets'
local Event = require 'utils.event'
local Global = require 'utils.global'

local data = {
  stuck_players = {}
}

Global.register(data, function(tbl) data = tbl end)

local function enabled()
  return script.active_mods['Krastorio2'] ~= nil
end

-- ====== TABLES ======
local K2 = {}

K2.tables = function(tbl)
  if not enabled() then return end
  -- tbl.base_turret_attack_modifiers['kr-laser-artillery-turret'] = 0.0
  -- tbl.base_turret_attack_modifiers['kr-railgun-turret'] = 0.0
  -- tbl.base_turret_attack_modifiers['kr-rocket-turret'] = 0.0

  -- tbl.upgrade_modifiers['kr-laser-artillery-turret'] = 0.0
  -- tbl.upgrade_modifiers['kr-railgun-turret'] = 0.0
  -- tbl.upgrade_modifiers['kr-rocket-turret'] = 0.0

  tbl.food_names['basic-tech-card'] = true
  tbl.food_names['matter-tech-card'] = true
  tbl.food_names['advanced-tech-card'] = true
  tbl.food_names['singularity-tech-card'] = true

  tbl.food_values['basic-tech-card']         = { value = 0.00010, name = 'basic science',       color = '210, 180, 140' }
  tbl.food_values['automation-science-pack'] = { value = 0.00036, name = 'automation science',  color = '255,  50,  50' }
  tbl.food_values['logistic-science-pack']   = { value = 0.00062, name = 'logistic science',    color = ' 50, 255,  50' }
  tbl.food_values['military-science-pack']   = { value = 0.00080, name = 'military science',    color = '105, 105, 105' }
  tbl.food_values['chemical-science-pack']   = { value = 0.00290, name = 'chemical science',    color = '100, 200, 255' }
  tbl.food_values['production-science-pack'] = { value = 0.00930, name = 'production science',  color = '150,  25, 255' }
  tbl.food_values['utility-science-pack']    = { value = 0.00887, name = 'utility science',     color = '210, 210,  60' }
  tbl.food_values['space-science-pack']      = { value = 0.20039, name = 'space science',       color = '255, 255, 255' }
  tbl.food_values['matter-tech-card']        = { value = 0.16484, name = 'matter science',      color = '  8, 143, 143' }
  tbl.food_values['advanced-tech-card']      = { value = 0.31274, name = 'advanced science',    color = '240, 230, 140' }
  tbl.food_values['singularity-tech-card']   = { value = 3.69475, name = 'singularity science', color = '255,  20, 147' }

  tbl.food_synonyms['basic'] = 'basic-tech-card'
  tbl.food_synonyms['basic-tech-card'] = 'basic-tech-card'

  tbl.food_synonyms['matter'] = 'matter-tech-card'
  tbl.food_synonyms['matter-tech-card'] = 'matter-tech-card'

  tbl.food_synonyms['advanced'] = 'advanced-tech-card'
  tbl.food_synonyms['advanced-tech-card'] = 'advanced-tech-card'

  tbl.food_synonyms['singularity'] = 'singularity-tech-card'
  tbl.food_synonyms['singularity-tech-card'] = 'singularity-tech-card'

  for k, v in pairs(tbl.food_values) do
    tbl.gui_foods[k] = math.floor(v.value * 10000) .. ' Mutagen strength'
  end

  tbl.food_long_and_short = {
    [1]  = { short_name = 'basic',       long_name = 'basic-tech-card' },
    [2]  = { short_name = 'automation',  long_name = 'automation-science-pack' },
    [3]  = { short_name = 'logistic',    long_name = 'logistic-science-pack' },
    [4]  = { short_name = 'military',    long_name = 'military-science-pack' },
    [5]  = { short_name = 'chemical',    long_name = 'chemical-science-pack' },
    [6]  = { short_name = 'production',  long_name = 'production-science-pack' },
    [7]  = { short_name = 'utility',     long_name = 'utility-science-pack' },
    [8]  = { short_name = 'space',       long_name = 'space-science-pack' },
    [9]  = { short_name = 'matter',      long_name = 'matter-tech-card' },
    [10] = { short_name = 'advanced',    long_name = 'advanced-tech-card' },
    [11] = { short_name = 'singularity', long_name = 'singularity-tech-card' },
  }

  tbl.food_long_to_short = {
    ['basic-tech-card']         = { indexScience =  1, short_name = 'basic' },
    ['automation-science-pack'] = { indexScience =  2, short_name = 'automation' },
    ['logistic-science-pack']   = { indexScience =  3, short_name = 'logistic' },
    ['military-science-pack']   = { indexScience =  4, short_name = 'military' },
    ['chemical-science-pack']   = { indexScience =  5, short_name = 'chemical' },
    ['production-science-pack'] = { indexScience =  6, short_name = 'production' },
    ['utility-science-pack']    = { indexScience =  7, short_name = 'utility' },
    ['space-science-pack']      = { indexScience =  8, short_name = 'space' },
    ['matter-tech-card']        = { indexScience =  9, short_name = 'matter' },
    ['advanced-tech-card']      = { indexScience = 10, short_name = 'advanced' },
    ['singularity-tech-card']   = { indexScience = 11, short_name = 'singularity' },
  }

  tbl.food_value_table_version = {
    tbl.food_values['basic-tech-card'].value,
    tbl.food_values['automation-science-pack'].value,
    tbl.food_values['logistic-science-pack'].value,
    tbl.food_values['military-science-pack'].value,
    tbl.food_values['chemical-science-pack'].value,
    tbl.food_values['production-science-pack'].value,
    tbl.food_values['utility-science-pack'].value,
    tbl.food_values['space-science-pack'].value,
    tbl.food_values['matter-tech-card'].value,
    tbl.food_values['advanced-tech-card'].value,
    tbl.food_values['singularity-tech-card'].value,
  }
end

K2.feed_values_tab = {
  raw_costs = function(tbl)
    if not enabled() then return end
    tbl['biomass']         = { cost = 30, crafting_time = 1,   icon = '[item=biomass]' }
    tbl['mineral-water']   = { cost =  4, crafting_time = 0.1, icon = '[fluid=mineral-water]' }
    tbl['raw-imersite']    = { cost = 12, crafting_time = 1,   icon = '[item=raw-imersite]' }
    tbl['raw-rare-metals'] = { cost = 15, crafting_time = 4,   icon = '[entity=rare-metals]' }
  end,
  raw_cost_display_order = function(tbl)
    if not enabled() then return end
    for i, _ in pairs(tbl) do
      tbl[i] = nil
    end
    for _, v in pairs({
      'iron-ore',
      'copper-ore',
      'stone',
      'coal',
      'raw-rare-metals',
      'uranium-ore',
      'raw-imersite',
      'crude-oil',
      'mineral-water',
      'biomass'
    }) do
      table.insert(tbl, v)
    end
  end,
  recipe_productivity = function(tbl)
    if not enabled() then return end
    tbl['ai-core']               = 1.08
    tbl['energy-control-unit']   = 1.08
    tbl['matter-stabilizer']     = 1.08
    tbl['space-science-pack']    = 1.32
    tbl['matter-tech-card']      = 1.32
    tbl['advanced-tech-card']    = 1.32
    tbl['singularity-tech-card'] = 1.32
  end,
  simple_recipes = function(tbl)
    if not enabled() then return end
    tbl['space-research-data'] = {
      ingredients = {{ name = 'rocket-part', amount = 100 }, { name = 'satellite', amount = 1 }},
      products = {{ name = 'space-research-data', amount = 1000 }},
      energy = 14.833 + 19.367 + 6.133, -- Time to launch rocket
    }
    tbl['lithium'] = {
      ingredients = {{ name = 'lithium-chloride', amount = 5 }, { name = 'water', amount = 50 }},
      products = {{ name = 'lithium', amount = 1 } },
      energy = 25
    }
    tbl['chlorine'] = {
      ingredients = {{ name = 'sand', amount = 10 }, { name = 'water', amount = 40 }},
      products = {{ name = 'chlorine', amount = 20 }},
      energy = 3
    }
    tbl['imersite-powder'] = {
      ingredients = {{ name = 'raw-imersite', amount = 3 }},
      products = {{ name = 'imersite-powder', amount = 3 }},
      energy = 3
    }
    tbl['charged-matter-stabilizer'] = {
      ingredients = {{ name = 'matter-stabilizer', amount = 1 }},
      products = {{ name = 'charged-matter-stabilizer' }, { name = 'coal', amount = 1 }},
      energy = 2
    }
    tbl['space-science-pack'] = nil
  end,
  cache = function(tbl)
    if not enabled() then return end
    tbl['wood'] = {
      raw_ingredients = { ['water'] = 5, ['coal'] = 0.3 },
      intermediates_union = {},
      total_crafting_time = 60 / 40 + 5 / 1200
    }
  end,
}

K2.generate_creep = function(surface, tiles)
  if not enabled() then return end
  for _, tile in pairs(tiles) do
    tile.name = 'kr-creep'
  end
  surface.set_tiles(tiles)
end

K2.map_gen_settings = function(mgs)
  if not enabled() then return end
  mgs.autoplace_controls['stone']         = { frequency = 6.4, size = 0.385, richness = 0.25 }
  mgs.autoplace_controls['uranium-ore']   = { frequency = 2.6, size = 1.000, richness = 1.00 }
  mgs.autoplace_controls['crude-oil']     = { frequency = 8.0, size = 1.600, richness = 0.50 }
  mgs.autoplace_controls['imersite']      = { frequency = 2.2, size = 1.000, richness = 0.75 }
  mgs.autoplace_controls['rare-metals']   = { frequency = 6.0, size = 1.000, richness = 1.00 }
  mgs.autoplace_controls['mineral-water'] = { frequency = 4.0, size = 1.400, richness = 0.75 }
end

-- ====== EVENTS ======
local K2_TURRET        = 'kr-laser-artillery-turret'
local K2_TRANSCEIVER   = 'kr-intergalactic-transceiver'
local TURRET_RADIUS    = 224
local TICK_INTERVAL    = 645 + 60 -- ~12s, cutscene duration from K2
local RESPAWN_COOLDOWN = 60 * 10  -- ~10s, must be less than TICK_INTERVAL

-- Disable K2 own win condition
Event.on_init(function()
  if not enabled() then return end
  if remote.interfaces[K2_TRANSCEIVER] and remote.interfaces[K2_TRANSCEIVER].set_no_victory then
    remote.call(K2_TRANSCEIVER, 'set_no_victory', true)
  end
end)

-- Prevents players from building K2 Laser Turrets in range of the other team or in range of biter nests
local function on_built(event)
  if not enabled() then return end

  local entity = event.created_entity
  if not (entity and entity.valid) then
    return
  end

  local name = entity.name
  local ghost = false
  if entity.name == 'entity-ghost' then
    name = entity.ghost_name
    ghost = true
  end

  if name ~= K2_TURRET then
    return
  end

  local msg
  local surface = entity.surface
  local position = entity.position

  if math.abs(position.y) < TURRET_RADIUS - 16 then
    msg = 'Cannot build [entity=' .. K2_TURRET .. '] too close to the river!'
  elseif surface.count_entities_filtered{ position = position, radius = TURRET_RADIUS, name = { 'biter-spawner', 'spitter-spawner' }, limit = 1 } > 0 then
    msg = 'Cannot build [entity=' .. K2_TURRET .. '] too close to enemy nests!'
  end

  if not msg then
    return
  end

  local player = game.get_player(event.player_index or 'none')
  if player and player.valid then
    player.play_sound{ path = 'utility/cannot_build', volume_modifier = 1 }
    player.create_local_flying_text{ text = msg, create_at_cursor = true, color = Color.fail }
  end
  entity.destroy()
  if not ghost then
    surface.spill_item_stack(position, { name = name, count = 1 }, true, nil, false)
  end
end

Event.add(defines.events.on_built_entity, on_built)
Event.add(defines.events.on_robot_built_entity, on_built)

-- Prevents players from being stuck in 'ghost' mode if killed during the intergalactic explosion
-- (a K2 bug: https://github.com/raiguard/Krastorio2/blob/2e9c62c3452796834a329021f7203107d6f60bf4/scripts/intergalactic-transceiver.lua#L266)
local function validate_players()
  for _, p in pairs(game.connected_players) do
    if p.controller_type == defines.controllers.ghost then
      if not data.stuck_players[p.index] then
        data.stuck_players[p.index] = true
        p.print('You have been queued for respawn', Color.cyan)
        for _, ally in pairs(p.force.connected_players) do
          if ally.admin and ally.index ~= p.index then
            ally.print(p.name .. ' has been queued for respawn', Color.cyan)
          end
        end
      else
        p.ticks_to_respawn = RESPAWN_COOLDOWN
        data.stuck_players[p.index] = nil
      end
    end
  end
end

Event.on_nth_tick(TICK_INTERVAL, validate_players)

return K2
