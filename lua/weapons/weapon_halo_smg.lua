if CLIENT then
	killicon.Add( "weapon_halo_smg", "VGUI/hud/halo2_swep_smg", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_smg")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "SMG"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 240

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_halo_2_smg.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/smg/smg_h2_1.wav")
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 60
SWEP.Primary.SpareClip		= 60*3
SWEP.Primary.Delay			= 1/(900/60)
SWEP.Primary.Ammo			= "bb_57mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.1
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 0
SWEP.HeatMul				= 0
SWEP.CoolMul				= 0
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.5
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasSpecialFire			= true

SWEP.AddFOV					= -10

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-3.3, 0, 1.5)
SWEP.IronSightsAng 			= Vector(0, -1, 0)

SWEP.MeleeDamageType		= DMG_CLUB
SWEP.MeleeRange				= 40


SWEP.DamageFalloff			= 300

SWEP.ReloadTimeAdd			= -0.3

SWEP.GetMagModel 			= Model("models/smgh2_ammo.mdl")
SWEP.MagDelayMod			= 0.25
SWEP.MagMoveMod 			= Vector(-200,0,0)
SWEP.MagAngMod				= Angle(0,90,0)

SWEP.CanShootWhileSprinting = false
SWEP.IronRunPos				= Vector(0,0,0)
SWEP.IronRunAng				= Vector(0,0,0)

SWEP.DisplayModel		= Model("models/smgh2.mdl")

SWEP.ShowWorldModel         = false
SWEP.WElements = {
	["smg"] = { type = "Model", model = "models/smgh2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.849, 1.503, 1.759), angle = Angle(-102.627, 6.722, 96.369), size = Vector(1.542, 1.542, 1.542), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ViewModelBoneMods = {
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-4.232, 0, 0), angle = Angle(0, 0, 0) }
}


SWEP.Variable01 = Material("crosshair/smgh2")

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

SWEP.MeleeSoundMiss			= Sound("halo2/smg/smg_melee.wav")
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

