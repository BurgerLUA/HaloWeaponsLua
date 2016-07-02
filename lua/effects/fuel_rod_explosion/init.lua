
function EFFECT:Init(data)

	self.Position = data:GetOrigin()
	
	local dlight = DynamicLight()
	dlight.Pos = self.Position + Vector(0,0,16)
	dlight.Size = math.Rand(900,925)
	dlight.DieTime = CurTime() + math.Rand(6.26,6.32)
	dlight.r = 33
	dlight.g =255
	dlight.b = 0
	dlight.Brightness = math.Rand(3.4,6.6)
	dlight.Decay = 1000

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end