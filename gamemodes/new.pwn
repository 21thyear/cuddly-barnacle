#include <open.mp>
#include "../source/core/core.inc"

main(){}

enum E_PLAYERS_STRUCTURE
{
	pID,

	pName[MAX_PLAYER_NAME + 1], // SetPlayerName до 24-х и нуль символ
	pPassword[MAX_PLAYER_PASS],
	pEmail[MAX_PLAYER_EMAIL],
	pPromocode[MAX_PLAYER_PROMO],
	pReferal[MAX_PLAYER_NAME + 1],

	pSkin,
	pSex,
	pLevel
};
new PlayerInfo[MAX_PLAYERS][E_PLAYERS_STRUCTURE];

#include "../source/dialogs/dialogs.pwn"

public OnGameModeInit()
{
	SetGameModeText("Server");

	switch(SetMySQLConnection())
	{
		case 0: printf("[SQL] Database connected!");
		default: printf("[SQL] Database connection handler error: %i", SetMySQLConnection());
	}

	CreateMySQLTables();
	return true;
}

public OnGameModeExit()
{
	return true;
}

public OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, PlayerInfo[playerid][pName], MAX_PLAYER_NAME);
	
	static const fmt_query[] = "SELECT * FROM `accounts` WHERE `uName` = '%s' LIMIT 1;";
	new query[sizeof fmt_query + (-2) + MAX_PLAYER_NAME + 1];

	format(query, sizeof(query), fmt_query, PlayerInfo[playerid][pName]);
	mysql_pquery(dbHandle, query, "OnPlayerLogin", "i", playerid);

	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	return true;
}

public OnPlayerRequestClass(playerid, classid)
{
	return true;
}

public OnPlayerSpawn(playerid)
{
	return true;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return true;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return true;
}

public OnVehicleSpawn(vehicleid)
{
	return true;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return true;
}

public OnPlayerRequestSpawn(playerid)
{
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return false;
}

public OnPlayerText(playerid, text[])
{
	return true;
}

public OnPlayerUpdate(playerid)
{
	return true;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	return true;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return true;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return true;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return true;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return true;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return true;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return true;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return true;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return true;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return true;
}

public OnPlayerExitedMenu(playerid)
{
	return true;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return true;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return true;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return true;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return true;
}

public OnRconCommand(cmd[])
{
	return false;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return true;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return true;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return true;
}

public OnObjectMoved(objectid)
{
	return true;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return true;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return true;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return true;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return true;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return true;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return true;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return true;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return true;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return true;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return true;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return true;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return true;
}

public OnScriptCash(playerid, amount, source)
{
	return true;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return true;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return true;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return true;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return true;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return true;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return true;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return true;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return true;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return true;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return true;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return true;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return true;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return true;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return true;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return true;
}

function: OnPlayerLogin(playerid)
{
	new rows;
	cache_get_row_count(rows);
	TogglePlayerSpectating(playerid, true);

	if(!rows)
	{
		return Dialog_Show(playerid, Dialog:dRegister);
	}

	cache_get_value_name(0, "uPassword", PlayerInfo[playerid][pPassword]);
	return Dialog_Show(playerid, Dialog:dLogin);
}

stock IsValidEmail(const string[])
{
    new find_@,
        dots_after_@,
        num_repeating_points;

    new i, c;

    while((c = string[i++]) != '\0')
    {
        switch(c)
        {
            case 'A'..'Z', 'a'..'z', '-', '_', '0'..'9':
            {
                num_repeating_points = 0;
                continue;
            }
            case '@':
            {
                if(i == 1) return 0;
                find_@ ++;
            }
            case '.':
            {
                if(!find_@)
                {
                    if(num_repeating_points) return 0;
                    num_repeating_points++;
                    continue;
                }
                if(++ dots_after_@ > 2) return 0;
            }
            default: return 0;
        }
    }
    if(find_@ != 1 || dots_after_@ == 0) return 0;
    return 1;
} 

