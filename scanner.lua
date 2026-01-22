local sides = {
  "front",
  "back",
  "left",
  "right",
  "top",
  "bottom"
}

print("=== Inventory scan started ===")

for _, side in ipairs(sides) do
  if not peripheral.isPresent(side) then
    print("\nSide:", side, "- nothing connected")
  else
    local types = peripheral.getType(side)
    if type(types) == "table" then
      types = table.concat(types, ", ")
    end

    local p = peripheral.wrap(side)
    local name = peripheral.getName(p)

    print("\nSide:", side)
    print("Peripheral type:", types)
    print("Peripheral name:", name)

    if peripheral.hasType(side, "inventory") then
      local size = p.size()
      print("Slots:", size)

      for slot = 1, size do
        local item = p.getItemDetail(slot)
        if item then
          print(
            " Slot", slot,
            "|", item.name,
            "| count:", item.count
          )
        else
          print(" Slot", slot, "| empty")
        end
      end
    else
      print("Not an inventory")
    end
  end
end

print("\n=== Scan finished ===")
