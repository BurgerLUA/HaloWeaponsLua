if SERVER then AddCSLuaFile() end
 
function EFFECT:Init(data)
        self.Start = data:GetOrigin()
 
        self.Emitter = ParticleEmitter(self.Start)
                for i = 1, 100 do
                        local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)
 
                        p:SetDieTime(math.Rand(2, 3))
                        p:SetStartAlpha(80)
                        p:SetEndAlpha(0)
                        p:SetStartSize(math.random(10, 10))
                        p:SetEndSize(10)
                        p:SetCollide(true)
                               
                        local vec = VectorRand()
                        vec.z = 0
                        local pos = (self.Start + vec * 5)
                                       
                        p:SetVelocity(VectorRand() * 250)
                        p:SetColor(70,70, 70)
                       
                        timer.Simple(0.8, function() p:SetVelocity(p:GetVelocity() / 3) end)
                end
               
                for i = 1, math.random(100, 150) do
                        local p = self.Emitter:Add("effects/fire_cloud1", self.Start)
 
                        p:SetDieTime(math.Rand(0.4, 0.6))
                        p:SetStartAlpha(60)
                        p:SetEndAlpha(0)
                        p:SetStartSize(math.random(50, 150))
                        p:SetEndSize(50)
                        //p:SetRoll(math.Rand(-10, 10))
                        //p:SetRollDelta(math.Rand(-10, 10))
                        p:SetCollide(true)
                               
                        local vec = VectorRand()
                        vec.z = 0
                        local pos = (self.Start + vec * 5)
                                       
                        p:SetVelocity(VectorRand() * math.random(650, 850))
                        p:SetColor(127, 255, 0)
                end
               
                for i = 1, math.random(20, 50) do
                        local p = self.Emitter:Add("effects/muzzleflash"..math.random(1,4), self.Start)
 
                        p:SetDieTime(math.Rand(0.4, 0.6))
                        p:SetStartAlpha(60)
                        p:SetEndAlpha(0)
                        p:SetStartSize(math.random(50, 150))
                        p:SetEndSize(50)
                        //p:SetRoll(math.Rand(-10, 10))
                        //p:SetRollDelta(math.Rand(-10, 10))
                        p:SetCollide(true)
                               
                        local vec = VectorRand()
                        vec.z = 0
                        local pos = (self.Start + vec * 5)
                                       
                        p:SetVelocity(VectorRand() * math.random(150, 350))
                        p:SetColor(127, 255, 0)
                end
               
                for i = 1, math.random(10, 30) do
                        local vec = VectorRand()
                        //vec.z = 0
                        local pos = (self.Start + vec)
               
                        local p = self.Emitter:Add("effects/storm_rifle_muzzle1", self.Start + vec * 100)
 
                        p:SetDieTime(math.Rand(0.5, 0.10))
                        p:SetStartAlpha(255)
                        p:SetEndAlpha(0)
                        p:SetStartSize(math.random(120, 225))
                        p:SetRoll(math.Rand(-10, 10))
                        p:SetRollDelta(math.Rand(-10, 10))
                        p:SetEndSize(0)        
                        p:SetVelocity((Vector(0, 0, math.random(42, 80)) + vec * math.random(35, 102)) + (pos - self.Start):GetNormal() * math.random(100, 100))
                        p:SetGravity(Vector(0, 0, math.random(-302, -202)))
                        p:SetColor(127, 255, 0)
                        p:SetCollide(true)
                end
               
                for i = 1, math.random(40, 70) do
                        local vec = VectorRand()
                        vec.z = 0
                        local pos = (self.Start + vec * 5)
               
                        local p = self.Emitter:Add("sprites/orangeflare1", self.Start + vec * 100)
 
                        p:SetDieTime(math.Rand(0.1, 0.5))
                        p:SetStartAlpha(255)
                        p:SetEndAlpha(0)
                        p:SetStartSize(15)
                        p:SetEndSize(0)
                        p:SetVelocity(((pos - self.Start):GetNormal() * math.random(100, 200)) + Vector(0, 0, math.random(-200, 500)))
                        p:SetGravity(Vector(0, 0, -40))
                        p:SetColor(127, 255, 80)
                        p:SetCollide(true)
                       
                        timer.Simple(0.5, function() p:SetVelocity(p:GetVelocity() / 10) end)
                end
      
	  	surface.PlaySound("halo2/fuelrod/flak_expl"..math.random(1,3)..".wav")
			
end
 
function EFFECT:Think()
        return false
end
 
function EFFECT:Render()
end