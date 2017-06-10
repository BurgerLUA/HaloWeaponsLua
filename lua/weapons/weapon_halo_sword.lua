if CLIENT then
	killicon.Add( "weapon_halo_sword", "VGUI/hud/halo2_swep_energysword", Color( 255, 255, 2555, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("VGUI/hud/halo2_swep_energysword")
end

SWEP.Category				= "Halo 2 Weapons"
SWEP.PrintName				= "Energy Sword"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Melee"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_halo_2_energy_sword.mdl"
SWEP.WorldModel				= "models/weapons/w_knife_t.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "knife"


SWEP.Primary.Damage			= 90
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 100
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 1
SWEP.Primary.Ammo			= "smod_weeb"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 100
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Automatic 	= true 

SWEP.RecoilMul				= 1
SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false

SWEP.MeleeSoundMiss			= Sound("halo2/energy_sword/melee_2.wav")
SWEP.MeleeSoundWallHit		= Sound("halo2/energy_sword/sword_hit_env1.wav")
SWEP.MeleeSoundFleshSmall	= Sound("halo2/energy_sword/energy_hit_char_5.wav")
SWEP.MeleeSoundFleshLarge	= Sound("halo2/energy_sword/energy_hit_char_2.wav")

SWEP.DisplayModel			= Model("models/blade.mdl")
SWEP.ShowWorldModel         = false

SWEP.DamageFalloff			= 50
SWEP.MeleeRange				= 50
SWEP.MeleeSize				= 32
SWEP.MeleeDamageType		= DMG_ENERGYBEAM
SWEP.MeleeDelay				= 0.15

SWEP.HasDurability 			= true
SWEP.DurabilityPerHit 		= -10

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.06, 0), angle = Angle(-1.116, 15.425, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.23, 20.188, 0) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.608, 0, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0.386, 0.001, 0.688), angle = Angle(0, -0.311, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.171, 7.776, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0.061, -0.504, 0.225), angle = Angle(-4.911, 16.455, 3.701) },
	["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.485, -9.593, 0) }
}

--[[
SWEP.WElements = {
	["energy"] = { type = "Model", model = "models/blade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.361, 0.885, -0.329), angle = Angle(80.505, -106.989, -0.759), size = Vector(0.894, 0.894, 0.894), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
--]]

SWEP.WElements = {
	["energy"] = { type = "Model", model = "models/blade.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(14, 1, 0.759), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}




SWEP.Variable01 = Material("crosshair/energy_sword_reticle")

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
	
	if Target and Target ~= NULL and (Target:IsPlayer() or Target:IsNPC()) and Target:GetPos():Distance(self.Owner:GetPos()) <= self.DamageFalloff*4 + 20 then
	
		surface.SetDrawColor(Color(255,0,0,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,64,64,0)
		
		
	else
	
		surface.SetDrawColor(Color(0,255,255,150))
		surface.SetMaterial(self.Variable01)
		surface.DrawTexturedRectRotated(XRound,YRound,64,64,0)
		
	end
	
	

end

function SWEP:PrimaryAttack()

	if self:IsUsing() then return end

	local TraceData = {
		start = self.Owner:EyePos(),
		endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward()*self.DamageFalloff*4,
		maxs = Vector(10,10,10),
		mins = Vector(-10,-10,-10),
		filter = self.Owner,
		mask = MASK_SOLID,
		ignoreworld = true,
	}
	
	self.Owner:LagCompensation( true )
	
	local TraceResult = util.TraceHull(TraceData)
	
	self.Owner:LagCompensation( false )
	
	local HitEntity = TraceResult.Entity

	if HitEntity and HitEntity ~= NULL and (HitEntity:IsPlayer() or HitEntity:IsNPC()) then
		--self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND )
		self:SendWeaponAnim(ACT_VM_HITCENTER)
		
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
		
		
		if SERVER then
			self.Owner:SetVelocity( (self.Owner:GetPos() - HitEntity:GetPos()):Angle():Forward()*-2000 )
		end
		
		local Swing = self:NewSwing(self.Primary.Damage,self.Primary.Delay,HitEntity,self.MeleeDelay)
		self:AddDurability(-10)

	else
		--self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		
		self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND )
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
		
		self:NewSwing(self.Primary.Damage,self.Primary.Delay)

	end
		
end

function SWEP:SecondaryAttack()
	if self:IsUsing() then return end
	
	--self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND )
	
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	
	self:NewSwing(self.Primary.Damage,self.Secondary.Delay)

end

function SWEP:Reload()
	--self:GetActivities()
end

function SWEP:Deploy()
	self:EmitGunSound("halo2/energy_sword/sword_ready.wav")
	self.Owner:DrawViewModel(true)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
	return true
end

function SWEP:SpecialThink()
	if CLIENT then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			local r, g, b, a = self:GetColor()
			dlight.Pos = self:GetPos()
			dlight.r = 0
			dlight.g = 255
			dlight.b = 255
			dlight.Brightness = 0
			dlight.Size = 149
			dlight.Decay = 0
			dlight.DieTime = CurTime() + 1
		end 
	end
end

function SWEP:BlockDamage(damage,attacker)
	self.Owner:DoAnimationEvent( ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND )
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
end





