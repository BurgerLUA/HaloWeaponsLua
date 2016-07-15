EFFECT.Mat = Material( "effects/h2_carbine_beam" ) 

function EFFECT:GetTracerOrigin( data )

	-- this is almost a direct port of GetTracerOrigin in fx_tracer.cpp
	local start = data:GetStart();
	
	-- use attachment?
	if( bit.band( data:GetFlags(), TRACER_FLAG_USEATTACHMENT ) == TRACER_FLAG_USEATTACHMENT ) then

		local entity = data:GetEntity();
		
		if( not IsValid( entity ) ) then return start; end
		if( not game.SinglePlayer() and entity:IsEFlagSet( EFL_DORMANT ) ) then return start; end
		
		if( entity:IsWeapon() and entity:IsCarriedByLocalPlayer() ) then
			local pl = entity:GetOwner();
			if( IsValid( pl ) ) then
				local vm = pl:GetViewModel();
				if( IsValid( vm ) and not LocalPlayer():ShouldDrawLocalPlayer() ) then
					entity = vm;
				else
					-- HACK: fix the model in multiplayer
					if( entity.WorldModel ) then
						entity:SetModel( entity.WorldModel );
					end
				end
			end
		end

		local attachment = entity:GetAttachment( data:GetAttachment() );
		if( attachment ) then
			start = attachment.Pos;
		end

	end
	
	return start;

end

/*---------------------------------------------------------
   EFFECT:Init(data)
---------------------------------------------------------*/
function EFFECT:Init(data)

	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	self.StartPos 	= self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.EndPos 	= data:GetOrigin()
	self.Dir 		= self.EndPos - self.StartPos
	self.Entity:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	self.TracerTime 	= 0.4
	
	// Die when it reaches its target
	self.DieTime 	= CurTime() + self.TracerTime
	
	// Play ricochet sound with random pitch
	local vGrav 	= Vector(0, 0, -450)
	local Dir	= self.Dir:GetNormalized()
	
	

	local weapon = data:GetEntity();
	if( IsValid( weapon ) and ( not weapon:IsWeapon() or not weapon:IsCarriedByLocalPlayer() ) ) then
		local dist, pos, time = util.DistanceToLine( self.StartPos, self.EndPos, EyePos() );
		
		local MaxDist = 64
		
		local VolumeMod = (1 - dist/MaxDist)*0.5
		
		if dist < MaxDist then
			EmitSound("halo2/covenant carbine/beam_flyby1.wav",pos,LocalPlayer():EntIndex(),CHAN_WEAPON,VolumeMod,SNDLVL_GUNFIRE,0,100)
		end
		
	end

	
	
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think()

	if (CurTime() > self.DieTime) then return false end
	
	return true
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

	local fDelta = (self.DieTime - CurTime()) / self.TracerTime
	fDelta = math.Clamp(fDelta, 0, 1)
			
	render.SetMaterial(self.Mat)
	
	local sinWave = math.sin(fDelta * math.pi)
	
	local color = Color(127, 255, 0, 255 * fDelta)
	
	render.DrawBeam(self.StartPos, self.EndPos, 2 * fDelta, 0.5, 0.5, color)
end