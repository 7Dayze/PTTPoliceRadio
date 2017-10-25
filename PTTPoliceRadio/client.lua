-- Created by Deziel0495 and IllusiveTea --

-- NOTICE
-- This script is licensed under "No License". https://choosealicense.com/no-license/
-- You are allowed to: Download, Use and Edit the Script. 
-- You are not allowed to: Copy, re-release, re-distribute it without our written permission.

-- RESTRICTED PEDS --
-- I've only listed peds that have a remote speaker mic, but any ped listed here will do the animations.

skins = {
	-- Police --
	GetHashKey("s_m_y_cop_01"),
	GetHashKey("s_f_y_cop_01"),
	-- Highway --
	GetHashKey("s_m_y_hwaycop_01"),
	-- Sheriff --
	GetHashKey("s_m_y_sheriff_01"),
	GetHashKey("s_f_y_sheriff_01"),
	-- Security --
	GetHashKey("s_m_m_security_01"),
	-- Ranger --
	GetHashKey("s_m_y_ranger_01"),
	GetHashKey("s_f_y_ranger_01"),
}

-- RADIO ANIMATIONS --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait( 0 )

        local ped = PlayerPedId()

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) and not IsPedInAnyVehicle(PlayerPedId(), true) and checkskin() then
		
			if ( not IsPauseMenuActive() ) then 
                loadAnimDict( "random@arrests" )

                while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
                        Citizen.Wait( 100 )
                end 
                if ( IsControlJustReleased( 0, 19 ) ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
                    ClearPedTasks(ped)
                    SetEnableHandcuffs(ped, false)
                else
                    if ( IsControlJustPressed( 0, 19 ) ) and checkskin() and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                        SetEnableHandcuffs(ped, true)
                    elseif ( IsControlJustPressed( 0, 19 ) ) and checkskin() and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                    end 
                    if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
                        DisableControlAction(1, 140, true)
                        DisableControlAction(1, 141, true)
                        DisableControlAction(1, 142, true)
                    elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
                        DisableControlAction(1, 140, true)
                        DisableControlAction(1, 141, true)
                        DisableControlAction(1, 142, true)
                    end
                end
            end 
        end 
    end
end )

-- GUN HOLSTER ANIMATION --

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )

        local ped = PlayerPedId()

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) and not IsPedInAnyVehicle(PlayerPedId(), true) and checkskin() then 
			DisableControlAction( 0, 20, true ) -- INPUT_MULTIPLAYER_INFO (Z)

			if ( not IsPauseMenuActive() ) then 
                    loadAnimDict( "reaction@intimidation@cop@unarmed" )

                    while ( not HasAnimDictLoaded( "reaction@intimidation@cop@unarmed" ) ) do 
                        Citizen.Wait( 100 )
                    end 
                        if ( IsDisabledControlJustReleased( 0, 20 ) ) then -- INPUT_MULTIPLAYER_INFO (Z)
						ClearPedTasks(ped)
						SetEnableHandcuffs(ped, false)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                    else
                        if ( IsDisabledControlJustPressed( 0, 20 ) ) and checkskin() then -- INPUT_MULTIPLAYER_INFO (Z)
						SetEnableHandcuffs(ped, true)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true) 
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                    end
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
                       DisableControlAction(1, 140, true)
                       DisableControlAction(1, 141, true)
                       DisableControlAction(1, 142, true)
					end	
                end
            end 
        end 
    end
end )

-- ADD/REMOVE PISTOL FROM HOLSTER --
 
 Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
			
			local ped = PlayerPedId()
			
        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) and not IsPedInAnyVehicle(PlayerPedId(), true) and checkskin() then
            
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
                    SetPedComponentVariation(ped, 9, 0, 0, 0)
				else
				if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_PISTOL") then
					SetPedComponentVariation(ped, 9, 1, 0, 0)
                end
            end
        end
    end
end)

-- DO NOT REMOVE THESE! --

function checkskin()
    for i = 1, #skins do
        if skins[i] == GetEntityModel(PlayerPedId()) then
            return true
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end
