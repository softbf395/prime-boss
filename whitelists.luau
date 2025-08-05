local version=0.1
local isWhitelist=version<1
local whitelisted={
"Aedaniss7",
  "Greysoniss5"
}
return function(pname)
  if table.find(whitelisted, pname) or isWhitelist==false then
    return true
  else
    return false
  end
end
