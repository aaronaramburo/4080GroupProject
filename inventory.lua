local Item = require "item"

local Inventory = {}
Inventory.__index = Inventory

function Inventory.new()
    return setmetatable({ items = {} }, Inventory)
end

function Inventory:add_item(name, category, qty, price)
    if self.items[name] then
        error("\nItem already exists: " .. name)
    end
    self.items[name] = Item.new(name, category, qty, price)
end

function Inventory:receive(name, qty)
    local item = self.items[name]
    if not item then error("\nUnknown item: " .. name) end
    item:add(qty)
end

function Inventory:sell(name, qty)
    local item = self.items[name]
    if not item then error("\nUnknown item: " .. name) end
    item:remove(qty)
end

function Inventory:list_all()
    for name, item in pairs(self.items) do
        print(string.format("\n%-15s %-10s %5d  $%.2f",
            name, item.category, item.qty, item.price))
    end
end

function Inventory:low_stock(threshold)
    for name, item in pairs(self.items) do
        if item.qty < threshold then
            print("\nLOW STOCK:", name, "Quantity =", item.qty)
        end
    end
end

r