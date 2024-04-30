local spawners = { 'armoured-biter-spawner' }
local units = {
  'small-armoured-biter',
  'medium-armoured-biter',
  'big-armoured-biter',
  'behemoth-armoured-biter',
  'leviathan-armoured-biter',
}

local function enabled()
  return script.active_mods['ArmouredBiters'] ~= nil
end

-- ====== TABLES ======
local ArmouredBiters = {}

ArmouredBiters.enabled = enabled

ArmouredBiters.tables = function(tbl)
  if not enabled() then return end
  for _, s in pairs(spawners) do
    table.insert(tbl.spawners, s)
  end
  for _, u in pairs(units) do
    table.insert(tbl.units, u)
  end

  tbl.threat_values['small-armoured-biter']     =   5
  tbl.threat_values['medium-armoured-biter']    =  12
  tbl.threat_values['big-armoured-biter']       =  27
  tbl.threat_values['behemoth-armoured-biter']  =  96
  tbl.threat_values['leviathan-armoured-biter'] = 346.5
  tbl.threat_values['armoured-biter-spawner']   =  32

  tbl.entity_score_values['small-armoured-biter']     =   20
  tbl.entity_score_values['medium-armoured-biter']    =   48
  tbl.entity_score_values['big-armoured-biter']       =  108
  tbl.entity_score_values['behemoth-armoured-biter']  =  384
  tbl.entity_score_values['leviathan-armoured-biter'] = 1386
  tbl.entity_score_values['armoured-biter-spawner']   =  128
end

ArmouredBiters.biter_building_inhabitants = function(tbl)
  if not enabled() then return end
  table.insert(tbl[2], {'small-armoured-biter', 3, 5})
  table.insert(tbl[5], {'medium-armoured-biter', 3, 5})
  table.insert(tbl[9], {'big-armoured-biter', 3, 5})
  table.insert(tbl[10], {'behemoth-armoured-biter', 1, 2})  
end

ArmouredBiters.get_biter_name = function(evo)
  if evo < 0.30 then return units[1] end
  if evo < 0.55 then return units[2] end
  if evo < 0.95 then return units[3] end
  if evo < 1.65 then return units[4] end
  return units[5]
end

return ArmouredBiters
