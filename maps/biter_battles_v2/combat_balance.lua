local Modifiers = require "maps.biter_battles_v2.tables".modifiers
local BASE = 0

local Public = {}

Public.init_force = function(force)
  for k, v in pairs(Modifiers['ammo-damage']) do
    force.set_ammo_damage_modifier(k, v.base or BASE)
  end
  for k, v in pairs(Modifiers['gun-speed']) do
    force.set_gun_speed_modifier(k, v.base or BASE)
  end
  for k, v in pairs(Modifiers['turret-attack']) do
    force.set_turret_attack_modifier(k, v.base or BASE)
  end
end

Public.override_force_modifiers = function(event)
  local tech = event.research
  local force = event.research.force
  for _, effect in pairs(tech.effects or {}) do
    local type = effect.type
    local name = effect.ammo_category or effect.turret_id
    if Modifiers[type] and Modifiers[type][name] and Modifiers[type][name].upgrade then
      global.combat_balance[force.name] = global.combat_balance[force.name] or {}
      local force_modifiers = global.combat_balance[force.name]
      force_modifiers[type] = force_modifiers[type] or {}
      force_modifiers[type][name] = force_modifiers[type][name] or Modifiers[type][name].base or BASE
      force_modifiers[type][name] = force_modifiers[type][name] + Modifiers[type][name].upgrade

      if type == 'ammo-damage' then
        force.set_ammo_damage_modifier(name, force_modifiers[type][name])
      elseif type == 'gun-speed' then
        force.set_gun_speed_modifier(name, force_modifiers[type][name])
      elseif type == 'turret-attack' then
        force.set_turret_attack_modifier(name, force_modifiers[type][name])
      end
    end
  end
end

return Public
