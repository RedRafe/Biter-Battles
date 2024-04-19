local data = {
  ['basic-tech-card']         = {entities =   135, power =   19, resources = {['copper-ore']=1000, ['coal']=47}, technology = {total=0, energy=0}},
  ['automation-science-pack'] = {entities =   163, power =   27, resources = {['copper-ore']=1600, ['coal']=168, ['iron-ore']=2000}, technology = {total=70, energy=114000, ['basic-tech-card']=70}},
  ['logistic-science-pack']   =	{entities =   244, power =   42, resources = {['copper-ore']=2400, ['coal']=289, ['iron-ore']=3800}, technology = {total=290, energy=169500, ['basic-tech-card']=185, ['automation-science-pack']=105}},
  ['military-science-pack']   =	{entities =   254, power =   42, resources = {['copper-ore']=400, ['coal']=718, ['iron-ore']=1600, ['stone']=1067, ['crude-oil']=5128, ['biomass']=400}, technology = {total=2845, energy=1786500, ['basic-tech-card']=1310, ['automation-science-pack']=1120, ['logistic-science-pack']=415}},
  ['chemical-science-pack']   = {entities =   550, power =  104, resources = {['copper-ore']=6400, ['coal']=928, ['iron-ore']=3200, ['crude-oil']=20512}, technology = {total=3350, energy=2041500, ['basic-tech-card']=1465, ['automation-science-pack']=1295, ['logistic-science-pack']=590}},
  ['production-science-pack'] =	{entities =  2022, power =  540, resources = {['copper-ore']=10000, ['coal']=4441, ['iron-ore']=24769, ['stone']=9410, ['uranium-ore']=9325, ['crude-oil']=61828}, technology = {total=10590, energy=6379500, ['basic-tech-card']=2235, ['automation-science-pack']=3715, ['logistic-science-pack']=2990, ['chemical-science-pack']=1650}},
  ['utility-science-pack']    = {entities =  2475, power =  566, resources = {['copper-ore']=34691, ['coal']=6559, ['iron-ore']=16056, ['rare-metals']=2572, ['crude-oil']=86261}, technology = {total=10025, energy=6766500, ['basic-tech-card']=1740, ['automation-science-pack']=3520, ['logistic-science-pack']=2815, ['chemical-science-pack']=1950}},
  ['space-science-pack']      = {entities =  3263, power =  757, resources = {['copper-ore']=35215, ['coal']=7918, ['iron-ore']=19710, ['stone']=10887, ['crude-oil']=109353}, technology = {total=45470, energy=30567000, ['basic-tech-card']=3065, ['automation-science-pack']=12195, ['logistic-science-pack']=11460, ['chemical-science-pack']=9300, ['production-science-pack']=4950, ['utility-science-pack']=4500}},
  ['matter-tech-card']        = {entities =  1801, power =  574, resources = {['copper-ore']=15402, ['coal']=2357, ['iron-ore']=7315, ['stone']=2860, ['rare-metals']=4178, ['raw-imersite']=4459, ['crude-oil']=37475, ['mineral-water']=11147}, technology = {total=40390, energy=30522000, ['basic-tech-card']=2535, ['automation-science-pack']=10665, ['logistic-science-pack']=9940, ['chemical-science-pack']=8300, ['production-science-pack']=4700, ['utility-science-pack']=4250}},
  ['advanced-tech-card']      = {entities =  1996, power =  651, resources = {['copper-ore']=7562, ['coal']=2597, ['iron-ore']=11305, ['stone']=2759, ['rare-metals']=13793, ['raw-imersite']=10344, ['crude-oil']=30314, ['mineral-water']=15394}, technology = {total=44890, energy=35022000, ['basic-tech-card']=2535, ['automation-science-pack']=10665, ['logistic-science-pack']=9940, ['chemical-science-pack']=8300, ['production-science-pack']=6200, ['utility-science-pack']=5750, ['matter-tech-card']=1500}},
  ['singularity-tech-card']   = {entities = 23358, power = 7730, resources = {['copper-ore']=332197, ['coal']=80550, ['iron-ore']=131259, ['stone']=24306, ['rare-metals']=30544, ['raw-imersite']=54278, ['crude-oil']=1023305, ['mineral-water']=90867}, technology = {total=63195, energy=45822000, ['basic-tech-card']=3065, ['automation-science-pack']=12670, ['logistic-science-pack']=11935, ['chemical-science-pack']=9775, ['production-science-pack']=9800, ['utility-science-pack']=9350, ['space-science-pack']=1250, ['matter-tech-card']=4100, ['advanced-tech-card']=1250}},
}

