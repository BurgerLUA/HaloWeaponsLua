if CLIENT then
	killicon.Add( "ent_halo_rod",		"VGUI/hud/halo2_fuel_rod",	Color( 255, 255, 255, 255 ) )
	killicon.Add( "weapon_halo_fuelrod",		"VGUI/hud/halo2_fuel_rod",	Color( 255, 255, 255, 255 ) )
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Fuel Rod Cannon"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Free"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed			= 100

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 6-1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_halo_2_fuel_rod_cannon.mdl"
SWEP.WorldModel				= "models/weapons/w_rocket_launcher.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "rpg"

SWEP.EnabledDropping		= false

game.AddAmmoType({name = "halo_fuelrod"})

if CLIENT then 
	language.Add("halo_fuelrod_ammo","Fuel Rod")
end

SWEP.Primary.Damage			= 100
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/fuelrod/flak_fire_h2_1.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 5
SWEP.Primary.SpareClip		= 5
SWEP.Primary.Delay			= 1/(120/60)
SWEP.Primary.Ammo			= "css_rocket"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 0.01
SWEP.SideRecoilMul			= 0
SWEP.VelConeMul				= 0
SWEP.HeatMul				= 0

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 2
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasSpecialFire			= false

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.5
SWEP.IronSightsPos 			= Vector(0, 0, 0)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.BulletEnt				= "ent_halo_fuelrod"
SWEP.SourceOverride			= Vector(7,4,-3)
SWEP.BulletAngOffset		= Angle(0,0,0)

SWEP.ZoomInSound			= Sound("halo2/fuelrod/flak_cannon_zoom_in.wav")
SWEP.ZoomOutSound			= Sound("halo2/fuelrod/flak_cannon_zoom_out.wav")

SWEP.CustomScope			= Material("scopeutra/halo2_cov_carbine")
SWEP.CustomScopeCOverride	= Color(0,255,255,100)

SWEP.TracerNames 			= {"h2_aniversary_carbine_muzzle","h2_aniversary_carbine_muzzle_2"}

SWEP.UseThisWorldModel		= Model("models/h2_fuel_rod.mdl")

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(1.098, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(2.003, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(1.136, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(1.644, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["element_name+++"] = { type = "Sprite", sprite = "engine/lightsprite", bone = "shell", rel = "", pos = Vector(0.462, -0.399, -0.129), size = { x = 2.286, y = 2.286 }, color = Color(0, 255, 0, 74), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["element_name++"] = { type = "Sprite", sprite = "models/Halo4/Weapons/covenant_carbine/display", bone = "shell", rel = "", pos = Vector(0.462, -0.224, -0.159), size = { x = 1.844, y = 1.844 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true}
}

SWEP.WElements = {
	["fuelrod"] = { type = "Model", model = "models/h2_fuel_rod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.808, 0.716, -1.04), angle = Angle(180, -91.34, 12.59), size = Vector(0.994, 0.994, 0.994), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Variable01 = Material("crosshair/fuelrod")

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
