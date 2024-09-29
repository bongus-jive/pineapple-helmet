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
