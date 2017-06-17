if CLIENT then
	killicon.Add( "weapon_halo_magnum", "VGUI/hud/halo2_swep_magnum", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_magnum")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Plasma Pistol"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 240

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "pistol"



SWEP.Primary.Damage			= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("ghost/ghost_shot.wav")
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 200
SWEP.Primary.SpareClip		= -1
SWEP.Primary.Delay			= 1/10
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.1
SWEP.MoveConeMul			= 0.25
SWEP.HeatMul				= 2
SWEP.CoolMul				= 0.5

SWEP.DontSeedFire			= true

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.5
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasSpecialFire			= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-2, 0, 1.5)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.MeleeDamageType		= DMG_CLUB
SWEP.MeleeRange				= 40

SWEP.DamageFalloff			= 2000

--SWEP.ReloadSound			= Sound("halo2/magnum/magnum_reload_1.wav")

SWEP.DisplayModel		= Model("models/ppis.mdl")

SWEP.AddFOV					= -10

SWEP.ShowWorldModel         = false
SWEP.WElements = {
	["magnum"] = { 
		type = "Model", 
		model = "models/ppis.mdl", 
		bone = "ValveBiped.Bip01_R_Hand", 
		rel = "", 
		pos = Vector(3.503, 1.677, 0.259), 
		angle = Angle(-97.137, 38.655, 129.307), 
		size = Vector(1.057, 1.057, 1.057), 
		color = Color(255, 255, 255, 255), 
		surpresslightning = false, 
		material = "", 
		skin = 0, 
		bodygroup = {} 
	}
}

