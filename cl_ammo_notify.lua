-- client/client.lua
 
local notificationActive = false  -- Variable pour suivre si la notification est active
 
-- Fonction pour afficher la notification d'activité
function ShowAmmoNotification()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Votre arme est à court de munitions!")
    DrawNotification(false, false)
    notificationActive = true
end
 
-- Fonction pour cacher la notification
function HideAmmoNotification()
    RemoveNotification()
    notificationActive = false
end
 
-- Fonction pour vérifier les munitions de l'arme actuelle
function CheckAmmo()
    local currentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
 
    -- Spécifiez le hash de l'arme de pistolet (vous pouvez ajuster cela en fonction de votre pistolet spécifique)
    local pistolHash = GetHashKey("WEAPON_PISTOL")
 
    -- Vérifiez si l'arme actuelle est un pistolet
    if currentWeapon == pistolHash then
        local ammoInClip = GetAmmoInPedWeapon(GetPlayerPed(-1), currentWeapon)
 
        if ammoInClip == 0 then
            if not notificationActive then
                ShowAmmoNotification()
            end
        else
            if notificationActive then
                HideAmmoNotification()
            end
        end
    else
        if notificationActive then
            HideAmmoNotification()
        end
    end
end
 
-- Fonction pour vérifier l'arme en main toutes les 2000 millisecondes (2 secondes)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        CheckAmmo()
    end
end)
