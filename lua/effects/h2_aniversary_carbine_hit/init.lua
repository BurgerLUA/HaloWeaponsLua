
function EFFECT:Init( data )
	
	local vOffset = data:GetOrigin()
		self.Origin = data:GetOrigin()
	self.DirVec = data:GetNormal()
	self.Scale = data:GetScale()
		self.Magnitude = data:GetMagnitude()
	self.Emitter = ParticleEmitter( self.Origin )

	local emitter = ParticleEmitter( vOffset )

				for i=1,5 do 
			local Flash = self.Emitter:Add( "effects/h2_carbine_muzzle_2", self.Origin )
			if (Flash) then
				Flash:SetVelocity( VectorRand()*50 )
				Flash:SetAirResistance( 20055 )
				Flash:SetDieTime( 1.532 )
				Flash:SetStartAlpha( 250 )
				Flash:SetEndAlpha( 0 )
				Flash:SetStartSize( 10 )
				Flash:SetEndSize( 10 )
				Flash:SetRoll( math.Rand(1,0) )
				Flash:SetGravity( Vector( math.Rand(-100, 100) * self.Scale, math.Rand(-100, 100) * self.Scale, math.Rand(0, -100) ) ) 	
				Flash:SetRollDelta( math.Rand(0,0) )
				Flash:SetColor( 255, 255, 0)	
			end
		end

					for i=1,5 do 
			local Flash = self.Emitter:Add( "effects/h2_carbine_hit", self.Origin )
			if (Flash) then
				Flash:SetVelocity( VectorRand()*50 )
				Flash:SetAirResistance( 20055 )
				Flash:SetDieTime( 10.532 )
				Flash:SetStartAlpha( 200 )
				Flash:SetEndAlpha( 0 )
				Flash:SetStartSize( 5 )
				Flash:SetEndSize( 5 )
				Flash:SetRoll( math.Rand(0,0) )
				Flash:SetGravity( Vector( math.Rand(-100, 100) * self.Scale, math.Rand(-100, 100) * self.Scale, math.Rand(0, -100) ) ) 	
				Flash:SetRollDelta( math.Rand(0,0) )
				Flash:SetColor( 100, 100, 100)	
			end
		end
		
				for i=1,5 do 
			local Flash = self.Emitter:Add( "effects/h2_carbine_hit_plasma", self.Origin )
			if (Flash) then
				Flash:SetVelocity( VectorRand()*50 )
				Flash:SetAirResistance( 20055 )
				Flash:SetDieTime( 3.532 )
				Flash:SetStartAlpha( 200 )
				Flash:SetEndAlpha( 0 )
				Flash:SetStartSize( 4 )
				Flash:SetEndSize( 4 )
				Flash:SetRoll( math.Rand(0,0) )
				Flash:SetGravity( Vector( math.Rand(-100, 100) * self.Scale, math.Rand(-100, 100) * self.Scale, math.Rand(0, -100) ) ) 	
				Flash:SetRollDelta( math.Rand(0,0) )
				Flash:SetColor( 255, 255, 255)	
			end
		end

		for i=1,2 do 
			local particle = emitter:Add( "effects/h2_carbine_muzzle_2", vOffset )

				particle:SetVelocity( 0 * data:GetNormal() )
				particle:SetAirResistance( 11110 )

				particle:SetDieTime( 0.50 )

				particle:SetStartAlpha( math.Rand(0, 55) )
				particle:SetEndAlpha( 0 )

				particle:SetStartSize( 5 * i )
				particle:SetEndSize( 5 * i )

				particle:SetRoll( math.Rand(0,0) )
				particle:SetRollDelta( math.Rand(1,0) )

				particle:SetColor( 127, 255, 0)	
				particle:SetGravity( Vector( math.Rand(-100, 100) * self.Scale, math.Rand(-100, 100) * self.Scale, math.Rand(0, -100) ) ) 		
		end
		
	
			local particle = emitter:Add( "effects/h2_carbine_muzzle_2", vOffset )

				particle:SetVelocity( 0 * data:GetNormal() + 20 * VectorRand() )
				particle:SetAirResistance( 200 )

				particle:SetDieTime( math.Rand(1, 1) )
				particle:SetStartAlpha( math.Rand(0, 55) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.random(20,20) )
				particle:SetEndSize( 30 )

				particle:SetColor( 127, 255, 0)	
				particle:SetRoll( math.Rand(0,1) )
				particle:SetRollDelta( math.Rand(1,0) )

	emitter:Finish()
				Sound( "", self.Origin,75, 100)
	
	
end


function EFFECT:Think( )

	return false
end

function EFFECT:Render()

end
