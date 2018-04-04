if SERVER then
	AddCSLuaFile()
	resource.AddFile("materials/vgui/ttt/icon_detectivesgift.png")
end

function AddDetectivesgiftToShop()
  if (!EquipmentItems) then return end

  EQUIP_DETECTIVESGIFT = GenerateNewEquipmentID()

  local item = {
    id = EQUIP_DETECTIVESGIFT,
    type = "item_passive",
    material = "vgui/ttt/icon_detectivesgift.png",
    name = "Detective's Gift",
    desc = "Buy this item before giving your\nweapons the detective.\nA look at the weapons you drop after\nbuying this item is deadly!"
  }
  table.insert(EquipmentItems[ROLE_TRAITOR], item)
end

function DetectivesgiftDrop(ply, wep)
  if (!ply:HasEquipmentItem(EQUIP_DETECTIVESGIFT)) then return end
  wep.detectivesgift = ply:GetRole()
end
function DetectivesgiftPickup(ply, wep)
  if (wep.detectivesgift && wep.detectivesgift != ply:GetRole()) then return false end
end

function LookAtDetectivesgift ()
  for i, ply in ipairs(team.GetPlayers(1)) do
    if (ply:GetEyeTrace().Entity.detectivesgift && ply:GetEyeTrace().Entity.detectivesgift != ply:GetRole()) then
      ply:Kill()
    end
  end
end

hook.Add("PlayerDroppedWeapon", "DetectivesgiftDrop", DetectivesgiftDrop)
hook.Add("PlayerCanPickupWeapon", "DetectivesgiftPickup", DetectivesgiftPickup)
hook.Add("Think", "LookAtDetectivesgift", LookAtDetectivesgift)
hook.Add("Initialize", "AddDetectivesgiftToShop", AddDetectivesgiftToShop)
