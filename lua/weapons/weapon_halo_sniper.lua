if CLIENT then
	killicon.Add( "weapon_halo_sniper", "VGUI/hud/halo2_swep_sniperifle", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_sniperifle")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Sniper"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 4 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model("models/weapons/v_halo_2_sniper_rifle.mdl")
SWEP.WorldModel				= Model("models/weapons/w_irifle.mdl")
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 50
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/sniper/sniper_fire_h3_1.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 4
SWEP.Primary.SpareClip		= 4*5
SWEP.Primary.Delay			= 1/(60/60)
SWEP.Primary.Ammo			= "css_338"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.25
SWEP.SideRecoilMul			= 0.1
SWEP.VelConeMul				= 0
SWEP.HeatMul				= 0
SWEP.CoolMul				= 0

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 8
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

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-3.75 - 0.075, 0, 1.5 - 0.15)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.ZoomInSound			= Sound("halo2/sniper/zoom_in.wav")
SWEP.ZoomOutSound			= Sound("halo2/sniper/zoom_out.wav")

SWEP.ReloadTimeAdd			= -0.3

SWEP.ColorOverlay			= Color(0,255,0,20)

SWEP.FatalHeadshot			= true

SWEP.DamageFalloff			= 8000

SWEP.TracerNames 			= {"h2_sniper_muzzle_effect"}

SWEP.CustomScope			= Material("scopeutra/halo2_sniper")
SWEP.CustomScopeCOverride	= Color(0,255,255,100)

SWEP.GetMagModel 			= Model("models/weapons/unloaded/snip_awp_mag.mdl")
SWEP.MagDelayMod			= 0.25


SWEP.ShowWorldModel         = false

SWEP.ViewModelBoneMods = {
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-7.112, -0.179, -0.271), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["screen"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "body", rel = "", pos = Vector(-1.264, 0.363, 4.833), angle = Angle(-37.394, -1.374, 0), size = Vector(0.016, 0.028, 0.016), color = Color(255, 255, 255, 243), surpresslightning = true, material = "models/screenspace", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["sniper rifle"] = { type = "Model", model = "models/sniper_rifle_h2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.518, 1.044, -0.231), angle = Angle(-13.443, 1.138, 92.703), size = Vector(0.745, 0.745, 0.745), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Variable01 = Material("crosshair/sniper_h2")

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
		surface.DrawTexturedRectRotated(XRound,YRound,8,8,0)
		
		if TargetBone then
			if TargetHead:Distance(HitPos) <= 8 then
				surface.DrawCircle(XRound,YRound,0.25, Color(255,0,0,150) )
			end
		end
		
	else
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,8,8,0)
	end
	
	

end

function SWEP:SpecialFire()
	if CLIENT then
		if IsFirstTimePredicted() then
			if self.ZoomAmount == 8 then
				self.ZoomAmount = 24
				self:EmitSound(self.ZoomInSound)
			else
				self.ZoomAmount = 8
				self:EmitSound(self.ZoomOutSound)
			end
		end
	end
end
