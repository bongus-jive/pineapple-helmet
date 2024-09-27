function ageItem(item, aging)
  local params = item.parameters

  if params.timeToRot then
    params.timeToRot = params.timeToRot - aging

    if params.timeToRot <= 0 then
      local config = root.itemConfig(item).config
      return {
        name = config.rottedItem or root.assetJson("/items/rotting.config:rottedItem"),
        count = item.count
      }
    end
  end

  return item
end

function build(_, config, params)
  if not params.timeToRot then
    local rottingMultiplier = params.rottingMultiplier or config.rottingMultiplier or 1.0
    params.timeToRot = root.assetJson("/items/rotting.config:baseTimeToRot") * rottingMultiplier
  end

  local description = params.baseDescription or config.description
  params.description = string.format("%s\n %s", description, getRotTimeDescription(params.timeToRot))

  return config, params
end

function getRotTimeDescription(rotTime)
  local descList = root.assetJson("/items/rotting.config:rotTimeDescriptions")

  for i, desc in ipairs(descList) do
    if rotTime <= desc[1] then return desc[2] end
  end
  return descList[#descList]
end
