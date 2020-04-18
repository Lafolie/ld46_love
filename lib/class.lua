--[[
	Copyright (c) 2017 Dale James

	Class Object
	Allows usage of OOP patterns. Supports singular inheritance.

	Tables initialised in class definitions and not in function scope are 'static' (shared by instances).
	For safety, confine non-function member declarations to function scope (e.g. in init() )

	This implementation allocates function pointers to each child class, rather than using indirect lookups.
	In this way, memory usage is traded off for overhead costs while also freeing up the '__index' metaevent.

	To access the parent class use _parent

	Usage:
		MyClass = class { myproperty = 10 }
		MyChildClass = class MyClass { myOtherProperty = true }
		bool = MyChildClass:is(MyClass)

	Todo:
		Metaevent support

]]



--forward declarations
local clone, class

--metamethod support
local metaMethods =
{
	"__index", "__newindex", "__call",
	"__mode", "__metatable",
	"__tostring", "__concat",
	"__pairs", "__ipairs",
	"__add", "__unm", "__sub", "__mul", "__div", "__mod", "__pow",
	"__eq", "__lt", "__le" 
}
local metaCache = {} --cached metatables

--shallow property cloning function
clone = function(object, outResult)
	outResult = outResult or {}

	--clone local properties
	for k, v in pairs(object) do
		if not outResult[k] then outResult[k] = v end
	end

	--clone parent props
	if object._parent then clone(object._parent, outResult) end

	return outResult
end

--metatable for class-derived objects
local classMeta = 
{
	--instantiate an object from this class
	__call = function(t, ...)
		local obj = clone(t)

		--check for metamethods (false = has no meta)
		local mt = metaCache[t]
		if mt then
			setmetatable(obj, mt)
		elseif mt == nil then
			mt = {}
			local usemt = false

			for _, meta in ipairs(metaMethods) do
				if obj[meta] then
					mt[meta] = obj[meta]
					obj[meta] = nil
					usemt = true
				end
			end
			if usemt then
				metaCache[t] = mt
				setmetatable(obj, mt)
			else
				metaCache[t] = false
			end
		end

		--run constructor
		obj:init(...)
		obj._parent = t
		return obj
	end
}

class = setmetatable(
{
	--class constructor (may be omitted in definitions)
	init = function(self) end,

	--class type reflection
	is = function(self, other)
		return self._parent == other or (self._parent and self._parent:is(other))
	end
}, 
{
	__call = function(t, tbl)
		--check whether a parent was passed (new class definitions should not manually specify _parent!)
		if tbl._parent then
			return function(newtbl)
				newtbl._parent = tbl
				local newtbl = clone(newtbl._parent, newtbl)
				return setmetatable(newtbl, classMeta)
			end
		else
			--if not, the tbl passed was a new base class
			tbl = clone(class, tbl)
			tbl._parent = class
			return setmetatable(tbl, classMeta)
		end
	end
})

return class