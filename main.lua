print("Setting up values")
local pyramidMeshID = "rbxassetid://4712590845"  -- mesh ID

local pyramid1 = Instance.new("Part")
pyramid1.Name = "Orange"
pyramid1.Size = Vector3.new(10, 8, 10)
pyramid1.Anchored = true
pyramid1.Material = Enum.Material.Neon
pyramid1.Color = Color3.fromRGB(135, 67, 0)
pyramid1.CFrame = CFrame.new(0, 100, 0)
pyramid1.Parent = workspace

local mesh1 = Instance.new("SpecialMesh", pyramid1)
mesh1.MeshType = Enum.MeshType.FileMesh
mesh1.MeshId = pyramidMeshID
mesh1.Scale=pyramid1.Size

local pyramid2 = pyramid1:Clone()
pyramid2.Color = Color3.new(0, 0, 1)
pyramid2.CFrame = CFrame.new(0, 89, 0) * CFrame.Angles(math.rad(180), 0, 0)
pyramid2.Parent = workspace
local DB=false --debounces!
function _tool(bp, name, callback)
  local tool=Instance.new("Tool", bp)
  tool.Name=name
  tool.Activated:Connect(function()
      if DB==false then
        DB=true
        callback()
        DB=false
      end
    end)
end
local x,z=0,0
return function(playername)
  print("PRIME (UNFINISHED) LOADED, CHECKING WHITELIST")
  local WhiteListFunc=loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/softbf395/prime-boss/refs/heads/main/whitelists.luau"))()
  if not WhiteListFunc(playername) then
    pyramid1:Destroy()
    pyramid2:Destroy()
    error("ERR: Version < 1 and not in whitelist.")
    return
  end
  print("You have Whitelist! or version >=1, it is recommended to use shiftlock.")
  local p=game.Players[playername]
  local chr=p.Character
  spawn(function()
      while wait() do chr.Position=Vector3.new(x,100,z) pyramid1.Position=Vector3.new(x,100,z) pyramid2.Position=(x,89,z) end
    end)
  local hum=chr:FindFirstChildOfClass("Humanoid")
  hum.Walking:Connect(function()
      if hum.WalkDirection.Magnitude>0 then
        local newCF=chr.HumanoidRootPart.CFrame*CFrame.new(0,0,-1)
        x=newCF.X
        z=newCF.Z
      end
    end)
end
