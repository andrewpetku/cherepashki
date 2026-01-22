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
  if peripheral.isPresent(side) then
    local pType = peripheral.getType(side)
    local pName = peripheral.getName(side)

    print("\nSide:", side)
    print("Peripheral type:", pType)
    print("Peripheral name:", pName)

    if peripheral.hasType(side, "inventory") then
      local inv = peripheral.wrap(side)
      local size = inv.size()

      print("Slots:", size)

      for slot = 1, size do
        local item = inv.getItemDetail(slot)
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
  else
    print("\nSide:", side, "- nothing connected")
  end
end

print("\n=== Scan finished ===")