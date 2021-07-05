-- Property
-- Theo Docking
-- June 22nd 2021

--[[

	Property = RemoteProperty.new(value: any)

	remoteProperty:Get(): any
	remoteProperty:Set(value: any): void
	remoteProperty:Destroy(): void

	remoteProperty.Changed(newValue: any): Connection
--]]

local Signal = require(script.Parent.Signal)

local Property = {}
Property.__index = Property

function Property.new(...)
    return setmetatable({
        _value = table.pack(...),
        Changed = Signal.new()
    }, Property)
end

function Property:Get()
    return table.unpack(self._value)
end

function Property:Set(...)
    local args = table.pack(...)
    if self._value == args then return end

    self._value = args
    return self.Changed:Fire(...)
end

function Property:Destroy()
    self.Changed:Destroy()
    setmetatable(self, nil)
end

return Property
