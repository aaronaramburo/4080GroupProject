local Item = {}
Item.__index = Item

function Item.new(name, category, qty, price)
    local self = setmetatable({}, Item)
    self.name = name
    self.category = category
    self.qty = qty or 0
    self.price = price or 0.0
    return self
end

function Item:add(n)
    self.qty = self.qty + n
end

function Item:remove(n)
    if n > self.qty then
        error("\nThere's not enough stock for " .. self.name)
    end
    self.qty = self.qty - n
end

r