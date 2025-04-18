IsVehicleDeath(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return false;

	new vehicleid = GetPlayerVehicleID(playerid);

	switch (GetVehicleModel(vehicleid))
	{
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:
			return false;

		case 448, 461..463, 468, 471, 521, 522, 581, 586:
			return false;

		case 481, 509, 510:
			return false;
	}

	return true;
}

MakePlayerWounded(playerid, issuerid = INVALID_PLAYER_ID, bool:car_death = false, reason = 0)
{
    deleyAC_Nop{playerid} = true;

	if(!car_death)
	{
		SetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
		SetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);

		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
	}
	else ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);

	SetCameraBehindPlayer(playerid);

	if(issuerid != INVALID_PLAYER_ID)
	{
		if(PlayerData[playerid][pJailed] == 3 && PlayerData[issuerid][pJailed] == 3)
	    {
	        PlayerData[issuerid][pSentenceTime] += 5400; // 90 minutes

			GameTextForPlayer(issuerid, "~r~prison time extended:~n~~w~5400", 2000, 1);
	    }
	}

	new
		bool:brutally_wounded = false,
		bool:headshot_wound = false,

		count,
		lethal_wounds,

		timestamp = gettime()
	;

	for(new i = 0; i < TotalPlayerDamages[playerid]; ++i)
	{
		if(count == TotalPlayerDamages[playerid]) break;

		if(!DamageInfo[playerid][i][eDamageTaken]) continue;

		if(IsActualGun(DamageInfo[playerid][i][eDamageWeapon]) || IsLethalMeele(DamageInfo[playerid][i][eDamageWeapon]))
		{
			lethal_wounds++;

			if(DamageInfo[playerid][i][eDamageBodypart] == BODY_PART_HEAD)
			{
			    if((timestamp - DamageInfo[playerid][i][eDamageTime]) <= 30)
			    {
					headshot_wound = true;
					break;
				}
			}
		}

		count++;
	}

	if(lethal_wounds > 0 || headshot_wound || KnockedOut{playerid}) brutally_wounded = true;

	if(!brutally_wounded) //if knockout
	{
		if((timestamp - LastKnockout[playerid]) < 900000) //if last knockout was within 15 minutes
		{
			brutally_wounded = true;
		}
	}

	SetPlayerHealthEx(playerid, 40.0, false);

	DeathTimer[playerid] = 120;

	if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
	{
	    SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] Voc� desligou.");

 		SendClientMessage(PlayerData[playerid][pCallLine],  COLOR_GRAD2, "[ ! ] Eles desligaram.");

		CancelCall(playerid);
	}

	if(UsingMDC{playerid})
	{
        TogglePlayerMDC(playerid, false);
	}

	if(h_times[playerid] > 0)
	{
		ResetScrambleVariables(playerid);
	}

	if(brutally_wounded && !ForceKnockout{playerid})
	{
	    KnockedOut{playerid} = false;

		ResetPlayerWeapons(playerid);
		cl_RemoveWeapons(playerid);

		if(PlayerData[playerid][pOnDuty]) RestorePlayerWeapons(playerid, false);

		if(!headshot_wound) GameTextForPlayer(playerid, "~r~brutalmente ferido", 5000, 3);
		else GameTextForPlayer(playerid, "~y~voce esta morto", 5000, 3);

		new body[1000], weap_str[256], lost_weapons = 0, drug_str[256], lost_drugs = 0, packages_str[500], lost_packages = 0;

		for(new i = 0; i < MAX_PLAYER_WEAPON_PACKAGE; ++i)
		{
		    if(i < 3)
		    {
				if(PlayerData[playerid][pWeapon][i] != 0 && PlayerData[playerid][pAmmunation][i] != 0)
				{
					if(!lost_weapons)
						format(weap_str, 256, "%s[%d Muni��o]", ReturnWeaponName(PlayerData[playerid][pWeapon][i]), PlayerData[playerid][pAmmunation][i]);
					else
						format(weap_str, 256, "%s, %s[%d Muni��o]", weap_str, ReturnWeaponName(PlayerData[playerid][pWeapon][i]), PlayerData[playerid][pAmmunation][i]);

					lost_weapons++;
				}
			}

			if(PlayerData[playerid][pPackageWP][i] > 0)
			{
			    if(!lost_packages)
			    {
			        format(packages_str, 256, "%s[%d Muni��o]", GetWeaponPackageName(PlayerData[playerid][pPackageWP][i]), PlayerData[playerid][pPackageAmmo][i]);
				}
				else
				{
				    if(lost_packages == 4 || lost_packages == 8)
						format(packages_str, 256, "%s\n%s[%d Muni��o]", packages_str, GetWeaponPackageName(PlayerData[playerid][pPackageWP][i]), PlayerData[playerid][pPackageAmmo][i]);
				    else
						format(packages_str, 256, "%s, %s[%d Muni��o]", packages_str, GetWeaponPackageName(PlayerData[playerid][pPackageWP][i]), PlayerData[playerid][pPackageAmmo][i]);
				}

				lost_packages++;

				PlayerData[playerid][pPackageWP][i] = 0;
				PlayerData[playerid][pPackageAmmo][i] = 0;
			}

			if(i < MAX_PLAYER_DRUGS)
			{
				if(Player_Drugs[playerid][i][dID] != -1)
				{
					if(!lost_drugs)
					{
						format(drug_str, 256, "%s (%.1f, %.0f)", d_DATA[ Player_Drugs[playerid][i][dType] ][dName], Player_Drugs[playerid][i][dAmount], Player_Drugs[playerid][i][dStrength]);
					}
					else
					{
					    if(lost_drugs == 5)
							format(drug_str, 256, "%s\n%s (%.1f, %.0f)", drug_str, d_DATA[ Player_Drugs[playerid][i][dType] ][dName], Player_Drugs[playerid][i][dAmount], Player_Drugs[playerid][i][dStrength]);
						else
							format(drug_str, 256, "%s, %s (%.1f, %.0f)", drug_str, d_DATA[ Player_Drugs[playerid][i][dType] ][dName], Player_Drugs[playerid][i][dAmount], Player_Drugs[playerid][i][dStrength]);
					}

					lost_drugs++;

					Player_Drugs[playerid][i][dAmount] = 0.0;
					Player_Drugs[playerid][i][dID] = -1;
				}
			}
		}

		new bills = deathcost + PlayerData[playerid][pLevel] * 50;

		TakePlayerMoney(playerid, bills);

		SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "EMT: Suas contas m�dicas s�o $%d", bills);

		MedicBill[playerid] = 0;

		if(lost_weapons || lost_packages || lost_drugs)
		{
		    if(lost_weapons)
		    {
				ResetWeapons(playerid, true);

				format(body, sizeof(body), "{FF6347}[ ! ]{FFFFFF} Voc� perdeu armas:\n%s", weap_str);
			}

		    if(lost_packages)
		    {
			    if(lost_weapons)
					format(body, sizeof(body), "%s\n\n{FF6347}[ ! ]{FFFFFF} Voc� perdeu seus pacotes de armas:\n%s", body, packages_str);
			    else
					format(body, sizeof(body), "{FF6347}[ ! ]{FFFFFF} Voc� perdeu seus pacotes de armas:\n%s", packages_str);
			}

			if(lost_drugs)
			{
			    if(lost_weapons || lost_packages)
					format(body, sizeof(body), "%s\n\n{FF6347}[ ! ]{FFFFFF} Voc� perdeu suas drogas:\n%s", body, drug_str);
			    else
					format(body, sizeof(body), "{FF6347}[ ! ]{FFFFFF} Voc� perdeu suas drogas:\n%s", drug_str);
			}

			new year, month, day, hour, minute, second;
			getdate(year, month, day);
			gettime(hour, minute, second);

			format(body, sizeof(body), "%s\n\n{FFFFFF}Voc� perdeu seus itens em: {FF6347}%d/%d/%d -- %d:%d:%d", body, day, month, year, hour, minute, second);

			SetPVarString(playerid, "LostItems", body);

			SendNoticeMessage(playerid, "Voc� morreu e perdeu seus itens. Use /lostitems para ver o que voc� perdeu.");
		}

		SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� foi brutalmente ferido, agora se um m�dico ou qualquer outra pessoa n�o te salvar, voc� morrer�.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Para aceitar a morte, digite /aceitarmorte.");

		format(sgstr, sizeof(sgstr), "(( Foi ferido %d vezes, /ferimentos %d para mais informa��es. ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, sgstr, 0xFF6347FF, 30.0, 300 * 1000);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, sgstr);

		if(headshot_wound)
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "-> Voc� sofreu um tiro na cabe�a e morreu.");
		    SendClientMessage(playerid, COLOR_YELLOW, "-> Voc� precisa esperar 60 segundos e ent�o voc� podera usar /respawnme.");

		    MakePlayerDead(playerid, false);
		}

		if(IsPlayerConnected(issuerid) && issuerid != playerid)
		{
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[MURDER] %s murdered %s with a %s.", ReturnFormatName(issuerid), ReturnFormatName(playerid), ReturnWeaponName(reason));
		}

		if(lost_packages)
		{
		    Player_SavePackage(playerid);
		}

		if(lost_drugs)
		{
			format(gquery, sizeof(gquery), "DELETE FROM `player_drugs` WHERE `PlayerSQLID` = '%i'", PlayerData[playerid][pID]);
			mysql_tquery(dbCon, gquery);
		}

		SQL_LogAction(playerid, "Killed by %s with %s", ReturnFormatName(issuerid), ReturnWeaponName(reason));
	}
	else
	{
	    KnockedOut{playerid} = true;

		SetPlayerWeapons(playerid);

	    cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));

	    SetPlayerArmedWeapon(playerid, 0);

		GameTextForPlayer(playerid, "~b~NOCAUTEADO", 5000, 3);

		SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� foi nocauteado!");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Se algu�m n�o vier ajud�-lo, ou um param�dico n�o salv�-lo, voc� pode morrer.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o perde nenhum dos seus itens, pois voc� s� fica inconsciente at� morrer.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Para aceitar a morte, digite /aceitarmorte.");

		format(sgstr, sizeof(sgstr), "(( Foi nocauteado e atingido %d vezes, /levantar %d para ajud�-lo a levantar. ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, sgstr, 0xFF6347FF, 20.0, 300 * 1000);

		SendClientMessageEx(playerid, COLOR_LIGHTRED, sgstr);

        if(IsPlayerConnected(issuerid) && issuerid != playerid)
        {
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[MURDER] %s murdered %s with a %s. (Knock out)", ReturnName(issuerid), ReturnName(playerid), ReturnWeaponName(reason));
		}
	}

	deleyAC_Nop{playerid} = false;
	ForceKnockout{playerid} = false;

	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerAnimationIndex(playerid) != 1701)
		{
			ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
		}
	}
	else
	{
		if(GetPlayerAnimationIndex(playerid) != 1018)
		{
			ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);
		}
	}
}

