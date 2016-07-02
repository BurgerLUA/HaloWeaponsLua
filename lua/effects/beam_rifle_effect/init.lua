
function EFFECT:Init(data)

	self.Position = data:GetOrigin()
	
	local dlight = DynamicLight()
	dlight.Pos = self.Position + Vector(0,0,0)
	dlight.Size = math.Rand(300,325)
	dlight.DieTime = CurTime() + math.Rand(0.26,0.32)
	dlight.r = 220
	dlight.g = 0
	dlight.b = 255
	dlight.Brightness = math.Rand(2.4,2.6)
	dlight.Decay = 1000

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end