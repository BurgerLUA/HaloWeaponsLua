if CLIENT then
	killicon.AddFont( "weapon_burger_cs_p90", "csd", "m", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/p90")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Sentinel Beam"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2350
SWEP.CSSMoveSpeed			= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 4 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_halo_2_sentinel_beam.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_p90.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/sentinel/senti_fire_in_converted.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 250
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= true

SWEP.EnableCustomTracer		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 1
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1
SWEP.MaxHeat				= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= true
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = false

SWEP.DamageFalloff			= 2000
SWEP.ZoomDelay				= 0.125

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5

SWEP.UsesBuildUp			= true
SWEP.BuildUpAmount 			= 8
SWEP.BuildUpCoolAmount 		= 30

SWEP.IronSightsPos = Vector(-5.64, 0, 2.2)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos 			= Vector(-2.01, -5, 0.602)
SWEP.IronRunAng 			= Vector(-5, 15, -7.739)

SWEP.IronMeleePos			= Vector(3.417, -10, -13.87)
SWEP.IronMeleeAng 			= Vector(-9.146, 70, -70)

local BeamMaterial = Material("effects/carbine_laser")
local MuzzleMaterial = Material("effects/h2_beam_rifle")
local HitMaterial = Material("effects/storm_rifle_muzzle")

sound.Add( {
	name = "weapon_sentinel.shoot",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = 100,
	sound = "halo2/sentinel/senti_fire_looping_converted1.wav"
} )


function SWEP:PostDrawViewModel( vm,weapon, ply )

	if self:GetSpecialFloat() == 1 then
		if self:CanShoot() and !self:IsUsing() then
		
			local EyeTrace = self:GetTrace()
			
			local MuzzleData = vm:GetAttachment( 2 )
			local MuzzlePos = MuzzleData.Pos + vm:GetForward()*20
			
			if EyeTrace.Entity and EyeTrace.Entity ~= NULL then
				render.SetMaterial(HitMaterial)
				render.DrawSprite(EyeTrace.HitPos,math.random(1,32),math.random(1,32),Color(0,255,255,255))
			end
			
			
			render.SetMaterial( BeamMaterial )
			render.DrawBeam(MuzzlePos,EyeTrace.HitPos, 8,0,1,Color(0,255,255,255) )
			
			render.SetMaterial( MuzzleMaterial )
			render.DrawSprite(MuzzlePos,32,32,Color(0,255,255,255))			
		end
	end
	
end

SWEP.WElements = {
	["new_weapon"] = { type = "Model", model = "models/sgun.mdl", bone = "ValveBiped.Anim_Attachment_RH", rel = "", pos = Vector(3.635, -0.519, -0.519), angle = Angle(180, -70, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.HoldType = "physgun"
SWEP.ShowWorldModel = false


function SWEP:DrawWorldModel()
	
	if self:GetSpecialFloat() == 1 then
		if self:CanShoot() and !self:IsUsing() then
		
			local EyeTrace = self:GetTrace()
			
			local MuzzleData = self.Weapon:GetAttachment( 1 )
			local MuzzlePos = MuzzleData.Pos
			
			if EyeTrace.Entity and EyeTrace.Entity ~= NULL then
				render.SetMaterial(HitMaterial)
				render.DrawSprite(EyeTrace.HitPos,math.random(1,32),math.random(1,32),Color(0,255,255,255))
			end
			
			render.SetMaterial( BeamMaterial )
			render.DrawBeam(MuzzlePos,EyeTrace.HitPos, 8,0,1,Color(0,255,255,255) )
			
			render.SetMaterial( MuzzleMaterial )
			render.DrawSprite(MuzzlePos,32,32,Color(0,255,255,255))			
		end
	end

	self:SCK_DrawWorldModel()
	
end

function SWEP:PrimaryAttack()


end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true //draw the display?
	self.AmmoDisplay.PrimaryClip = math.ceil( (self:Clip1() / 250) * 100)
	self.AmmoDisplay.PrimaryAmmo = math.Clamp(self:GetBuildUp(),0,100)
	return self.AmmoDisplay
end

SWEP.OverheatSound = Sound("halo2/sentinel/overheat_converted.wav")

function SWEP:PostPrimaryFire()
	if self:GetBuildUp() >= 100 then
		self:SetSpecialFloat(0)
		--self:WeaponAnimation(self:Clip1(),ACT_VM_RELOAD)
		if IsFirstTimePredicted() then
			if SERVER then
				self.Owner:EmitSound(self.OverheatSound)
			end
		end
		if self.LoopingSound then
			self.LoopingSound:Stop()
			self.LoopingSound = nil
		end
		self:SetNextPrimaryFire(CurTime() + 3.5)
	end
end


SWEP.LoopingSound = nil

function SWEP:GetTrace()


	self.Owner:LagCompensation( true )
	local TraceData = {}
	TraceData.start = self.Owner:GetShootPos()
	TraceData.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*3000
	TraceData.filter = self.Owner
	TraceData.mask = MASK_SHOT
	local TraceResult = util.TraceLine(TraceData)
	self.Owner:LagCompensation( false )
	
	return TraceResult
end


function SWEP:SpareThink()
	if self.Owner:KeyDown(IN_ATTACK) then
		if self:CanPrimaryAttack() and self:CanShoot() and !self:IsUsing() then
		


			local EyeTrace = self:GetTrace()
		
			if EyeTrace.Entity and EyeTrace.Entity ~= NULL then
				local DmgInfo = DamageInfo()
				DmgInfo:SetDamage( self:SpecialDamage(self.Primary.Damage) )
				DmgInfo:SetAttacker( self.Owner )
				DmgInfo:SetInflictor( self )
				DmgInfo:SetDamageForce( self.Owner:GetForward() )
				DmgInfo:SetDamagePosition( self.Owner:GetPos() )
				DmgInfo:SetDamageType( DMG_BULLET )
				EyeTrace.Entity:DispatchTraceAttack( DmgInfo, EyeTrace )
			end
			
			self:TakePrimaryAmmo(1)
			self:HandleShootAnimations()
			--self.Owner:SetAnimation(PLAYER_ATTACK1)
			--self.Owner:MuzzleFlash()
			
			if IsFirstTimePredicted() or IsSingleplayer then
			
				if self.HasBuildUp or self.UsesBuildUp then
					self:SetBuildUp( math.Clamp(self:GetBuildUp() + self.BuildUpAmount,0,100 ) )
				end
				
				self:AfterZoom() -- Predict, Client Only
				self:AddRecoil() -- Predict
				--self:WeaponSound() -- Predict
				--self:AddHeat(Damage,Shots)
			end
			
			local StillFloat = self:GetSpecialFloat() == 0
			

			
			self:SetSpecialFloat(1)
			
			self:SetNextPrimaryFire(CurTime() + self:SpecialDelay(self.Primary.Delay))
			
			self:PostPrimaryFire()
			
			if StillFloat and self:GetSpecialFloat() == 0 then
				StillFloat = false
			end

			if StillFloat then
				self:EmitSound(self.Primary.Sound)
				if not self.LoopingSound then
					self.LoopingSound = CreateSound( self, "weapon_sentinel.shoot" )
					self.LoopingSound:Play()
				end
				print("HI")
			end

			
		end
	else
		self:SetSpecialFloat(0)
		if self.LoopingSound then
			self.LoopingSound:Stop()
			self.LoopingSound = nil
		end
	end
end

function SWEP:SpecialConePost(Cone,IsCrosshair)
	return 0
end

local CrosshairMaterial = Material("crosshair/sentinel")

function SWEP:DrawSpecial(ConeToSend)


	local XRound = ScrW()/2
	local YRound = ScrH()/2
	local EyeTrace = self.Owner:GetEyeTrace()
	local Target = EyeTrace.Entity
	local TargetEyes = Target:EyePos()
	local HitPos = EyeTrace.HitPos

	if Target and Target ~= NULL and (Target:IsPlayer() or Target:IsNPC()) then
		surface.SetDrawColor(Color(255,0,0,150))
	else
		surface.SetDrawColor(Color(0,255,255,150))
	end
	
	surface.SetMaterial(CrosshairMaterial)
	surface.DrawTexturedRectRotated(XRound, YRound,64, 64,0)

end
