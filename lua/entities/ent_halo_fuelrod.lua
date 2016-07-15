ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "FUEL ROD"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false 
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.ShouldDraw = true

AddCSLuaFile()

function ENT:Initialize()

	if SERVER then

		local size = 1
		self:SetModel("models/Items/AR2_Grenade.mdl") 
		self:PhysicsInitSphere( size, "wood" )
		self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()
		
		if phys:IsValid() then
			phys:SetMass(500)
			phys:Wake()
			phys:EnableGravity(false)
			phys:SetVelocity( self:GetForward()*500 )
		end
		

		
		SafeRemoveEntityDelayed(self,10)

	end
	
	self.CreationTime = CurTime()
	
	if CLIENT then
		self.Emitter = ParticleEmitter( self:GetPos() )
	end
	
end


function ENT:PhysicsCollide( data, collider )
	
	collider:EnableMotion(false)
	collider:EnableCollisions(false)
	
	if self.Owner then
		util.BlastDamage( self, self.Owner, self:GetPos() , 400, 100 )
	end
	
	
	SafeRemoveEntityDelayed(self,1)
	
	self:EmitSound("halo2/fuelrod/flak_expl1.wav",SNDLVL_180dB)
	
	net.Start("FR_Detonate")
		net.WriteEntity(self)
	net.Broadcast()

end


function ENT:Think()

	if self:GetNWBool("EnableSmoke",false) == false and self.CreationTime + 0.25 <= CurTime() then
		self:SetNWBool("EnableSmoke",true)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetVelocity( self:GetForward()*3000 )
		end
	end


	if CLIENT and self.ShouldDraw then
		if self:GetNWBool("EnableSmoke",false) then
			local pos = self:GetPos()
			local Particle = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), pos)
			if Particle then
				Particle:SetVelocity((self:GetForward() * 0)+(VectorRand()* 10) )
				Particle:SetDieTime( math.Rand( 0.4, 0.6 ) )
				Particle:SetStartAlpha( 100 )
				Particle:SetEndAlpha( 0 )
				Particle:SetStartSize( math.Rand( 20,30 ) )
				Particle:SetEndSize( math.Rand( 1, 1) )
				Particle:SetRoll( math.Rand(0, 360) )
				Particle:SetRollDelta( math.Rand(-1, 1) )
				Particle:SetColor( 0 , 255 , 0 )
				Particle:SetAirResistance( 200 ) 
				Particle:SetGravity( Vector( 100, 0, 0 ) ) 	
			end
		end
	end
	
end

if SERVER then
	util.AddNetworkString( "FR_Detonate" )
end

if CLIENT then
	net.Receive("FR_Detonate",function(len)
	
		local self = net.ReadEntity()
		
		self.ShouldDraw = false
	
		local pos = self:GetPos()
		
		--print("BOOM")
	
		for i=1, 30 do
			local Particle = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9),pos)
			if Particle then
				Particle:SetVelocity( VectorRand()*400 )
				Particle:SetDieTime( 1 )
				Particle:SetStartAlpha( 100 )
				Particle:SetEndAlpha( 0 )
				Particle:SetStartSize( math.Rand( 20,30 ) )
				Particle:SetEndSize( math.Rand( 100, 200) )
				Particle:SetRoll( math.Rand(0, 360) )
				Particle:SetRollDelta( math.Rand(-1, 1) )
				Particle:SetColor( 0 , 255 , 0 )
				Particle:SetAirResistance( 200 ) 
				Particle:SetGravity( Vector(0,0,0) ) 	
			end
		end
	end)
end

function ENT:Draw()
	if self.ShouldDraw then
		local settings = {}
		settings["model"] = "models/fuelrod_projectile.mdl"	
		settings["pos"] = self:GetPos()
		
		--local Angles = self:GetVelocity():Angle()
		
		local Angles = self:GetAngles()
		
		Angles:RotateAroundAxis(self:GetUp(),90)
		
		
		settings["angle"] = Angles

		render.Model(settings)
	end
end