function: OnPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH+1];
	bcrypt_get_hash(hash);

	strins(PlayerInfo[playerid][pPassword], hash, 0);
	if(!GetPVarInt(playerid, #MAIL_CODE))
	{
		return Dialog_Show(playerid, Dialog:dEmail); 
	}
	else
	{
		DeletePVar(playerid, #MAIL_CODE);
		return Dialog_Show(playerid, Dialog:dLogin); 
	}
}

function: RegisterPlayer(playerid)
{
	static const fmt_query[] = "\
		INSERT INTO `accounts`(`uName`, `uPassword`, `uMail`, `uPromocode`, `uSkin`, `uSex`, `uLevel`) \
		VALUES \
		('%s','%s','%s','%s','%i','%i','%i')";
	
	new query[sizeof fmt_query + (-12) + MAX_PLAYER_NAME + MAX_PLAYER_PASS + MAX_PLAYER_EMAIL + MAX_PLAYER_NAME + 28];
	mysql_format(
		dbHandle,
		query,
		sizeof(query),
		fmt_query,
		
		PlayerInfo[playerid][pName],
		PlayerInfo[playerid][pPassword],
		PlayerInfo[playerid][pEmail],
		PlayerInfo[playerid][pPromocode],
		PlayerInfo[playerid][pSkin],
		PlayerInfo[playerid][pSex],
		1
	);
	mysql_pquery(dbHandle, query);
	TogglePlayerSpectating(playerid, false);
	PlayerInfo[playerid][pLevel] = 1;

	query[0] = EOS;
	mysql_format(dbHandle, query, sizeof(query), "SELECT * FROM `accounts` WHERE `uName` = '%s' LIMIT 1", PlayerInfo[playerid][pName]);
	return mysql_pquery(dbHandle, query, "OnLoadPlayerData", "i", playerid);
}

function: OnLoadPlayerData(playerid)
{
	cache_get_value_name_int(0, "uID", PlayerInfo[playerid][pID]);
	cache_get_value_name_int(0, "uLevel", PlayerInfo[playerid][pLevel]);
	cache_get_value_name_int(0, "uSkin", PlayerInfo[playerid][pSkin]);
	cache_get_value_name_int(0, "uSex", PlayerInfo[playerid][pSex]);

	cache_get_value_name(0, "uMail", PlayerInfo[playerid][pEmail]);
	cache_get_value_name(0, "uPassword", PlayerInfo[playerid][pPassword]);

	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);

	GetPlayerRandomSpawn(playerid);

	return SpawnPlayer(playerid);
}

function: OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();

	if(!match) // incorrect password
	{
		SendClientMessage(playerid, -1, "{FFFFFF} Неправильный введен пароль! Повторите попытку.");
		return Dialog_Show(playerid, Dialog:dLogin);
	}
	else
	{
		TogglePlayerSpectating(playerid, false);

		new query[53 + (-2) + MAX_PLAYER_NAME + 1];
		mysql_format(dbHandle, query, sizeof(query), "SELECT * FROM `accounts` WHERE `uName` = '%s' LIMIT 1", PlayerInfo[playerid][pName]);
		
		return mysql_pquery(dbHandle, query, "OnLoadPlayerData", "i", playerid);
	}
}

stock GetPlayerRandomSpawn(const playerid)
{
    if(random(2) == 0)
    {
        SetSpawnInfo(
            playerid,
            0,
            PlayerInfo[playerid][pSkin],
            
            1109.43,
            -1796.54,
            16.59,
            0.0,
            
            WEAPON:0, 0, WEAPON:0, 0, WEAPON:0, 0
        );
    }
    else
    {
        SetSpawnInfo(
            playerid,
            0,
            PlayerInfo[playerid][pSkin],
            
            1756.24,
            -1898.28,
            13.56,
            0.0,
            
            WEAPON:0, 0, WEAPON:0, 0, WEAPON:0, 0
        );
    }
	return true;
}

stock KickEx(playerid) return SetTimerEx("@__KickPlayer", 150, false, "i", playerid);

@__KickPlayer(playerid);
@__KickPlayer(playerid) return Kick(playerid);