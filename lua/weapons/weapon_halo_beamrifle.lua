if CLIENT then
	killicon.Add( "weapon_halo_beamrifle", "vgui/hud/halo2_swep_beamrifle", Color( 255, 255, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/hud/halo2_swep_beamrifle")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Beam Rifle"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1337
SWEP.CSSMoveSpeed			= 190

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 4 - 1
SWEP.SlotPos				= 1

SWEP.ViewModel				= Model("models/weapons/v_halo_2_beamrifle.mdl")
SWEP.WorldModel				= Model("models/weapons/w_irifle.mdl")
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 90
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("halo2/beam_rifle/beam_rifle_fire_1.wav")
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 25
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 1/(60/60)
SWEP.Primary.Ammo			= "smod_weeb"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.25
SWEP.SideRecoilMul			= 0.1
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 0
SWEP.HeatMul				= 0
SWEP.CoolMul				= 0
SWEP.CoolSpeedMul			= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 4
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
SWEP.IronSightTime			= 0.5
SWEP.IronSightsPos 			= Vector(-3.75 - 0.075, 0, 1.5 - 0.15)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.ZoomDelay				= 0.125

SWEP.ZoomInSound			= Sound("halo2/beam_rifle/beam rifle scope in x1.mp3")
SWEP.ZoomOutSound			= Sound("halo2/beam_rifle/beam rifle scope out.mp3")

SWEP.ReloadTimeAdd			= -0.3

--SWEP.ColorOverlay			= Color(0,255,0,20)

SWEP.FatalHeadshot			= true

SWEP.DamageFalloff			= 8000

SWEP.EnableCustomTracer 	= false
SWEP.CustomShootEffectsTable 			= {"beam_rifle_effect","h2_beam_rifle_muzzle","h2_beam_rifle_beam"}

SWEP.CustomScope			= Material("scopeutra/beam_rifle")
SWEP.CustomScopeCOverride	= Color(255,255,255,255)

SWEP.ShowWorldModel         = false

SWEP.DisplayModel			= Model("models/beamrifle_h2.mdl")

SWEP.UsesBuildUp			= true
SWEP.BuildUpAmount 			= 33
SWEP.BuildUpCoolAmount 		= 20

SWEP.CanShootWhileSprinting = false
SWEP.IronRunPos				= Vector(0,-10,-20)
SWEP.IronRunAng				= Vector(45,0,0)

SWEP.EnableDefaultScope		= false
SWEP.CustomScopeSizeMul		= 2

SWEP.WElements = {
	["beam rifle"] = { type = "Model", model = "models/beamrifle_h2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.703, 0.87, -3.257), angle = Angle(-73.243, -178.732, -86.88), size = Vector(0.992, 0.992, 0.992), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Variable01 = Material("crosshair/beam_rifle")

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

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true //draw the display?
	self.AmmoDisplay.PrimaryClip = math.ceil(self:Clip1()) * 4
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

function SWEP:SpecialFire()
	if CLIENT then
		if IsFirstTimePredicted() then
			if self.IsZoomed then
				if self.ZoomAmount == 4 then
					self.ZoomAmount = 24
					self:EmitSound(self.ZoomInSound)
				else
					self.ZoomAmount = 4
					self:EmitSound(self.ZoomOutSound)
				end
			end
		end
	end
end
