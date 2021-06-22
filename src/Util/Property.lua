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

function Property.new(value: any)
    return setmetatable({
        _value = value,
        Changed = Signal.new()
    }, Property)
end

function Property:Get()
    return self._value
end

function Property:Set(value)
    if self._value == value then return end

    self._value = value
    return self.Changed:Fire(value)
end

function Property:Destroy()
    self.Changed:Destroy()
    setmetatable(self, nil)
end

return Property