SWEP.VElements = {
	["weapon"] = { type = "Model", model = "models/ppis.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["v_weapon.Deagle_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Variable01 = Material("crosshair/plasma_rifle")

function SWEP:PrimaryAttack()


end

function SWEP:SpecialDamage(damage)
	return math.Clamp(damage * (self:GetSpecialFloat() + 10),0,75)
end




function SWEP:PostPrimaryFire()
	if self:GetBuildUp() >= 95 then
		--self:WeaponAnimation(self:Clip1(),ACT_VM_RELOAD)
		self.Owner:EmitSound(Sound("halo2/plasmarifle/overheat.wav"))
		self:SetNextPrimaryFire(CurTime() + 3)
	end
end

function SWEP:HandleBuildUp()
	if self.HasBuildUp or self.UsesBuildUp then
		--if self:GetNextPrimaryFire() <= CurTime() then
			self:SetBuildUp( math.Clamp(self:GetBuildUp() - self.BuildUpCoolAmount*FrameTime(),0,100) )
		--end
	end
end



function SWEP:SpareThink()
	
	if self:Clip1() > 0 then
	
		if self:GetNextPrimaryFire() <= CurTime() then
			if self.Owner:KeyPressed(IN_ATTACK) then
				self:SetNextShell(CurTime() + 1)
			elseif self.Owner:KeyDown(IN_ATTACK) then
				self:SetSpecialFloat(math.Clamp(self:GetSpecialFloat() + 100*FrameTime(),0,100))
				if self:GetNextShell() <= CurTime() then
					self:TakePrimaryAmmo(1)
					self:SetNextShell(CurTime() + 0.25)
				end
			end

			if self.Owner:KeyReleased(IN_ATTACK) then
				local Power = self:GetSpecialFloat()
				local AmmoToTakePerPower = 0.25
				Power = math.Clamp(Power,0,self:Clip1()*(AmmoToTakePerPower/0.25))
				self:SetBuildUp(self:GetBuildUp() + 20 + (Power^2)*0.01)
				self:ShootGun(math.ceil(Power*AmmoToTakePerPower))
				self:SetSpecialFloat(0)
			end
		end
		
	else
		self:SetSpecialFloat(0)
	end

end

local MuzzleMaterial = Material("effects/h2_beam_rifle")

function SWEP:PostDrawViewModel( vm,weapon, ply )

	local SpecialFloat = self:GetSpecialFloat()

	local ModelEnt = self.VElements.weapon.modelEnt
	local ModelPos = ModelEnt:GetPos()
	local Bounds = ModelEnt:OBBMaxs()
	
	if SpecialFloat > 0 then


		local SpriteSize = 4 + (SpecialFloat/200)*16
		

		render.SetMaterial( MuzzleMaterial )
		render.DrawSprite(ModelPos + ModelEnt:GetRight()*-10 + ModelEnt:GetForward()*2,SpriteSize,SpriteSize,Color(0,255,0,255))	
	end
	
	local DisplayPos = ModelPos + ModelEnt:GetRight() + ModelEnt:GetForward()*4
	
	--render.SetMaterial( MuzzleMaterial )
	--render.DrawSprite(DisplayPos,8,8,Color(0,255,0,255))	
	
	local DisplayAng = ModelEnt:GetAngles()
	DisplayAng:RotateAroundAxis(ModelEnt:GetUp(),-90)
	DisplayAng:RotateAroundAxis(ModelEnt:GetForward(),90)
	
	
	
	
	
	cam.Start3D2D(DisplayPos,DisplayAng, 0.01 )
		local BuildMul = math.Clamp(self:GetBuildUp()/100,0,100)
		self:DrawCircle(0,0,Color(255*BuildMul,255 - BuildMul*255,0,255),self:Clip1()/200)
		--self:DrawCircle(0,0,Color(100,0,0,200),self:GetBuildUp()/100)
	cam.End3D2D()

	
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true //draw the display?
	self.AmmoDisplay.PrimaryClip = math.ceil(self:Clip1() / 2)
	self.AmmoDisplay.PrimaryAmmo = math.Clamp(self:GetBuildUp(),0,100)
	return self.AmmoDisplay
end

SWEP.UseMuzzle				= true
SWEP.UseSpecialProjectile	= true

SWEP.UsesBuildUp			= true
SWEP.BuildUpAmount 			= 0
SWEP.BuildUpCoolAmount 		= 33

function SWEP:DrawSpecial(ConeToSend)

	local XRound = ScrW()/2
	local YRound = ScrH()/2
	local EyeTrace = self.Owner:GetEyeTrace()
	local Target = EyeTrace.Entity
	local SpecialFloatMul = self:GetSpecialFloat()/100
	

	if Target and Target ~= NULL and (Target:IsPlayer() or Target:IsNPC()) and Target:GetPos():Distance(self.Owner:GetShootPos()) <= 1000 then
		surface.SetDrawColor(Color(255,0,0,150))
		
	else
		surface.SetDrawColor(Color(0,255,255,150))
	end
	
	surface.SetMaterial(self.Variable01)
	surface.DrawTexturedRectRotated(XRound, YRound,32 + ConeToSend, 32 + ConeToSend,0)
	surface.DrawTexturedRectRotated(XRound, YRound,32 + SpecialFloatMul*64,32 + SpecialFloatMul*64,45)
	
	--self:DrawCircle(XRound,YRound)
	
end

SWEP.MeleeSoundMiss			= Sound("halo2/magnum/magnum_melee_1.wav")
SWEP.MeleeSoundWallHit		= Sound("weapons/foot/foot_kickwall.wav")
SWEP.MeleeSoundFleshSmall	= Sound("weapons/foot/foot_kickbody.wav")
SWEP.MeleeSoundFleshLarge	= Sound("weapons/foot/foot_kickbody.wav")

SWEP.IronMeleePos 			= Vector(-6.433, -13.468, -20)
SWEP.IronMeleeAng 			= Vector(70, 0, 0)

function SWEP:ModProjectileTable(datatable)

	local ProjectileSpeed = 1500
	datatable.hullsize = 0.32*datatable.damage
	datatable.resistance = Vector(0,0,0)
	datatable.dietime = CurTime() + 10
	datatable.id = "halo_plasma_pistol"
	
	
	if datatable.damage >= 75 then	
		self.Owner:LagCompensation(true)
		local TraceData = {}
		TraceData.start = self.Owner:GetShootPos()
		TraceData.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*1000
		TraceData.filter = self.Owner
		TraceData.mask = MASK_SHOT
		local HullSize = 10
		TraceData.maxs = Vector(HullSize,HullSize,HullSize)
		TraceData.mins = Vector(-HullSize,-HullSize,-HullSize)
		local TraceResult = util.TraceHull(TraceData)
		print(TraceResult.Entity)
		if TraceResult.Entity and (TraceResult.Entity:IsPlayer() or TraceResult.Entity:IsNPC()) then
			datatable.target = TraceResult.Entity
		end
		self.Owner:LagCompensation(false)
		ProjectileSpeed = 750
	end
	
	datatable.direction = datatable.direction*ProjectileSpeed
	
	
	return datatable

end

function SWEP:DrawCircle(BasePosX,BasePosY,Col,Percent)

	local PolyTable = {}
	local Conversion = math.rad( 360 )	
	local Radius = 64
	local Width = 32
	local SegmentSides = 6
	
	local SideLength = (2 * Radius) * math.tan(math.pi/SegmentSides) 
	
	--surface.SetDrawColor( 255, 0, 0, 255 )
	--draw.NoTexture()
	
	local Rotation = -0.5
	

	--local Percent = 1
	--print(Percent)
	

	
	local SegmentPercent = 1/(SegmentSides)
	
	for i=1,SegmentSides do

		local LocalPercent = math.Clamp((Percent)/((i)*SegmentPercent),0,1)
		
		local Sides = SegmentSides
		local Offset = Rotation % Sides
		local MulOffset = ((i*LocalPercent+Offset)/Sides)
		local Sin = math.sin( -MulOffset * Conversion)
		local Cos = math.cos( MulOffset * Conversion)
		local FinalX = Sin*Radius + BasePosX
		local FinalY = Cos*Radius + BasePosY	
		local RealNumber = i
		local OldTable = PolyTable[RealNumber - 1]
		
		local ExtraOffset = (Vector(FinalX,FinalY,0) - Vector(BasePosX,BasePosY,0)):GetNormal()
		local ExtraOffsetX = ExtraOffset.x * -Width
		local ExtraOffsetY = ExtraOffset.y * -Width
		
		PolyTable[RealNumber] = {x = FinalX,y = FinalY}
		PolyTable[RealNumber+SegmentSides] = {x = FinalX + ExtraOffsetX,y = FinalY + ExtraOffsetY}

	end
	
	--[[
	for num,data in pairs(PolyTable) do
	
		local OldTable =  PolyTable[num - 1]
	
		if OldTable then
			--surface.SetDrawColor(Color(255,255,255,255))
			--surface.DrawLine( OldTable.x, OldTable.y, data.x, data.y )
		end
		--draw.DrawText( num, "TargetID", FinalX, FinalY, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	--]]
	
	
	
	--[[
	for b=1,SegmentSides do
	
		local Sides = SegmentSides
		local SegmentPercent = b/Sides
		
		
		local Offset = Rotation + 6 % Sides
		local MulOffset = ((b+Offset)/Sides)
		local Sin = -math.sin( MulOffset * Conversion )
		local Cos = math.cos( MulOffset * Conversion )
		local FinalX = Sin*(Radius-Width) + BasePosX
		local FinalY = Cos*(Radius-Width) + BasePosY	
		local RealNumber = #PolyTable + 1
		local OldTable = PolyTable[RealNumber - 1]

		PolyTable[RealNumber] = {x = FinalX,y = FinalY}
		

		
		if PolyTable[RealNumber - 1] then
			local RealNumberCords = PolyTable[RealNumber - 1]
			surface.SetDrawColor(Color(255,255,255,255))
			surface.DrawLine( RealNumberCords.x, RealNumberCords.y, FinalX, FinalY )
		end		
		draw.DrawText( RealNumber, "TargetID", FinalX, FinalY, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	--]]
	
	
	
	
	
	
	
	--PrintTable(PolyTable)
	
	surface.SetDrawColor( Col )
	draw.NoTexture()

	surface.DrawPoly( {PolyTable[6],PolyTable[12],PolyTable[11]} )
	surface.DrawPoly( {PolyTable[6],PolyTable[11],PolyTable[5]} )
	surface.DrawPoly( {PolyTable[5],PolyTable[11],PolyTable[10]} )
	surface.DrawPoly( {PolyTable[10],PolyTable[4],PolyTable[5]} )
	surface.DrawPoly( {PolyTable[10],PolyTable[3],PolyTable[4]} )
	surface.DrawPoly( {PolyTable[10],PolyTable[9],PolyTable[3]} )
	surface.DrawPoly( {PolyTable[2],PolyTable[3],PolyTable[9]} )
	surface.DrawPoly( {PolyTable[8],PolyTable[2],PolyTable[9]} )
	surface.DrawPoly( {PolyTable[1],PolyTable[2],PolyTable[8]} )
	surface.DrawPoly( {PolyTable[1],PolyTable[8],PolyTable[7]} )


	
	--surface.DrawPoly(PolyTable)
	
	
end


local DefaultMaterial = Material("sent/muzzlelight")

local datatable = {}

datatable.drawfunction = function(datatable)
	render.SetMaterial( DefaultMaterial )
	render.DrawSprite( datatable.pos,8 + datatable.damage,8 + datatable.damage,Color(0,255,0,255) )
end

datatable.hitfunction = function(datatable,traceresult)

	local Victim = traceresult.Entity
	local Attacker = datatable.owner
	local Inflictor = datatable.weapon
	
	if not IsValid(Attacker) then
		Attacker = Victim
	end
	
	if not IsValid(Inflictor) then
		Inflictor = Attacker
	end
	
	if IsValid(Attacker) and IsValid(Victim) and IsValid(Inflictor) then
		local DmgInfo = DamageInfo()
		DmgInfo:SetDamage( datatable.damage )
		DmgInfo:SetAttacker( Attacker )
		DmgInfo:SetInflictor( Inflictor )
		DmgInfo:SetDamageForce( datatable.direction:GetNormalized() )
		DmgInfo:SetDamagePosition( datatable.pos )
		DmgInfo:SetDamageType( DMG_BURN )
		traceresult.Entity:DispatchTraceAttack( DmgInfo, traceresult )
	end
		
end

BURGERBASE_RegisterProjectile("halo_plasma_pistol",datatable)



