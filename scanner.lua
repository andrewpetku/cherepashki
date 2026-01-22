-- ===== Monitor setup =====
local monitor = peripheral.find("monitor")
if monitor then
  monitor.setTextScale(0.5)   -- подбери: 0.5 / 1 / 2
  monitor.clear()
  monitor.setCursorPos(1, 1)
end

local function log(...)
  -- вывод в терминал
  print(...)

  -- вывод на монитор
  if monitor then
    local text = table.concat({...}, " ")
    monitor.write(text)
    local x, y = monitor.getCursorPos()
    monitor.setCursorPos(1, y + 1)
  end
end

-- ===== Scanner logic =====
local sides = {
  "front",
  "back",
  "left",
  "right",
  "top",
  "bottom"
}

log("=== Inventory scan started ===")

for _, side in ipairs(sides) do
  if not peripheral.isPresent(side) then
    log("")
    log("Side:", side, "- nothing connected")
  else
    local types = peripheral.getType(side)
    if type(types) == "table" then
      types = table.concat(types, ", ")
    end

    local p = peripheral.wrap(side)
    local name = peripheral.getName(p)

    log("")
    log("Side:", side)
    log("Peripheral type:", types)
    log("Peripheral name:", name)

    if peripheral.hasType(side, "inventory") then
      local size = p.size()
      log("Slots:", size)

      for slot = 1, size do
        local item = p.getItemDetail(slot)
        if item then
          log(
            " Slot", slot,
            "|", item.name,
            "| count:", item.count
          )
        else
          log(" Slot", slot, "| empty")
        end
      end
    else
      log("Not an inventory")
    end
  end
end

log("")
log("=== Scan finished ===")
