--[[
  Production values are for 1k science packs/min. Miners are excluded from entity counts but figure in power consumption

  entities      number                 # of entities (silo = 25, everything else ~1 with exceptions)
  power         number                 MW of power used by the factor
  resources     table<string, number>  amount for each resource type (item or fluid)
  technology    table<string, number>  amount of sci packs for each type
]]

return {
  ['default'] = {
    --[[
      Factory Planner exchange string
      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
    ]]
    ['automation-science-pack'] = {entities =  205, power =   28, resources = {['copper-ore']=1000, ['coal']=108, ['iron-ore']=2000}, technology = {total=0, energy=0}},
    ['logistic-science-pack']   =	{entities =  385, power =   52, resources = {['copper-ore']=1500, ['coal']=252, ['iron-ore']=5500}, technology = {total=75, energy=22500, ['automation-science-pack']=75}},
    ['military-science-pack']   =	{entities =  714, power =  115, resources = {['copper-ore']=2500, ['coal']=5612, ['iron-ore']=7000, ['stone']=10000}, technology = {total=245, energy=97500, ['automation-science-pack']=195, ['logistic-science-pack']=50}},
    ['chemical-science-pack']   = {entities = 1597, power =  224, resources = {['copper-ore']=7500, ['coal']=2382, ['iron-ore']=12000, ['crude-oil']=38461}, technology = {total=1995, energy=1276500, ['automation-science-pack']=1080, ['logistic-science-pack']=915}},
    ['production-science-pack'] =	{entities = 4120, power =  484, resources = {['copper-ore']=17746, ['coal']=6975, ['iron-ore']=48611, ['stone']=10802, ['crude-oil']=63311}, technology = {total=4065, energy=2824500, ['automation-science-pack']=1950, ['logistic-science-pack']=1765, ['chemical-science-pack']=350}},
    ['utility-science-pack']    = {entities = 4201, power =  605, resources = {['copper-ore']=44312, ['coal']=6569, ['iron-ore']=29762, ['crude-oil']=96696}, technology = {total=5295, energy=3661500, ['automation-science-pack']=2255, ['logistic-science-pack']=2090, ['chemical-science-pack']=950}},
    ['space-science-pack']      = {entities = 7587, power = 1140, resources = {['copper-ore']=72946, ['coal']=11638, ['iron-ore']=42052, ['crude-oil']=224619}, technology = {total=17865, energy=13354500, ['automation-science-pack']=5750, ['logistic-science-pack']=5565, ['chemical-science-pack']=3650, ['production-science-pack']=1600, ['utility-science-pack']=1300}},
  },
  ['krastorio2'] = {
    --[[
      Factory Planner exchange string
      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
    ]]
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
}

-- mutagen(x) = ( x.power / basic.power ) * log10(x.entities)
mutagen_values = {
  ['basic-tech-card']         =    1.851,
  ['automation-science-pack'] =    2.589,
  ['logistic-science-pack']   =    3.844,
  ['military-science-pack']   =    3.948,
  ['chemical-science-pack']   =   10.266,
  ['production-science-pack'] =   69.737,
  ['utility-science-pack']    =   77.685,
  ['space-science-pack']      =  128.252,
  ['matter-tech-card']        =  125.676,
  ['advanced-tech-card']      =  153.705,
  ['singularity-tech-card']   = 1777.065,
}

-- the fuck are these, IDK. ChatGPT computed it in a strange way
--[[
mutagenValues = {
  ['basic-tech-card']         =   0.561,
  ['automation-science-pack'] =   1.158,
  ['logistic-science-pack']   =   1.914,
  ['military-science-pack']   =   1.961,
  ['chemical-science-pack']   =   4.921,
  ['production-science-pack'] =  20.208,
  ['utility-science-pack']    =  23.534,
  ['space-science-pack']      =  31.083,
  ['matter-tech-card']        =  22.203,
  ['advanced-tech-card']      =  25.142,
  ['singularity-tech-card']   = 144.153,
}
]]

-- weighted raw resources for each science
raw_resources = {
  ['basic-tech-card']         =   10.47,
  ['automation-science-pack'] =   37.68,
  ['logistic-science-pack']   =   63.29,
  ['military-science-pack']   =   37.85,
  ['chemical-science-pack']   =  137.56,
  ['production-science-pack'] =  281.43,
  ['utility-science-pack']    =  438.34,
  ['space-science-pack']      =  685.57,
  ['matter-tech-card']        =  342.26,
  ['advanced-tech-card']      =  432.83,
  ['singularity-tech-card']   = 5342.45,
}

-- sum of each # sci packs * its raw resource value
total_science_resources = {
  ['basic-tech-card']         = 0,
  ['automation-science-pack'] = 704.7,
  ['logistic-science-pack']   = 4509.15,
  ['military-science-pack']   = 13516.1,
  ['chemical-science-pack']   = 18451.19,
  ['production-science-pack'] = 82935.94,
  ['utility-science-pack']    = 94285.76,
  ['space-science-pack']      = 360664.12,
  ['matter-tech-card']        = 135009.59,
  ['advanced-tech-card']      = 208534.21,
  ['singularity-tech-card']   = 2431271.99,
}

-- sqrt(value)/10
total_science_resources = {
  ['basic-tech-card'] = 0,
  ['automation-science-pack'] = 2.651,
  ['logistic-science-pack'] = 6.713,
  ['military-science-pack'] = 11.619,
  ['chemical-science-pack'] = 13.568,
  ['production-science-pack'] = 28.795,
  ['utility-science-pack'] = 30.695,
  ['space-science-pack'] = 60.055,
  ['matter-tech-card'] = 36.738,
  ['advanced-tech-card'] = 45.640,
  ['singularity-tech-card'] = 156.066,
}

-- sqrt(value/10)
total_science_resources= {
  ['basic-tech-card'] = 0,
  ['automation-science-pack'] = 5.267,
  ['logistic-science-pack'] = 21.308,
  ['military-science-pack'] = 41.202,
  ['chemical-science-pack'] = 60.697,
  ['production-science-pack'] = 91.058,
  ['utility-science-pack'] = 97.114,
  ['space-science-pack'] = 179.565,
  ['matter-tech-card'] = 367.382,
  ['advanced-tech-card'] = 643.277,
  ['singularity-tech-card'] = 1504.348,
}

-- mutagen + sqrt(total_science_resources)/10
combined_values = {
  ['basic-tech-card']         = 1.851,
  ['automation-science-pack'] = 5.240,
  ['logistic-science-pack']   = 10.557,
  ['military-science-pack']   = 15.567,
  ['chemical-science-pack']   = 23.834,
  ['production-science-pack'] = 98.532,
  ['utility-science-pack']    = 108.380,
  ['space-science-pack']      = 188.307,
  ['matter-tech-card']        = 162.414,
  ['advanced-tech-card']      = 199.345,
  ['singularity-tech-card']   = 1933.131,
}

-- % of tech progress to unlock the science
technology_progress = {
  ['basic-tech-card']         = 0.0,
  ['automation-science-pack'] = 0.249,
  ['logistic-science-pack']   = 0.370,
  ['military-science-pack']   = 3.900,
  ['chemical-science-pack']   = 4.460,
  ['production-science-pack'] = 13.925,
  ['utility-science-pack']    = 14.770,
  ['space-science-pack']      = 66.728,
  ['matter-tech-card']        = 66.633,
  ['advanced-tech-card']      = 76.418,
  ['singularity-tech-card']   = 100.0,
}

-- combinaed_values + technology_progress
result_table = {
  ['basic-tech-card']         =    1.851,
  ['automation-science-pack'] =    5.489,
  ['logistic-science-pack']   =   10.927,
  ['military-science-pack']   =   19.467,
  ['chemical-science-pack']   =   28.294,
  ['production-science-pack'] =  112.457,
  ['utility-science-pack']    =  123.150,
  ['space-science-pack']      =  255.035,
  ['matter-tech-card']        =  229.047,
  ['advanced-tech-card']      =  275.763,
  ['singularity-tech-card']   = 2033.131,
}

-- transform in similar range to default
result_table = {
  ['basic-tech-card']         = 0.0002,
  ['automation-science-pack'] = 0.0005,
  ['logistic-science-pack']   = 0.0011,
  ['military-science-pack']   = 0.0020,
  ['chemical-science-pack']   = 0.0028,
  ['production-science-pack'] = 0.0112,
  ['utility-science-pack']    = 0.0123,
  ['space-science-pack']      = 0.0255,
  ['matter-tech-card']        = 0.0229,
  ['advanced-tech-card']      = 0.0276,
  ['singularity-tech-card']   = 0.2033,
}
