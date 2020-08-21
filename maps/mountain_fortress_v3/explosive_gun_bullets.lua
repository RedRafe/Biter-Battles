local radius = 3
local random = math.random
local floor = math.floor
local sqrt = math.sqrt

local Public = {}

local function splash_damage(surface, position, final_damage_amount)
    local create = surface.create_entity
    local damage = random(floor(final_damage_amount * 3), floor(final_damage_amount * 4))
    for _, e in pairs(
        surface.find_entities_filtered(
            {area = {{position.x - radius, position.y - radius}, {position.x + radius, position.y + radius}}}
        )
    ) do
        if e.valid and e.health then
            local distance_from_center = sqrt((e.position.x - position.x) ^ 2 + (e.position.y - position.y) ^ 2)
            if distance_from_center <= radius then
                local damage_distance_modifier = 1 - distance_from_center / radius
                if damage > 0 then
                    if random(1, 3) == 1 then
                        create({name = 'explosion', position = e.position})
                    end
                    e.damage(damage * damage_distance_modifier, 'player', 'explosion')
                end
            end
        end
    end
end

function Public.explosive_bullets(event)
    if random(1, 3) ~= 1 then
        return false
    end
    local entity = event.entity
    if not entity or not entity.valid then
        return
    end

    if event.damage_type.name ~= 'physical' then
        return false
    end
    local player = event.cause
    if not player or not player.valid or player.name ~= 'character' then
        return
    end

    if player.shooting_state.state == defines.shooting.not_shooting then
        return false
    end
    local selected_weapon = player.get_inventory(defines.inventory.character_guns)[player.selected_gun_index]
    if selected_weapon and selected_weapon.name ~= 'submachine-gun' and selected_weapon.name ~= 'pistol' then
        return false
    end

    local surface = player.surface
    local create = surface.create_entity

    create({name = 'explosion', position = entity.position})

    splash_damage(surface, entity.position, event.final_damage_amount)
end

return Public
