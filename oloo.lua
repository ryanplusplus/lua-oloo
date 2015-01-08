local Object = {}

function Object:create(proto)
  return setmetatable({}, { __index = proto or self })
end

function Object:isPrototypeOf(o)
  local proto = nil

  repeat
    proto = Object:getPrototypeOf(proto or o)
    if proto == self then return true end
  until proto == nil

  return false
end

function Object:getPrototypeOf(o)
  return (getmetatable(o) or {}).__index
end


local Foo = Object:create()

function Foo:foo(who)
  self.me = who
  return self
end

function Foo:identify()
  return 'I am ' .. self.me
end


local Bar = Object:create(Foo)

function Bar:bar(who)
  return self:foo('Bar:' .. who)
end

function Bar:speak()
  print('Hello, ' .. self:identify() .. '.')
end


local b1 = Object:create(Bar):bar('b1')
local b2 = Object:create(Bar):bar('b2')

b1:speak()
b2:speak()

print(Bar:isPrototypeOf(b1))
print(Bar:isPrototypeOf(b2))
print(Foo:isPrototypeOf(b1))
print(Foo:isPrototypeOf(b2))
print(Foo:isPrototypeOf(Bar))
print(Object:getPrototypeOf(b1) == Bar)
print(Object:getPrototypeOf(b2) == Bar)
print(Object:getPrototypeOf(Bar) == Foo)
