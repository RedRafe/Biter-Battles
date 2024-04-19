local function trace_back(technology, cache, cost)
  if cache[technology.name] then
    return
  end

  local amount = technology.research_unit_count
  for _, i in pairs(technology.research_unit_ingredients) do
    cost[i.name] = (cost[i.name] or 0) + amount * (i.amount or 1)
    cost.__total = cost.__total + amount * (i.amount or 1)
  end
  cost.__energy = cost.__energy + technology.research_unit_energy * amount

  cache[technology.name] = true
  for _, pt in pairs(technology.prerequisites or {}) do
    trace_back(pt, cache, cost)
  end
end

commands.add_command(
  'packs_to_unlock',
  'Computes the amount of science packs required to research a given tech.',
  function(cmd)
    local player = game.player

    if not(player and player.valid) then
      return
      end
    if not player.admin then
      player.print('[ERROR] Command is admin-only. Please ask an admin.')
    end

    local tech = game.technology_prototypes[tostring(cmd.parameter)]
    if not tech then
      player.print('Invalid tech name: '..tostring(cmd.parameter)..' does not exist.')
    end

    local cost = {__energy = 0, __total = 0}
    local technologies = {}
    trace_back(tech, technologies, cost)

    log(serpent.block({info = 'Detailed decomposition for technology: '..tech.name, requirements = cost}))
    player.print('[color=blue]'..tech.name..'[/color] | [color=yellow]Time:[/color] '..cost.__energy..' | [color=green]Packs:[/color] '..cost.__total)
  end
)