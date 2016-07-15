if CLIENT then
	killicon.Add( "weapon_halo_magnum", "VGUI/hud/halo2_swep_magnum", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_magnum")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Magnum"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_halo_2_magnum.mdl"
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "pistol"

SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/magnum/fire1.wav")
SWEP.Primary.Cone			= 0.005
SWEP.Primary.ClipSize		= 12
SWEP.Primary.SpareClip		= 12*3
SWEP.Primary.Delay			= 1/(360/60)
SWEP.Primary.Ammo			= "css_50ae"
SWEP.Primary.Automatic 		= false

SWEP.FatalHeadshot			= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.1
SWEP.VelConeMul				= 0.25
SWEP.HeatMul				= 1
SWEP.CoolMul				= 0.5

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

SWEP.DamageFalloff			= 2000

SWEP.ReloadSound			= Sound("halo2/magnum/magnum_reload_1.wav")

SWEP.UseThisWorldModel		= Model("models/magnum_h2.mdl")

SWEP.AddFOV					= -10

SWEP.ShowWorldModel         = false
SWEP.WElements = {
	["magnum"] = { 
		type = "Model", 
		model = "models/magnum_h2.mdl", 
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

SWEP.Variable01 = Material("crosshair/magnum_h2")

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
		surface.DrawTexturedRectRotated(XRound, YRound,32 + ConeToSend, 32 + ConeToSend,0)
		
		if TargetBone then
			if TargetHead:Distance(HitPos) <= 8 then
				surface.DrawCircle(XRound,YRound,0.25, Color(255,0,0,150) )
			end
		end

	else
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,32 + ConeToSend,32 + ConeToSend,0)
	end

end

SWEP.MeleeSoundMiss			= Sound("halo2/magnum/magnum_melee_1.wav")
SWEP.MeleeSoundWallHit		= Sound("weapons/foot/foot_kickwall.wav")
SWEP.MeleeSoundFleshSmall	= Sound("weapons/foot/foot_kickbody.wav")
SWEP.MeleeSoundFleshLarge	= Sound("weapons/foot/foot_kickbody.wav")

function SWEP:SpecialFire()

	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	
	--self:GetActivities()
	
	self:SetNextPrimaryFire(CurTime() + 1)
	
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
	self:WeaponAnimation(self:Clip1(),ACT_VM_HITCENTER)
	self:NewSwing(90)

end



