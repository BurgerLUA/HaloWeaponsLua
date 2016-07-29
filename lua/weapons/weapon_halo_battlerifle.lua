if CLIENT then
	killicon.Add( "weapon_halo_battlerifle", "VGUI/hud/halo2_swep_battlerifle", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_battlerifle")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Battle Rifle"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 4 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model("models/weapons/v_halo_2_battle_rifle.mdl")
SWEP.WorldModel				= Model("models/weapons/w_irifle.mdl")
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= nil
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 36
SWEP.Primary.SpareClip		= 36*2
SWEP.Primary.Delay			= 1/(500/60)
SWEP.Primary.Ammo			= "bb_357sig"
SWEP.Primary.Automatic 		= false

SWEP.BurstSound 			= Sound("halo2/battle/1.wav")

SWEP.RecoilMul				= 0.5
SWEP.SideRecoilMul			= 0.1
SWEP.MoveConeMul			= 1.25
SWEP.HeatMul				= 0.25
SWEP.CoolMul				= 1

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
SWEP.HasSpecialFire			= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.IronSightsPos 			= Vector(-3.5, 0, 0)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.FatalHeadshot			= true

SWEP.DamageFalloff			= 2000

SWEP.TracerNames 			= {"h2_battle_muzz"}

SWEP.CustomScope			= Material("scopeutra/battle_rifle_1h2")
SWEP.CustomScopeCOverride	= Color(0,255,255,100)

SWEP.GetMagModel 			= Model("models/brifle_h2_ammo.mdl")
SWEP.MagDelayMod			= 0.25
SWEP.MagMoveMod 			= Vector(0,0,0)
SWEP.MagAngMod				= Angle(0,90,0)

SWEP.ZoomInSound			= Sound("halo2/battle/dmr_zoom_in.wav")
SWEP.ZoomOutSound			= Sound("halo2/battle/dmr_zoom_out.wav")

SWEP.ReloadTimeAdd			= -0.3

SWEP.ShowWorldModel         = false

SWEP.AlwaysBurst			= true

SWEP.DisplayModel		= Model("models/brifle_h2.mdl")

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1.246, -0.095, 0.377), angle = Angle(0, 0, 0) },
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-6.911, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["lens"] = { type = "Model", model = "models/XQM/Rails/gumball_1.mdl", bone = "body", rel = "", pos = Vector(-2.082, -0.12, 5.585), angle = Angle(0, 0, 0), size = Vector(0.029, 0.029, 0.029), color = Color(67, 160, 122, 47), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
	["br_counter"] = { type = "Quad", bone = "body", rel = "", pos = Vector(-0.95, -0.068, 4.096), angle = Angle(178.938, 88.497, -65.431), size = 0.035, draw_func = nil}
}

SWEP.WElements = {
	["battle_rifle"] = { type = "Model", model = "models/brifle_h2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.993, 0.689, 1.194), angle = Angle(-101.958, 8.383, 98.085), size = Vector(1.281, 1.281, 1.281), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Variable01 = Material("crosshair/battle_rifle_h2")
SWEP.Variable02 = Material("crosshair/shotgun_h2")

function SWEP:SpecialInitialize()
	if CLIENT then
		self.VElements["br_counter"].draw_func = function( weapon )
			if weapon:Clip1() <= 9 then
				draw.SimpleText("0"..weapon:Clip1(), "DefaultFixed", 0, -10, Color(0,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			else
				draw.SimpleText(""..weapon:Clip1(), "DefaultFixed", 0, -10, Color(0,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
	end
end

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
		
		surface.SetMaterial(self.Variable02)
		surface.SetDrawColor(Color(255,0,0,math.min(100,0 + ConeToSend*2)))
		surface.DrawTexturedRectRotated(XRound,YRound,32 + ConeToSend,32 + ConeToSend,0)
		
		if TargetBone then
			if TargetHead:Distance(HitPos) <= 8 then
				surface.DrawCircle(XRound,YRound,0.25, Color(255,0,0,150) )
			end
		end
		
	else
	
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,32,32,0)
		
		surface.SetMaterial(self.Variable02)
		surface.SetDrawColor(Color(0,255,255,math.min(100,0 + ConeToSend*2)))
		surface.DrawTexturedRectRotated(XRound,YRound,32 + ConeToSend,32 + ConeToSend,0)
		
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
	self:NewSwing(90)

end

SWEP.AddFOV					= 20

