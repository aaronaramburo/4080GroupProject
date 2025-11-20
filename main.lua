print("\nWelcome to our Inventory Management App!")

local Inventory = require "inventory"

local inv = Inventory.new()

--low-stock warning
local function low_stock_monitor(inv, threshold)
    while true do
        inv:low_stock(threshold)
        coroutine.yield()   -- resume from main
    end
end

local monitor = coroutine.create(low_stock_monitor)

local function safe_call(f, ...)
    local ok, err = pcall(f, ...)
    if not ok then
        print("\nError at:", err)
    end
end
--print menu and options
local function print_menu()
    print("\nInventory Menu\n")
    print("1: Add items")
    print("2: Sell items")
    print("3: List items")
    print("4: Run low-stock check")
    print("X: Exit")
    io.write("\nChoice: ")
end
--option logic
while true do
    print_menu()
    local choice = io.read("*l")
    if choice == "X" then
        break
    elseif choice == "1" then
        io.write("\nName: ");      local name = io.read("*l")
        io.write("\nCategory: ");  local cat  = io.read("*l")
        io.write("\nQuantity: ");  local qty  = tonumber(io.read("*l"))
        io.write("\nPrice: ");     local pr   = tonumber(io.read("*l"))
        safe_call(inv.add_item, inv, name, cat, qty, pr)
    elseif choice == "2" then
        io.write("\nName: ");  local name = io.read("*l")
        io.write("\nQuantity: ");   local qty  = tonumber(io.read("*l"))
        safe_call(inv.sell, inv, name, qty)
    elseif choice == "3" then
        inv:list_all()
    elseif choice == "4" then
        io.write("\nItem Threshold: "); local t = tonumber(io.read("*l"))
        coroutine.resume(monitor, inv, t)
    else
        print("\nInvalid choice.")
    end
end

print("\nGoodbye! :)\n")
