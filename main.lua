warn("Setting up values") --idk
local owner=owner or nil
if not owner then owner={Name="Aedaniss7"} end
local bossHP=1000
local pyramidMeshID = "rbxassetid://4712590845"
local version=0.1
local isWhitelist=version<1
local whitelisted={
"Aedaniss7", --me
  "Greysoniss5", --my brother
  "leonardomigueltest" --friend
}
function WhitelistFunc(pname)
  if table.find(whitelisted, pname) or isWhitelist==false then
    return true
  else
    return false
  end
end
function say(text)
  local h=Instance.new("Hint", workspace)
  h.Text=""
  spawn(function()
      for i=1, string.len(text) do
        h.Text=string.sub(text, 0, i)
        wait()
      end
      wait(2)
      h:Destroy()
    end)
end
local pyramid1 = Instance.new("Part")
pyramid1.Name = "Orange"
pyramid1.Size = Vector3.new(10, 8, 10)
pyramid1.Anchored = true
pyramid1.Material = Enum.Material.Neon
pyramid1.Color = Color3.fromRGB(135, 67, 0)
pyramid1.CFrame = CFrame.new(0, 100, 0)
pyramid1.Parent = workspace
pyramid1.CanCollide=false
local mesh1 = Instance.new("SpecialMesh", pyramid1)
mesh1.MeshType = Enum.MeshType.FileMesh
mesh1.MeshId = pyramidMeshID
mesh1.Scale=Vector3.new(5,4,5)
local ev=Instance.new("BindableEvent", game.ServerStorage)
ev.Name="PRIMEParry"
function initUI()
  for _, p in ipairs(game.Players:GetPlayers()) do
    local gui=Instance.new("ScreenGui", p.PlayerGui)
    gui.ResetOnSpawn=false
    local O=Instance.new("TextButton", gui)
    O.BackgroundTransparency=0.6
    O.Size=UDim2.new(1,0,0.2,0)
    O.BackgroundColor3=Color3.new(1,0.6,0)
    O.MouseButton1Down:Connect(function()
        ev:Fire(p.Name, "orange")
      end)
     local B=Instance.new("TextButton", gui)
    B.BackgroundTransparency=0.6
    B.Size=UDim2.new(1,0,0.2,0)
    B.BackgroundColor3=Color3.new(0,0,1)
    B.MouseButton1Down:Connect(function()
        ev:Fire(p.Name, "blue")
      end)
    B.Position=UDim2.new(0,0,0.8,0)
    local HPBG=Instance.new("Frame", gui)
    HPBG.Name="HealthBG"
    HPBG.Size=UDim2.new(0.7,0,0,25)
    HPBG.AnchorPoint=Vector2.new(0.5,0)
    HPBG.Position=UDim2.new(0.5,0,0,45)
    HPBG.BackgroundColor3=Color3.new(0,0,0)
    local HP=Instance.new("Frame", HPBG)
    HP.Size=UDim2.new(1,0,1,0)
    local bossName=Instance.new("TextLabel", HPBG)
    bossName.BackgroundTransparency=1
    bossName.Size=UDim2.new(1,0,1,0)
    bossName.TextScaled=true
    bossName.Text="PRIME - HP 1000/1000"
    spawn(function()
        while wait() do
          bossName.Text="PRIME - HP "..bossHP.."/1000"
          HP.Size=UDim2.new(bossHP/1000,0,1,0)
        end
      end)
  end
end
local pyramid2 = pyramid1:Clone()
pyramid2.Color = Color3.new(0, 0, 1)
pyramid2.CanCollide=true
pyramid2.CFrame = CFrame.new(0, 89, 0) * CFrame.Angles(math.rad(180), 0, 0)
pyramid2.Parent = workspace
say("[SERVER]: Boss damage can only be done with a parry btw")
wait(4)
local DB=false --debounces!
function _tool(bp, name, callback)
  local tool=Instance.new("Tool", bp)
  tool.RequiresHandle=false
  tool.Name=name
  tool.Activated:Connect(function()
      if DB==false then
        DB=true
        callback()
        DB=false
      end
    end)
end
function doDmg(hum,col,dmgPercent)
  if owner.Name==hum.Parent.Name then return end
  if hum:GetAttribute("Parry")~=col then
    hum.Health-=hum.MaxHealth%dmgPercent
  else
    bossHP-=dmgPercent*2
  end
end
ev.Event:Connect(function(pname, col)
  game.Players[pname].Character.Humanoid:SetAttribute("Parry", col)
end)
local x,z=0,0
--return function(playername)
local playername=owner.Name
  print("PRIME (UNFINISHED) LOADED, CHECKING WHITELIST")
  if not WhitelistFunc(playername) then
    pyramid1:Destroy()
    pyramid2:Destroy()
    error("ERR: Version < 1 and not in whitelist.")
    return
  end
  warn("You have Whitelist! or version >=1, it is recommended to use shiftlock.")
  local p=game.Players[playername]
  local chr=p.Character
warn("Setting up prime..")
  local hum=chr:FindFirstChildOfClass("Humanoid")
task.spawn(function()
    while true do
      chr.HumanoidRootPart.Anchored=false
        -- Update player position
        chr.HumanoidRootPart.Position = Vector3.new(x, 85, z)
        if hum.MoveDirection.Magnitude>0 then
        local newCF=chr.HumanoidRootPart.CFrame*CFrame.new(0,0,-3)
        x=newCF.X
        z=newCF.Z
        end
        -- Update pyramids
        pyramid1.Position = Vector3.new(x, 80, z)
        pyramid2.Position = Vector3.new(x, 69, z)

        task.wait()
    end
end)
  hum.Running:Connect(function()
      if hum.MoveDirection.Magnitude>0 then
        local newCF=chr.HumanoidRootPart.CFrame*CFrame.new(0,0,-3)
        x=newCF.X
        z=newCF.Z
      end
    end)
initUI()
say("[Prime]: So, uh, click on the top of the screen to reflect orange attacks. Click on the bottom to reflect blue attacks.")
_tool(p.Backpack, "Orb Barrage", function()
    local IsOrange=math.random(0,1)==1
    say("TESTING MOVE. Parry: "..(IsOrange and "Orange") or "Blue")
    wait(4)
    for _, plr in ipairs(game.Players:GetPlayers()) do
      doDmg(plr.Character.Humanoid, (IsOrange and "orange") or "blue", 2)
    end
  end)
_tool(p.Backpack, "Health = 0", function() bossHP=0 say("[PRIME] Disabled.") wait(3) hum.Health=0 end)
hum.Died:Connect(function()
    pyramid1:Destroy()
    pyramid2:Destroy()
    if bossHP>0 then
      say("[Prime]: Architecture guides engineering. Will guides creation. Come back when you've found yours.")
    else
      say("[Prime]: Impressive. Soon, 'Time' and 'Space' will acknowledge you.")
    end
  end)
--end