local raw = {}
local tech = {}
local mutagen = {}
local weights = {
  ['copper-ore'] = 10,
  ['coal'] = 10,
  ['iron-ore'] = 10,
  ['stone'] = 10,
  ['rare-metals'] = 30,
  ['uranium-ore'] = 30,
  ['raw-imersite'] = 55,
  ['crude-oil'] = 2,
  ['mineral-water'] = 10,
  ['biomass'] = 60,
}

-- raw
for key, val in pairs(data) do
  local sum = 0
  for k, v in pairs(val.resources) do
    sum = sum + v * (weights[k] or 0)
  end
  raw[key] = sum / 1000
end

-- tech
for key, val in pairs(data) do
  local sum = 0
  for k, v in pairs(val.technology) do
    sum = sum + v * (raw[k] or 0)
  end
  tech[key] = sum
end

local function norm_100(tbl)
  local m = -1
  for _, v in pairs(tbl) do
    m = math.max(v, m)
  end
  for k, v in pairs(tbl) do
    tbl[k] = 100 * v / m
  end
end

local power = {}
local entities = {}
local time = {}

for k, v in pairs(data) do
  power[k] = v.power
  entities[k] = v.entities
  time[k] = v.technology.energy / (60 * 100)
end

norm_100(power)
norm_100(entities)
norm_100(time)
norm_100(tech)

local basic = data['basic-tech-card']
for k, v in pairs(data) do
  local power_ratio = power[k]
  local entity_ratio = entities[k]
  local time_ratio = time[k]
  local tech_ratio = tech[k]
  print(k..' | power: '..power_ratio..' | entity: '..entity_ratio..' | time: '..time_ratio..' | tech: '..tech_ratio)
  mutagen[k] = raw[k]/raw['basic-tech-card'] + (tech_ratio)^2 + (power_ratio^1.4 + entity_ratio^2.2) * ((time_ratio) / 100)^2
end

print('mutagen = {')
local norm = mutagen['basic-tech-card']
for k, v in pairs(mutagen) do
  mutagen[k] = v / norm
  print('  [\''..k..'\'] = '..mutagen[k]..',')
end
print('}')

print('efficiency = {')
for k, v in pairs(mutagen) do
  print('  [\''..k..'\'] = '..(v/raw[k]/ (mutagen['basic-tech-card']/raw['basic-tech-card']))..',')
end
print('}')

-- results
K2_mutagen = {
  ['basic-tech-card']         =     1.0,
  ['automation-science-pack'] =     3.598866322,
  ['logistic-science-pack']   =     6.198260734,
  ['military-science-pack']   =     6.039434379,
  ['chemical-science-pack']   =    14.150416548,
  ['production-science-pack'] =    92.991865977,
  ['utility-science-pack']    =    88.727046817,
  ['space-science-pack']      =  2003.949434656,
  ['matter-tech-card']        =  1648.435471349,
  ['advanced-tech-card']      =  3127.372589313,
  ['singularity-tech-card']   = 36947.530351076,
}
K2_resource_efficiency = {
  ['basic-tech-card']         =  1.0,
  ['automation-science-pack'] =  1.000003460466,
  ['logistic-science-pack']   =  1.000089226137,
  ['military-science-pack']   =  1.018144429622,
  ['chemical-science-pack']   =  1.012650790540,
  ['production-science-pack'] =  1.094444997880,
  ['utility-science-pack']    =  1.129117244737,
  ['space-science-pack']      = 21.946881694095,
  ['matter-tech-card']        = 20.636363444541,
  ['advanced-tech-card']      = 22.746376546786,
  ['singularity-tech-card']   = 30.848511506431,
}