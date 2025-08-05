print("Setting up values")
local pyramidMeshID = "rbxassetid://4712590845"  -- mesh ID

-- Create the first pyramid
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

-- Clone and flip the second pyramid
local pyramid2 = pyramid1:Clone()
pyramid2.Color = Color3.new(0, 0, 1)
pyramid2.CFrame = CFrame.new(0, 89, 0) * CFrame.Angles(math.rad(180), 0, 0)
pyramid2.Parent = workspace


return function(playername)
  print("PRIME (UNFINISHED) LOADED, CHECKING WHITELIST
  end
