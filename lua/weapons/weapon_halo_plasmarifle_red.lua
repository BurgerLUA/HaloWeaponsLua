if CLIENT then
	killicon.Add( "weapon_halo_plasmarifle", "vgui/hud/halo2_swep_prifle", Color( 0, 0, 255, 255 ) )
	killicon.Add( "ent_halo_blueplasma", "vgui/hud/halo2_swep_prifle", Color( 0, 0, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/hud/halo2_swep_prifle")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Brute Plasma Rifle"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed			= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_halo_2_prifle_brute.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "revolver"

SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/plasmarifle/fire.wav")
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 200
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= ( 1/(500/60) )
SWEP.Primary.Ammo			= "smod_weeb"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 0.125
SWEP.SideRecoilMul			= 1
SWEP.MoveConeMul			= 0.75
SWEP.HeatMul				= 0
SWEP.CoolMul				= 0.5

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.25
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasSpecialFire			= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-1, 0, 2)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.DamageFalloff			= 3000

SWEP.AddFOV					= 10

SWEP.TracerName				= nil
SWEP.TracerNames 			= {"h2_prifle_muzzle","plasma_rifle_effect"}

SWEP.BulletEnt				= "ent_halo_blueplasma"
SWEP.UseMuzzle				= true
--SWEP.SourceOverride			= Vector(0,-5,-5)

SWEP.MeleeDamageType		= DMG_CLUB
SWEP.MeleeRange				= 40

SWEP.MeleeSoundMiss			= Sound("halo2/plasmarifle/melee.wav")
SWEP.MeleeSoundWallHit		= Sound("halo2/plasmarifle/melee.wav")
SWEP.MeleeSoundFleshSmall	= Sound("halo2/plasmarifle/melee.wav")
SWEP.MeleeSoundFleshLarge	= Sound("halo2/plasmarifle/melee.wav")

SWEP.UsesBuildUp			= true
SWEP.BuildUpAmount 			= 5.5
SWEP.BuildUpCoolAmount 		= 20

SWEP.DisplayModel		= Model("models/prifle2_red.mdl")

SWEP.ShowWorldModel			= false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0.238, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 12.838, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0.925, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1.003, 1.003, 1.003), pos = Vector(0.773, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0.541, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-4.068, 1.241, -0.83), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1.036, 1.036, 1.036), pos = Vector(0, 0, -0.29), angle = Angle(6.709, 1.575, -21.188) }
}
SWEP.VElements = {
	["cap_left"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "cap_left", rel = "", pos = Vector(-4.084, -0.084, -0.011), angle = Angle(89.76, 180, 0), size = Vector(0.035, 0.07, 0.035), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["cap_left+"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "cap_right", rel = "", pos = Vector(-0.02, 0.344, -0.079), angle = Angle(89.76, 180, 180), size = Vector(0.035, 0.07, 0.035), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["plasmarifle"] = { type = "Model", model = "models/prifle2_red.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.746, 0.805, -0.564), angle = Angle(-102.999, -8.143, 87.059), size = Vector(0.931, 0.931, 0.931), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:SpecialFire()
	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	self:SetNextPrimaryFire(CurTime() + 1.3)
	self:WeaponAnimation(self:Clip1(),ACT_VM_HITCENTER)
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
	self:NewSwing(90)
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true //draw the display?
	self.AmmoDisplay.PrimaryClip = math.ceil(self:Clip1() / 2)
	self.AmmoDisplay.PrimaryAmmo = math.Clamp(self:GetBuildUp() * 2 * (1/0.75),0,100)
	return self.AmmoDisplay
end


function SWEP:PostPrimaryFire()
	if self:GetBuildUp() >= 50 * 0.75 then
		self:WeaponAnimation(self:Clip1(),ACT_VM_RELOAD)
		self.Owner:EmitSound(Sound("halo2/plasmarifle/overheat.wav"))
		local ViewModel = self.Owner:GetViewModel()
		self:SetNextPrimaryFire(CurTime() + ViewModel:SequenceDuration())
		self:SetSpecialFloat(1)
	end
end

function SWEP:SpareThink()
	local BuildUp = self:GetBuildUp()
	if self:GetSpecialFloat() == 1 and BuildUp == 0 then
		self:SetSpecialFloat(0)
	end
end

SWEP.Variable01 = Material("crosshair/plasma_rifle")

local DefaultMaterial = Material("sprites/physg_glow1")

SWEP.UseSpecialProjectile	= true
SWEP.SourceOverride = Vector(3,0,-5)

function SWEP:ModProjectileTable(datatable)

	datatable.direction = datatable.direction*2000
	datatable.hullsize = 0.125
	datatable.resistance = Vector(math.random(-100,100),math.random(-100,100),math.random(-100,100))
	datatable.dietime = CurTime() + 5
	datatable.id = "halo_plasma_red"
	
	return datatable

end

local datatable = {}

datatable.drawfunction = function(datatable)
	render.SetMaterial( DefaultMaterial )
	render.DrawSprite( datatable.pos,32,32,Color(255,100,100,255) )
	render.DrawSprite( datatable.pos,8,8,Color(255,0,0,255) )
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

BURGERBASE_RegisterProjectile("halo_plasma_red",datatable)


function SWEP:DrawSpecial(ConeToSend)

	local XRound = ScrW()/2
	local YRound = ScrH()/2
	local EyeTrace = self.Owner:GetEyeTrace()
	local Target = EyeTrace.Entity
	local TargetEyes = Target:EyePos()
	local HitPos = EyeTrace.HitPos
	
	if Target and Target ~= NULL and (Target:IsPlayer() or Target:IsNPC()) then
		surface.SetDrawColor(Color(255,0,0,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound, YRound,32 + ConeToSend, 32 + ConeToSend,0)
	else
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,32 + ConeToSend,32 + ConeToSend,0)
	end

end

SWEP.MeleeSoundMiss			= Sound("halo2/plasmarifle/melee.wav")
SWEP.MeleeSoundWallHit		= Sound("weapons/foot/foot_kickwall.wav")
SWEP.MeleeSoundFleshSmall	= Sound("weapons/foot/foot_kickbody.wav")
SWEP.MeleeSoundFleshLarge	= Sound("weapons/foot/foot_kickbody.wav")

function SWEP:SpecialFire()

	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	
	self:SetNextPrimaryFire(CurTime() + 1)
	
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
	self:WeaponAnimation(self:Clip1(),ACT_VM_HITCENTER)
	self:NewSwing(90)

end