MakePlayerDead(playerid, bool:executed = true)
{
	DeathMode{playerid} = true;
	KnockedOut{playerid} = false;
	DeathTimer[playerid] = 60;

	SetPlayerHealthEx(playerid, 20.0, false);

	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(executed)
	    {
	        TogglePlayerControllable(playerid, false);

	        ApplyAnimation(playerid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);
	    }
	}
	else
	{
	    TogglePlayerControllable(playerid, false);

	    ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0, 1);
	}

	SetPlayerChatBubble(playerid, "(( ESTE JOGADOR EST� MORTO. ))", 0xFF6347FF, 10.0, 300 * 1000);

	if(executed) SendClientMessage(playerid, COLOR_YELLOW, "-> Agora voc� est� morto. Voc� precisa esperar 60 segundos e ent�o voc� podera usar /respawnme.");

	SetPlayerWeather(playerid, globalWeather);
}

stock CreatePlayerCorpse(playerid)
{
	new idx = -1;

	for(new i = 0; i < MAX_PLAYERS; ++i)
	{
	    if(!CORPSES[i][corpseSpawned])
	    {
			idx = i;

			CORPSES[idx][corpseSpawned] = true;
			break;
	    }
	    else
	    {
	        if(!strcmp(CORPSES[i][corpseName], ReturnName(playerid), true))
	        {
	            DestroyActor(CORPSES[i][corpseActor]);
	            CORPSES[i][corpseActor] = INVALID_PLAYER_ID;
	            CORPSES[i][corpseName][0] = EOS;

	            idx = i;
	            break;
	        }
	    }
	}

	if(idx == -1) return printf("CreatePlayerCorpse(%d) MAX_CORPSES reached", playerid);

    CORPSES[idx][corpseMinutes] = 0;

    format(CORPSES[idx][corpseName], MAX_PLAYER_NAME, ReturnName(playerid));

	new Float:playerPos[4];
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	GetPlayerFacingAngle(playerid, playerPos[3]);

    CORPSES[idx][corpseActor] = CreateActor(GetPlayerSkin(playerid), playerPos[0], playerPos[1], playerPos[2], playerPos[3]);

    ApplyActorAnimation(CORPSES[idx][corpseActor], "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0);
    return idx;
}
