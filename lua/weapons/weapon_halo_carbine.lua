if CLIENT then
	killicon.Add( "weapon_halo_carbine", "vgui/hud/halo2_swep_ccarbine", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/hud/halo2_swep_ccarbine")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Carbine"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 4 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model("models/weapons/V_halo_2_cov_carbine.mdl")
SWEP.WorldModel				= Model("models/weapons/w_irifle.mdl")
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 55
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/covenant carbine/fire1.wav")
SWEP.Primary.Cone			= 0.0025
SWEP.Primary.ClipSize		= 18
SWEP.Primary.SpareClip		= 18*5
SWEP.Primary.Delay			= 1/(250/60)
SWEP.Primary.Ammo			= "bb_357sig"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.5
SWEP.SideRecoilMul			= 0.1
SWEP.RecoilSpeedMul			= 1
SWEP.MoveConeMul			= 0
SWEP.HeatMul				= 0
SWEP.CoolMul				= 0
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 3
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasSpecialFire			= false

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.IronSightsPos 			= Vector(-4, -10, -3)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.FatalHeadshot			= false

SWEP.DamageFalloff			= 3000

SWEP.HasIdle				= true

SWEP.TracerName				= nil
SWEP.EnableCustomTracer 	= false
SWEP.CustomShootEffectsTable = {"h2_aniversary_carbine_beam","h2_aniversary_carbine_muzzle"}

SWEP.CustomScope			= Material("scopeutra/halo2_cov_carbine")
SWEP.CustomScopeCOverride	= Color(0,255,255,100)

SWEP.GetMagModel 			= Model("models/carbine_ammo.mdl")
SWEP.MagDelayMod			= 0.25
SWEP.MagMoveMod 			= Vector(0,-100,100)
SWEP.MagAngMod				= Angle(0,90,0)

SWEP.ZoomInSound			= Sound("halo2/covenant carbine/carbine_zoom_in.wav")
SWEP.ZoomOutSound			= Sound("halo2/covenant carbine/carbine_zoom_out.wav")

SWEP.ReloadTimeAdd			= -0.3

SWEP.CanShootWhileSprinting = false
SWEP.IronRunPos				= Vector(0,-10,-20)
SWEP.IronRunAng				= Vector(45,0,0)


SWEP.DisplayModel		= Model("models/carbine_h2.mdl")

SWEP.ShowWorldModel         = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 11.086, 0) },
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-7.38, 1.998, -1.537), angle = Angle(-1.82, 0, 0) }
}
SWEP.WElements = {
	["carbine"] = { type = "Model", model = "models/carbine_h2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.362, 0.814, -4.283), angle = Angle(178.432, -91.481, 14.428), size = Vector(0.962, 0.962, 0.962), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Variable01 = Material("crosshair/covenant_carb_h2")
SWEP.Variable02 = Material("crosshair/plasma_rifle")

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
		surface.DrawTexturedRectRotated(XRound,YRound,32,32,0)
		
		if TargetBone then
			if TargetHead:Distance(HitPos) <= 8 then
				surface.DrawCircle(XRound,YRound,0.25, Color(255,0,0,150) )
			end
		end
		
	else
	
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,32,32,0)

	end
	
	

end

SWEP.MeleeSoundMiss			= Sound("halo2/battle/br_melee1.wav")
SWEP.MeleeSoundWallHit		= Sound("weapons/foot/foot_kickwall.wav")
SWEP.MeleeSoundFleshSmall	= Sound("weapons/foot/foot_kickbody.wav")
SWEP.MeleeSoundFleshLarge	= Sound("weapons/foot/foot_kickbody.wav")
