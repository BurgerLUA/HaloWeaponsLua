if CLIENT then
	killicon.Add( "weapon_halo_shotgun", "vgui/hud/halo2_swep_shotgun", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/hud/halo2_swep_shotgun")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Shotgun"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 250 - 10

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model("models/weapons/v_halo_2_shotgun.mdl")
SWEP.WorldModel				= Model("models/weapons/w_shotgun.mdl")
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 150/12
SWEP.Primary.NumShots		= 12
SWEP.Primary.Sound			= Sound("halo2/shotgun/shot1.wav")
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 12
SWEP.Primary.SpareClip		= 12*3
SWEP.Primary.Delay			= 0.9
SWEP.Primary.Ammo			= "css_12gauge"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 0.1
SWEP.SideRecoilMul			= 0.1
SWEP.VelConeMul				= 0
SWEP.HeatMul				= 0
SWEP.CoolMul				= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.25
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= true
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasSpecialFire			= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-3, 0, 1)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.FatalHeadshot			= false

SWEP.DamageFalloff			= 100

SWEP.TracerNames 			= {"h2_shotty_muzzle"}

SWEP.ShowWorldModel         = false

SWEP.UseThisWorldModel		= Model("models/hshotgun.mdl")

SWEP.WElements = {
	["shotgun"] = { type = "Model", model = "models/hshotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.218, 0.853, 0), angle = Angle(-83.193, -148.736, -59.64), size = Vector(1.041, 1.041, 1.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0.62, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(1.883, 0, 0), angle = Angle(-1.19, -36.681, 0) },
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-9.745, 0, 0.266), angle = Angle(0.002, 1.648, -1.875) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0.671, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0.778, 0, 0), angle = Angle(0, 0, 0) }
}


SWEP.Variable01 = Material("crosshair/shotgun_h2")

function SWEP:DrawSpecial(ConeToSend)

	local XRound = ScrW()/2
	local YRound = ScrH()/2
	local EyeTrace = self.Owner:GetEyeTrace()
	local Target = EyeTrace.Entity
	
	local TargetHead = nil
	local TargetBone = Target:LookupBone( "ValveBiped.Bip01_Head1" )
	if TargetBone then
		TargetHead = Target:GetBonePosition( TargetBone )
	end
		
	local HitPos = EyeTrace.HitPos
	
	if Target and Target ~= NULL and (Target:IsPlayer() or Target:IsNPC()) then
		surface.SetDrawColor(Color(255,0,0,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,64,64,0)
	else
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,64,64,0)
	end

end

SWEP.MeleeSoundMiss			= Sound("halo2/battle/br_melee1.wav")
SWEP.MeleeSoundWallHit		= Sound("weapons/foot/foot_kickwall.wav")
SWEP.MeleeSoundFleshSmall	= Sound("weapons/foot/foot_kickbody.wav")
SWEP.MeleeSoundFleshLarge	= Sound("weapons/foot/foot_kickbody.wav")

function SWEP:SpecialFire()

	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	
	self:SetNextPrimaryFire(CurTime() + 1)
	
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
	self:WeaponAnimation(self:Clip1(),ACT_VM_HITCENTER)
	self:NewSwing(100)

end
