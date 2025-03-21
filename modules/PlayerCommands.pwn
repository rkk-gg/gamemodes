CMD:stats(playerid, params[])
{
	new
		userid;

	if(sscanf(params, "u", userid))
	{
		ShowStatistics(playerid, playerid);
	    return true;
	}

	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "Você não está autorizado a utilizar este comando.");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "O jogador que você especificou não estê conectado.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	ShowStatistics(playerid, userid);
	return true;
}

YCMD:sn(playerid, params[], help) = streetname;

CMD:streetname(playerid, params[])
{
	SendClientMessageEx(playerid, COLOR_WHITE, "Rua: %s, San Andreas", ReturnLocationEx(playerid));
	return true;
}

CMD:moeda(playerid, params[])
{
    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s joga uma moeda e ela cai em %s.", ReturnName(playerid, 0), (random(2)) ? ("Cara") : ("Coroa"));
	return true;
}

CMD:dado(playerid, params[])
{
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s joga um dado e ele cai em %d.", ReturnName(playerid, 0), random(6) + 1);
    return true;
}

CMD:me(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/me [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.80s ...", ReturnName(playerid, 0), params);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* ... %s (( %s ))", params[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid, 0), params);

	return true;
}

stock AnnounceMeAction(playerid, const text[])
{
	if(strlen(text) > 80)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.80s ...", ReturnName(playerid, 0), text);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* ... %s (( %s ))", text[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid, 0), text);
}

CMD:mebaixo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/mebaixo [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %.80s ...", ReturnName(playerid, 0), params);
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* ... %s (( %s ))", params[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid, 0), params);

	return true;
}

CMD:ame(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/ame [ação]");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	Annotation(playerid, params);
	return true;
}

Annotation(playerid, const message[])
{
	new str[128];

	format(str, sizeof(str), "* %s %s", ReturnName(playerid, 0), message);
 	SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 6000);

 	SendClientMessageEx(playerid, COLOR_PURPLE, "> %s %s", ReturnName(playerid, 0), message);

	LastAnnotation[playerid] = gettime();
}

CMD:amy(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/amy [ação]");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	new str[128], playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx;

	format(playerName, sizeof(playerName), "%s", ReturnName(playerid, 0));
	idx = strlen(playerName);

	if(playerName[idx - 1] == 's' || playerName[idx - 1] == 's')
	{
		hasEnding = true;
	}

	if(hasEnding == true)
	{
		format (str, sizeof(str), "> %s' %s", ReturnName(playerid, 0), params);
		SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 4000);

		SendClientMessageEx(playerid, COLOR_PURPLE, "> %s' %s", ReturnName(playerid, 0), params);
	}
	else
	{
		format (str, sizeof(str), "> %s's %s", ReturnName(playerid, 0), params);
		SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 4000);

		SendClientMessageEx(playerid, COLOR_PURPLE, "> %s's %s", ReturnName(playerid, 0), params);
	}

	return true;
}

CMD:my(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/my [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	AnnounceMyAction(playerid, params);
	return true;
}

stock AnnounceMyAction(playerid, const text[])
{
	new playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx;

	format(playerName, sizeof(playerName), "%s", ReturnName(playerid, 0));
	idx = strlen(playerName);

	if(playerName[idx-1] == 's' || playerName[idx-1] == 's')
	{
		hasEnding = true;
	}

	if(hasEnding == true)
	{
		if(strlen(text) > 80)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' %.80s", ReturnName(playerid, 0), text);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' ...%s", ReturnName(playerid, 0), text[80]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s' %s", ReturnName(playerid, 0), text);
	}
	else
	{
		if(strlen(text) > 80)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's %.80s", ReturnName(playerid, 0), text);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's ...%s", ReturnName(playerid, 0), text[80]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s's %s", ReturnName(playerid, 0), text);
	}
}

CMD:mybaixo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/mybaixo [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	if(strlen(params) > 80)
	{
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s's %.80s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "... %s", params[80]);
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s's %s", ReturnName(playerid, 0), params);

	return true;
}

CMD:do(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/do [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.80s ... (( %s ))", params, ReturnName(playerid, 0));
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* ... %s (( %s ))", params[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid, 0));

	return true;
}

CMD:dobaixo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/dobaixo [ação]");

    if(DeathMode{playerid})
        return SendErrorMessage(playerid, "Você não pode utilizar /me estando morto.");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %.80s ... (( %s ))", params, ReturnName(playerid, 0));
		SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid, 0));

	return true;
}

YCMD:local(playerid, params[], help) = l;

CMD:l(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, "   você não pode falar.");

	new str[128];

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: (/l)ocal [local chat]");

	if(strlen(params) > 80)
	{
		format(str, sizeof(str), "%s diz: %.80s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 20.0, str);

		format(str, sizeof(str), "%s diz: ... %s", ReturnName(playerid, 0), params[80]);
		ProxDetector(playerid, 20.0, str);
	}
	else
	{
		format(str, sizeof(str), "%s diz: %s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 20.0, str);
	}

	ChatAnimation(playerid, strlen(params));
	return true;
}

CMD:t(playerid, params[])
{
    new str[128];

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: (/t)ocal [t chat]");

    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, "   você não pode falar.");

	if(strlen(params) > 80)
	{
		format(str, sizeof(str), "%s diz: %.80s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 20.0, str);

		format(str, sizeof(str), "%s diz: ... %s", ReturnName(playerid, 0), params[80]);
		ProxDetector(playerid, 20.0, str);
	}
	else
	{
		format(str, sizeof(str), "%s diz: %s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 20.0, str);
	}
	return true;
}

CMD:tlow(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/tlow [text]");

    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, "   você não pode falar.");

	new
	    str[128]
	;

	if(strlen(params) > 70)
	{
		format(str, sizeof(str), "%s diz [baixo]: %.70s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 6.0, str);

		format(str, sizeof(str), "%s diz [baixo]: ... %s", ReturnName(playerid, 0), params[70]);
		ProxDetector(playerid, 6.0, str);
	}
	else
	{
		format(str, sizeof(str), "%s diz [baixo]: %s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 6.0, str);
	}
	return true;
}

CMD:autobaixo(playerid, params[])
{
	AutoLow{playerid} = !AutoLow{playerid};	

	if(AutoLow{playerid})
	{
	    SendNoticeMessage(playerid, "Você habilitou o modo baixo automático; use /autobaixo novamente para desativar.");
	}
	else
	{
	    SendNoticeMessage(playerid, "Você desabilitou o modo baixo automático.");
	}
	return true;
}

CMD:baixo(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/baixo [texto]");

    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, "   você não pode falar.");

	if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID && !PlayerData[playerid][pIncomingCall])
	{
		new target = PlayerData[playerid][pCallLine];

		if(IsPlayerConnected(target))
		{
			if(PlayerData[target][pCallLine] == playerid)
			{
				new str[144];

				if(strlen(params) > 70)
				{
					format(str, sizeof(str), "%s diz (celular) [baixo]: %.70s", ReturnName(playerid, 0), params);
	                SendClientMessage(target, COLOR_YELLOW, str);

					format(str, sizeof(str), "%s diz (celular) [baixo]: ... %s", ReturnName(playerid, 0), params[70]);
	                SendClientMessage(target, COLOR_YELLOW, str);
				}
				else
				{
					format(str, sizeof(str), "%s diz (celular) [baixo]: %s", ReturnName(playerid, 0), params);
	                SendClientMessage(target, COLOR_YELLOW, str);
				}
			}
		}
	}

	LowChatProximity(playerid, params);
	return true;
}

LowChatProximity(playerid, const params[])
{
	new str[128];

	if(strlen(params) > 70)
	{
		format(str, sizeof(str), "%s diz [baixo]: %.70s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 6.0, str);

		format(str, sizeof(str), "%s diz [baixo]: ... %s", ReturnName(playerid, 0), params[70]);
		ProxDetector(playerid, 6.0, str);
	}
	else
	{
		format(str, sizeof(str), "%s diz [baixo]: %s", ReturnName(playerid, 0), params);
		ProxDetector(playerid, 6.0, str);
	}

	ChatAnimation(playerid, strlen(params));
}

YCMD:gritar(playerid, params[], help) = g;

CMD:g(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, "   você não pode falar.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/(g)ritar [texto]");

	ShoutCommand(playerid, params);
	return true;
}

ShoutCommand(playerid, const params[])
{
	new bool:isCaps = false;

	for( new i, j = strlen( params )-1; i < j; ++ i )
    {
        if( ( 'A' <= params[ i ] <= 'Z' ) && ( 'A' <= params[ i+1 ] <= 'Z' ) )
            isCaps = true;
    }

	if(isCaps == true)
	{
		if(strlen(params) > 80)
		{
			SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
			SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s grita: ...%s", params[80]);
		}
		else SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
	}
	else
	{
		if(strlen(params) > 80)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s grita: ...%s", params[80]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
	}
}

YCMD:gporta(playerid, params[], help) = gp;

CMD:gp(playerid, params[])
{
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: (/gp)orta [texto]");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "Você não pode fazer isso.");

	foreach (new i : Property)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]) && InApartment[playerid] == PropertyData[i][hComplexID]) // from outside
	    {
			ShoutCommand(playerid, params);

			foreach (new p : Player)
			{
			    if(InProperty[p] == i)
			    {
					if(strlen(params) > 80)
					{
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: ...%s", params[80]);
					}
					else SendClientMessageEx(p, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
			    }
			}
   			return true;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hExitX], PropertyData[i][hExitY], PropertyData[i][hExitZ]) && InProperty[playerid] == i) // from inside
	    {
	        ShoutCommand(playerid, params);

			foreach (new p : Player)
			{
			    if(IsPlayerInRangeOfPoint(p, 20.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]) && InApartment[p] == PropertyData[i][hComplexID])
			    {
					if(strlen(params) > 80)
					{
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: ...%s", params[80]);
					}
					else SendClientMessageEx(p, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
			    }
			}
			return true;
	    }
	}

	foreach (new i : Complex)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]) && InApartment[playerid] == -1) // from outside
	    {
	        ShoutCommand(playerid, params);

			foreach (new p : Player)
			{
			    if(InApartment[p] == i)
			    {
					if(strlen(params) > 80)
					{
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: ...%s", params[80]);
					}
					else SendClientMessageEx(p, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
			    }
			}
			return true;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[i][aExitX], ComplexData[i][aExitY], ComplexData[i][aExitZ]) && InApartment[playerid] == i) // from inside
	    {
	        ShoutCommand(playerid, params);

			foreach (new p : Player)
			{
			    if(IsPlayerInRangeOfPoint(p, 20.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]) && InApartment[p] == -1)
			    {
					if(strlen(params) > 80)
					{
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: %.80s", ReturnName(playerid, 0), params);
						SendClientMessageEx(p, COLOR_WHITE, "%s grita: ...%s", params[80]);
					}
					else SendClientMessageEx(p, COLOR_WHITE, "%s grita: %s", ReturnName(playerid, 0), params);
			    }
			}
			return true;
	    }
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está na porta de dentro ou fora da casa/empresa");
	return true;
}

CMD:pdo(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/p(orta)do [texto]");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "Você não pode fazer isso.");

	foreach (new i : Property)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]) && InApartment[playerid] == PropertyData[i][hComplexID]) // from outside
	    {
			if(strlen(params) > 80)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
			}
			else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));

			foreach (new p : Player)
			{
			    if(InProperty[p] == i)
			    {
			        if(strlen(params) > 80)
			        {
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
					}
					else SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));
			    }
			}
   			return true;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hExitX], PropertyData[i][hExitY], PropertyData[i][hExitZ]) && InProperty[playerid] == i) // from inside
	    {
			if(strlen(params) > 80)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
			}
			else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));

			foreach (new p : Player)
			{
			    if(IsPlayerInRangeOfPoint(p, 20.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]) && InApartment[p] == PropertyData[i][hComplexID])
			    {
			        if(strlen(params) > 80)
			        {
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
					}
					else SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));
			    }
			}
			return true;
	    }
	}

	foreach (new i : Complex)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]) && InApartment[playerid] == -1) // from outside
	    {
			if(strlen(params) > 80)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
			}
			else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));

			foreach (new p : Player)
			{
			    if(InApartment[p] == i)
			    {
			        if(strlen(params) > 80)
			        {
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
					}
					else SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));
			    }
			}
			return true;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[i][aExitX], ComplexData[i][aExitY], ComplexData[i][aExitZ]) && InApartment[playerid] == i) // from inside
	    {
			if(strlen(params) > 80)
			{
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
			}
			else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));

			foreach (new p : Player)
			{
			    if(IsPlayerInRangeOfPoint(p, 20.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]) && InApartment[p] == -1)
			    {
			        if(strlen(params) > 80)
			        {
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %.80s ... (( %s ))", params, ReturnName(playerid, 0));
			       		SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * ... %s (( %s ))", params[80], ReturnName(playerid, 0));
					}
					else SendClientMessageEx(p, COLOR_PURPLE, "[Porta] * %s (( %s ))", params, ReturnName(playerid, 0));
			    }
			}
			return true;
	    }
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está perto de uma porta.");
	return true;
}

CMD:bater(playerid, params[])
{
	foreach (new i : Property)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
		{
		 	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s bate na porta.", ReturnName(playerid, 0));

			foreach (new p : Player)
			{
				if(InProperty[p] == i)
				{
					SendClientMessageEx(p, COLOR_PURPLE, "* [PORTA] TOCC! TOCC! (( %s ))", ReturnName(playerid, 0));
				}
			}
			return true;
		}
	}

	foreach (new i : Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[i][bEntranceX], BusinessData[i][bEntranceY], BusinessData[i][bEntranceZ]))
		{
		 	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s bate na porta.", ReturnName(playerid, 0));

			foreach (new p : Player)
			{
				if(InBusiness[p] == i)
				{
					SendClientMessageEx(p, COLOR_PURPLE, "* [PORTA] TOCC! TOCC! (( %s ))", ReturnName(playerid, 0));
				}
			}
			return true;
		}
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está em uma casa/empresa/garagem.");
	return true;
}

CMD:campainha(playerid, params[])
{
	foreach (new i : Property)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
		{
		 	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "** %s toca a campainha.", ReturnName(playerid, 0));

			foreach (new p : Player)
			{
				if(InProperty[p] == i)
				{
					SendClientMessageEx(p, COLOR_PURPLE, "** A campainha toca (( %s ))", ReturnName(playerid, 0));
				}
			}
			return true;
		}
	}

	SendErrorMessage(playerid, "Você não esta perto de uma campainha.");
	return true;
}

YCMD:sussurrar(playerid, params[], help) = s;

CMD:s(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, " você não pode falar.");

	new userid, text[128];

    if(sscanf(params, "us[128]", userid, text))
	    return SendClientMessage(playerid, COLOR_GRAD2, "USE: (/s)ussurrar [id/nome] [texto]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Player inválido.");
		}
	}

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse é seu ID");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este jogador não está próximo.");

	if(userid == playerid)
		return SendErrorMessage(playerid, "Você não pode sussurrar para você mesmo.");

    if(strlen(text) > 80)
	{
	    SendClientMessageEx(userid, COLOR_YELLOW, "%s sussura: %.80s", ReturnName(playerid, 0), text);
	    SendClientMessageEx(userid, COLOR_YELLOW, "... %s **", text[80]);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "%s sussura: %s", ReturnName(playerid, 0), text);
	}
	else
	{
	    SendClientMessageEx(userid, COLOR_YELLOW, "%s sussura: %s", ReturnName(playerid, 0), text);
		SendClientMessageEx(playerid, COLOR_YELLOW, "%s sussura: %s", ReturnName(playerid, 0), text);
	}

	format(text, sizeof(text), "* %s murmura alguma coisa.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, text, COLOR_PURPLE, 20.0, 3000);
	return true;
}

CMD:cw(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendClientMessage(playerid, COLOR_GRAD1, " você não pode falar.");

	new text[128];

    if(sscanf(params, "s[128]", text))
	    return SendSyntaxMessage(playerid, "/(cw)hisper [texto]");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "   Você não está em um carro!");

	foreach (new i : VehicleOccupant(GetPlayerVehicleID(playerid)))
	{
		if(strlen(text) > 80)
		{
			SendClientMessageEx(i, COLOR_YELLOW, "%s sussura: %.80s", ReturnName(playerid, 0), text);
			SendClientMessageEx(i, COLOR_YELLOW, "... %s", text[80]);
		}
		else
		{
			SendClientMessageEx(i, COLOR_YELLOW, "%s sussura: %s", ReturnName(playerid, 0), text);
		}
	}
	return true;
}

CMD:cb(playerid, params[])
{
	new text[128];

    if(sscanf(params, "s[128]", text))
	    return SendSyntaxMessage(playerid, "/cb [texto]");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "   Você não está em um carro!");

	new vehicleid = GetPlayerVehicleID(playerid);

 	foreach (new i : Player)
	{
	    if(i == playerid || IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid || PlayerData[i][pSpectating] == playerid)
		{
		    if(strlen(text) > 80)
			{
			    SendClientMessageEx(i, COLOR_YELLOW, "(( [%d] %s: %.80s...))", i, ReturnName(playerid, 0), text);
			    SendClientMessageEx(i, COLOR_YELLOW, "(( ... %s ))", text[80]);
			}
			else
			{
			    SendClientMessageEx(i, COLOR_YELLOW, "(( [%d] %s: %s ))", i, ReturnName(playerid, 0), text);
			}
		}
	}
	return true;
}

CMD:b(playerid, params[])
{
	new str[128];

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /b [mensagem]");

	if(PlayerData[playerid][pMuted])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você está mutado.");

	if(strlen(params) > 70)
	{
	    if(PlayerData[playerid][pAdmin] && AdminDuty{playerid})
		{
			format(str, sizeof(str), "(( [%d] {FF9900}%s{AFAFAF}: %.70s ... ))", playerid, PlayerName(playerid), params);
			ProxDetectorOOC(playerid, 20.0, str);
		    format(str, sizeof(str), "(( [%d] {FF9900}%s{AFAFAF}: ... %s ))", playerid, PlayerName(playerid), params[70]);
	        ProxDetectorOOC(playerid, 20.0, str);
		}
		else
		{
			format(str, sizeof(str), "(( [%d] %s: %.70s ... ))", playerid, PlayerName(playerid), params);
			ProxDetectorOOC(playerid, 20.0, str);
	    	format(str, sizeof(str), "(( [%d] %s: ... %s ))", playerid, PlayerName(playerid), params[70]);
        	ProxDetectorOOC(playerid, 20.0, str);
		}
	}
	else
	{
	    if(PlayerData[playerid][pAdmin] && AdminDuty{playerid})
		{
			format(str, sizeof(str), "(( [%d] {FF9900}%s{AFAFAF}: %s ))", playerid, PlayerName(playerid), params);
		}
		else
		{
			format(str, sizeof(str), "(( [%d] %s: %s ))", playerid, PlayerName(playerid), params);
		}

		ProxDetectorOOC(playerid, 20.0, str);
	}
	return true;
}

CMD:lowb(playerid, params[])
{
	new str[128];

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /lowb [mensagem]");

	if(PlayerData[playerid][pMuted])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você está mutado.");

	if(strlen(params) > 70)
	{
	    if(PlayerData[playerid][pAdmin] && AdminDuty{playerid})
		{
			format(str, sizeof(str), "(( [%d] {FF9900}%s{B4B5B7}: %.70s ... ))", playerid, PlayerName(playerid), params);
			ProxDetectorOOC(playerid, 6.0, str);
		    format(str, sizeof(str), "(( [%d] {FF9900}%s{B4B5B7}: ... %s ))", playerid, PlayerName(playerid), params[70]);
	        ProxDetectorOOC(playerid, 6.0, str);
		}
		else
		{
			format(str, sizeof(str), "(( [%d] %s: %.70s ... ))", playerid, PlayerName(playerid), params);
			ProxDetectorOOC(playerid, 6.0, str);
	    	format(str, sizeof(str), "(( [%d] %s: ... %s ))", playerid, PlayerName(playerid), params[70]);
        	ProxDetectorOOC(playerid, 6.0, str);
		}
	}
	else
	{
	    if(PlayerData[playerid][pAdmin] && AdminDuty{playerid})
		{
			format(str, sizeof(str), "(( [%d] {FF9900}%s{B4B5B7}: %s ))", playerid, PlayerName(playerid), params);
		}
		else
		{
			format(str, sizeof(str), "(( [%d] %s: %s ))", playerid, PlayerName(playerid), params);
		}

		ProxDetectorOOC(playerid, 6.0, str);
	}
	return true;
}

CMD:nooc(playerid, params[])
{
    if(systemVariables[OOCStatus] == 1)
    {
		systemVariables[OOCStatus] = 0;

		SendClientMessageToAll(COLOR_GRAD2, "   OOC global chat has been enabled by an admin");
	}
	else
	{
		systemVariables[OOCStatus] = 1;

		SendClientMessageToAll(COLOR_GRAD2, "   OOC global chat has been disabled by an admin");
	}

	return true;
}

YCMD:ooc(playerid, params[], help) = o;

CMD:o(playerid, params[])
{
	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/(o)oc [text]");

	if(systemVariables[OOCStatus] && PlayerData[playerid][pAdmin] < 1)
		return SendClientMessage(playerid, COLOR_GREY, "   the ooc channel has been disabled by admin");

	if(PlayerData[playerid][pMuted])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are muted.");

	if(strlen(params) > 70)
	{
	    if(PlayerData[playerid][pAdmin] || PlayerData[playerid][pAdmin] == -1)
		{
			SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: %.70s", AccountName(playerid), params);
			SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: ... %s", AccountName(playerid), params[70]);
		}
		else
		{
			SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: %.70s", ReturnName(playerid), params);
	    	SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: ... %s", ReturnName(playerid), params[70]);
		}
	}
	else
	{
	    if(PlayerData[playerid][pAdmin])
			SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: %s", AccountName(playerid), params);
		else
			SendClientMessageToAllEx(COLOR_GLOBAL, "[OOC] %s: %s", ReturnName(playerid), params);
	}
	return true;
}

CMD:pm(playerid, params[])
{
	new userid, text[128];

    if(sscanf(params, "us[128]", userid, text))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /pm [id/PON] text");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(userid == playerid)
		return SendErrorMessage(playerid, "You can't pm yourself.");

	if(BlockedPM[userid][playerid] && PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "That player is blocking PMs.");

	if(AdminDuty{userid} && PlayerData[playerid][pAdmin] < 1)
	{
	    gstr[0] = EOS;

	    strcat(gstr, "Be sure to have read and understood rule 15 stating the following:\n");
		strcat(gstr, "15. Do not PM admins regarding admining, specially not admins on adminduty.\n\n");
		strcat(gstr, "If you have got a problem with something all you got to do is to make /re and as a soon as an admin finds some free time to speak to you\n");
		strcat(gstr, "about it he or she will do it, because it is their duty.\n\n");
		strcat(gstr, "Do NOT PM them under any circumstances, you are not special and every player on this server is equal.");

		SetPVarInt(playerid, "PM_Player", userid);
		SetPVarString(playerid, "PM_Text", text);

		return Dialog_Show(playerid, SendPM, DIALOG_STYLE_MSGBOX, "Warning, you're PM'ing an admin", gstr, "Send", "Don't send");
	}

	SendPrivateMessage(playerid, userid, text);
	return true;
}

Dialog:SendPM(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new userid = GetPVarInt(playerid, "PM_Player"), text[128];

	GetPVarString(playerid, "PM_Text", text, sizeof(text));

	DeletePVar(playerid, "PM_Player");
	DeletePVar(playerid, "PM_Text");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	SendPrivateMessage(playerid, userid, text);
	return true;
}

stock SendPrivateMessage(playerid, userid, text[])
{
    if(strlen(text) > 70)
	{
		SendClientMessageEx(userid, COLOR_PMF, "(( PM from %s (ID: %d): %.70s", FormatPM(playerid, 1), playerid, text);
		SendClientMessageEx(userid, COLOR_PMF, "(( PM from %s (ID: %d): ... %s ))", FormatPM(playerid, 1), playerid, text[70]);

		SendClientMessageEx(playerid, COLOR_PMS, "(( PM sent to %s (ID: %d): %.70s", FormatPM(userid, 0), userid, text);
		SendClientMessageEx(playerid, COLOR_PMS, "(( PM sent to %s (ID: %d): ... %s ))", FormatPM(userid, 0), userid, text[70]);
	}
	else
	{
		SendClientMessageEx(userid, COLOR_PMF, "(( PM from %s (ID: %d): %s ))", FormatPM(playerid, 1), playerid, text);

		SendClientMessageEx(playerid, COLOR_PMS, "(( PM sent to %s (ID: %d): %s ))", FormatPM(userid, 0), userid, text);
	}

	foreach (new i : Player)
	{
	    if(!PlayerData[i][pAdmin]) continue;

	    if(PrivateMessageEars{i} || ReadingPMs[i][playerid] == 1 || ReadingPMs[i][userid] == 1)
	    {
	        if(strlen(text) > 64)
	        {
	            SendClientMessageEx(i, COLOR_PMF, "PM from %s[%d] to %s[%d]: %.64s", FormatPM(playerid, 1), playerid, FormatPM(userid, 1), userid, text);
	            SendClientMessageEx(i, COLOR_PMF, "... %s", text[64]);
	        }
	        else SendClientMessageEx(i, COLOR_PMF, "PM from %s[%d] to %s[%d]: %s", FormatPM(playerid, 1), playerid, FormatPM(userid, 1), userid, text);
	    }
	}
}

stock FormatPM(playerid, type)
{
	new playerName[MAX_PLAYER_NAME + 40];
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(AdminDuty{playerid})
	{
	    if(!type) // sent
			format(playerName, sizeof(playerName), "{FF9900}%s{FCF545}", playerName);
	    else // received
	        format(playerName, sizeof(playerName), "{FF9900}%s{FFDC18}", playerName);
	}

	return playerName;
}

CMD:friends(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "{ADC3E7}Tip: {FFFFFF}To see a list of your friends, or to add one, go to {ADC3E7}ls-rp.com.br{FFFFFF}!");
	SendClientMessage(playerid, COLOR_WHITE, "{ADC3E7}Tip: {FFFFFF}You can enable/disable friend notifications with {ADC3E7}/togfriends{FFFFFF}.");
	SendClientMessage(playerid, COLOR_WHITE, "{ADC3E7}Tip: {FFFFFF}You can use {ADC3E7}/friendson{FFFFFF} for a list of friends online now.");
	return true;
}

CMD:friendson(playerid, params[])
{
	new count = 0;

	foreach (new p : Player)
	{
	    if(p == playerid) continue;

 		if(PlayerData[p][pID] == -1) continue;

		for(new i = 0; i < MAX_FRIENDS; ++i)
		{
		    if(Friends[playerid][i][friendID] == 0) continue;

		    if(AccountData[p][aUserid] == Friends[playerid][i][friendID])
		    {
				count ++;
		    }
		}
	}

	if(!count) return SendClientMessage(playerid, COLOR_GREY, "* You have no friends online. :(");

	SendClientMessageEx(playerid, COLOR_GREY, "* You have %d friend on.", count);
	return true;
}

CMD:togfriends(playerid, params[])
{
	if(isnull(params))
	{
	    SendSyntaxMessage(playerid, "{FF6347}/togfriends{FFFFFF} [toggle, sound, notify]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "toggle {FFFFFF}will enable/disable incoming friend login notifications.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "sound {FFFFFF}will toggle the tone you hear when a friend comes online.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "notify {FFFFFF}will toggle whether or not your friends are alerted when you login.");
		return true;
	}

	if(!strcmp(params, "toggle", true))
	{
	    if(PlayerData[playerid][pLoginToggle])
	    {
	        PlayerData[playerid][pLoginToggle] = 0;

	        SendClientMessage(playerid, COLOR_GREY, "* You have {33AA33}enabled{AFAFAF} friend logon notifications.");
	    }
	    else
	    {
	        PlayerData[playerid][pLoginToggle] = 1;

	        SendClientMessage(playerid, COLOR_GREY, "* You have {FF6347}disabled{AFAFAF} friend logon notifications.");
	    }
	}
	else if(!strcmp(params, "sound", true))
	{
	    if(PlayerData[playerid][pLoginSound])
	    {
	        PlayerData[playerid][pLoginSound] = 0;

			PlayerPlaySound(playerid, LOGIN_SOUND, 0.0, 0.0, 0.0);
	        SendClientMessage(playerid, COLOR_GREY, "* You have {33AA33}enabled{AFAFAF} the tone beep when a friend logs on.");
	    }
	    else
	    {
	        PlayerData[playerid][pLoginSound] = 1;

	        SendClientMessage(playerid, COLOR_GREY, "* You have {FF6347}disabled{AFAFAF} the tone beep when a friend logs on.");
	    }
	}
	else if(!strcmp(params, "notify", true))
	{
	    if(PlayerData[playerid][pLoginNotify])
	    {
	        PlayerData[playerid][pLoginNotify] = 0;

	        SendClientMessage(playerid, COLOR_GREY, "* You have {33AA33}enabled{AFAFAF} notifications to your friends on login.");
	    }
	    else
	    {
	        PlayerData[playerid][pLoginNotify] = 1;

	        SendClientMessage(playerid, COLOR_GREY, "* You have {FF6347}disabled{AFAFAF} notifications to your friends on your login.");
	    }
	}
	else SendErrorMessage(playerid, "Invalid Parameter.");

	return true;
}

CMD:cumprimentar(playerid, params[])
{
	new userid, animslot;

	if(sscanf(params, "ud", userid, animslot))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /cumprimentar [id/nome] [slot]");
		SendClientMessage(playerid, COLOR_GREEN, "[ 1 ] Beijar   [ 2 ] Toque [ 3 ] Toque2 [ 4 ] Toque3");
		SendClientMessage(playerid, COLOR_GREEN, "[ 5 ] Toque4  [ 6 ] Toque5 [ 7 ] Toque6 [ 8 ] Toque7");
		SendClientMessage(playerid, COLOR_GREEN, "[ 9 ] Aperto de mão formal");
		return true;
	}

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(playerid == userid)
	    return SendErrorMessage(playerid, "Você não pode cumprimentar você mesmo.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Este jogador não esta por perto.");

	if(animslot < 1 || animslot > 9)
	    return SendErrorMessage(playerid, "Slot inválido.");

	RequestedToShake[userid][0] = playerid;
	RequestedToShake[userid][1] = animslot;
	RequestedToShake[userid][2] = 15;

	SendClientMessage(playerid, COLOR_YELLOW3, "Pedido enviado.");

	SendClientMessageEx(userid, COLOR_YELLOW3, "(ID: %d)%s gostaria de cumprimentar você.(/aceitarcumprimento [id])", playerid, ReturnName(playerid, 0));
	return true;
}

CMD:aceitarcumprimento(playerid, params[])
{
	new userid;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_WHITE, "USE: /aceitarcumprimento [id]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(RequestedToShake[playerid][0] != userid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid request.");

	SetPlayerToFacePlayer(playerid, RequestedToShake[playerid][0]);
	SetPlayerToFacePlayer(RequestedToShake[playerid][0], playerid);

	switch(RequestedToShake[playerid][1])
	{
	    case 1:
	    {
			ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 3.5, 0, 0, 0, 0, 0, 1);
			ApplyAnimation(RequestedToShake[playerid][0], "KISSING", "Grlfrd_Kiss_02", 3.5, 0, 0, 0, 0, 0, 1);
	    }
		case 2:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKAA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKAA", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 3:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKBA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKBA", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 4:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKCA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKCA", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 5:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKCB", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKCB", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 6:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKDA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKDA", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 7:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKEA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKEA", 3.5, 0, 0, 0, 0, 0, 1);
		}
		case 8:
		{
	        ApplyAnimation(playerid, "GANGS", "HNDSHKFA", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "HNDSHKFA", 3.5, 0, 0, 0, 0, 0, 1);
	    }
	    case 9:
	    {
	        ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 3.5, 0, 0, 0, 0, 0, 1);
	        ApplyAnimation(RequestedToShake[playerid][0], "GANGS", "prtial_hndshk_biz_01", 3.5, 0, 0, 0, 0, 0, 1);
	    }
	}

	RequestedToShake[playerid][0] = INVALID_PLAYER_ID;
	RequestedToShake[playerid][1] = 0;
	RequestedToShake[playerid][2] = 0;
	return true;
}

CMD:tog(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "/togooc - Tog Out Of Character chat");
	SendClientMessage(playerid, COLOR_WHITE, "/togjoin - Tog connect/disconnect messages");
	SendClientMessage(playerid, COLOR_WHITE, "/togfam - Tog family chat");
	SendClientMessage(playerid, COLOR_WHITE, "/tognews - Tog SAN news");
	SendClientMessage(playerid, COLOR_WHITE, "/togrnews - Tog Racing News");
	SendClientMessage(playerid, COLOR_WHITE, "/togall - Turn it all off.");
	//SendClientMessage(playerid, COLOR_WHITE, "/togbinds - Tog your /binds system");
	return true;
}

CMD:togall(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have disabled all available chat except local/family (/togall to eanble)");
	return true;
}

CMD:togooc(playerid, params[])
{
	if(!PlayerFlags[playerid][toggleOOC])
	{
		PlayerFlags[playerid][toggleOOC] = true;

 		SendClientMessage(playerid, COLOR_GREY, " OOC chat channel disabled");
	}
	else
	{
		PlayerFlags[playerid][toggleOOC] = false;

		SendClientMessage(playerid, COLOR_GREY, " OOC chat channel enabled");
	}
	return true;
}

CMD:togjoin(playerid, params[])
{
	if(!PlayerFlags[playerid][joinAlerts])
	{
        PlayerFlags[playerid][joinAlerts] = true;

 		SendClientMessage(playerid, COLOR_LIGHTRED, "You now see when people join and quit!");
	}
	else
	{
		PlayerFlags[playerid][joinAlerts] = false;

		SendClientMessage(playerid, COLOR_LIGHTRED, "You do not see people leave or join anymore!");
	}
	return true;
}

CMD:togfam(playerid, params[])
{
	if(!PlayerFlags[playerid][factionChat])
	{
		PlayerFlags[playerid][factionChat] = true;

 		SendClientMessage(playerid, COLOR_GREY, " Family chat channel disabled");
	}
	else
	{
		PlayerFlags[playerid][factionChat] = false;

		SendClientMessage(playerid, COLOR_GREY, " Family chat channel enabled");
	}
	return true;
}

YCMD:togrnews(playerid, params[], help) = tognews;

CMD:tognews(playerid, params[])
{
	if(!PlayerFlags[playerid][toggleNews])
	{
		PlayerFlags[playerid][toggleNews] = true;

 		SendClientMessage(playerid, COLOR_GREY, " You'll no longer see news broadcasted");
	}
	else
	{
		PlayerFlags[playerid][toggleNews] = false;

		SendClientMessage(playerid, COLOR_GREY, " You'll now see news broadcasted");
	}
	return true;
}

CMD:convo(playerid, params[])
{
    if(Convo{playerid})
		return SendClientMessage(playerid, COLOR_GRAD1, "You're already in a conversation.");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/convo [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == playerid)
		return SendErrorMessage(playerid, "You can't pm yourself.");

    ConvoID[playerid] = userid;
    Convo{playerid} = true;

	SendClientMessageEx(playerid, COLOR_YELLOW, "You've started a conversation with %s", ReturnName(userid));
	SendClientMessage(playerid, COLOR_YELLOW, "To end the conversation, type /endconvo");
	return true;
}

CMD:endconvo(playerid, params[])
{
    if(!Convo{playerid})
		return SendClientMessage(playerid, COLOR_GRAD1, "You're not in a conversation.");

    Convo{playerid} = false;
	ConvoID[playerid] = INVALID_PLAYER_ID;

    SendClientMessage(playerid, COLOR_YELLOW, "You have disabled conversation mode.");
	return true;
}

CMD:blockb(playerid, params[])
{
	if(!HasDonatorRank(playerid, 1))
		return SendUnauthMessage(playerid, "Unauthorized.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/blockb [id/nome]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Playerid is not an active playerid.");

	if(BlockedOOC[playerid][userid])
	{
	    BlockedOOC[playerid][userid] = 0;

	    SendClientMessageEx(playerid, COLOR_LIGHTRED, "You are no longer blocking local OOC (/b) messages from %s.", ReturnName(userid), userid);
	}
	else
	{
        BlockedOOC[playerid][userid] = 1;

        SendClientMessageEx(playerid, COLOR_LIGHTRED, "You are blocking local OOC (/b) messages from %s.", ReturnName(userid), userid);
	}
	return true;
}

CMD:blockpm(playerid, params[])
{
	if(!HasDonatorRank(playerid, 1))
		return SendUnauthMessage(playerid, "Unauthorized.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /blockpm [id/nome]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Playerid is not an active playerid.");

	if(BlockedPM[playerid][userid])
	{
	    BlockedPM[playerid][userid] = 0;

	    SendClientMessageEx(playerid, COLOR_LIGHTRED, "You are no longer blocking private messages from %s (%d)", ReturnName(userid), userid);
	}
	else
	{
        BlockedPM[playerid][userid] = 1;

        SendClientMessageEx(playerid, COLOR_LIGHTRED, "You are now blocking private messages from %s (%d)", ReturnName(userid), userid);
	}
	return true;
}

//general commands
YCMD:getid(playerid, params[], help) = id;

CMD:id(playerid, params[]) // This command was a hefty test. Can be commented out if need be.
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/id [id/nome]");

	new
		bool:inputID = false,
		userid
	;

	for(new ix = 0, j = strlen(params); ix < j; ++ix)
	{
		if(params[ix] > '9' || params[ix] < '0')
		{
			inputID = false;
		}
		else inputID = true;
	}

	if(inputID)
	{
		userid = strval(params);

		if(!IsPlayerConnected(userid))
			return SendErrorMessage(playerid, "playerid não encontrado");

		SendClientMessageEx(playerid, COLOR_GREY, "(ID %i) %s | Level: %i", userid, ReturnName(userid), PlayerData[userid][pLevel]);
	}
	else
	{
		if(strlen(params) < 3)
	    	return SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: minímo 3 letras.");

	    if(PlayerData[playerid][pAdmin])
	    {
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "s[24]", maskid);
			if((userid = GetPlayerMaskID(maskid)) != INVALID_PLAYER_ID)
			{
				return SendClientMessageEx(playerid, COLOR_GREY, "(ID %i) %s | Level: %i", userid, ReturnName(userid), PlayerData[userid][pLevel]);
			}
		}

		new
			bool:matchFound = false,
			bool:fullName = false,
			countMatches = 0,
			matchesFound[6],
			string[128]
		;

		for(new cc = 0; cc < 5; ++cc) { matchesFound[cc] = INVALID_PLAYER_ID; }

		for(new i = 0, j = strlen(params); i < j; ++i)
		{
			if(params[i] != '_')
			{
				fullName = false;
			}
			else
			{
				fullName = true;
			}
		}

		if(fullName)
		{
			foreach (new b : Player)
			{
				if(strfind(ReturnName(b), params, true) != -1)
				{
					SendClientMessageEx(playerid, COLOR_GREY, "(ID %i) %s | Level: %i", b, ReturnName(b), PlayerData[b][pLevel]);
				}
				else return SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s não encontrado.", params);
			}
		}
		else
		{
			foreach (new a: Player)
			{
				if(strfind(ReturnName(a, 0), params, true) != -1)
				{
					matchFound = true;
					countMatches ++;
				}
			}

			if(matchFound)
			{
				for(new f = 0, g = GetPlayerPoolSize(), t = 0; f <= g; ++f)
				{
				    if(!IsPlayerConnected(f)) continue;

					if(strfind(ReturnName(f, 0), params, true) != -1)
					{
						matchesFound[t] = f;

						t++;

						if(t >= 5) break;
					}
				}

				if(countMatches != 0 && countMatches > 1)
				{
					for(new l = 0; l < sizeof(matchesFound); ++l)
					{
						if(matchesFound[l] == INVALID_PLAYER_ID)
							continue;

						format(string, sizeof(string), "%s(ID %i) %s, ", string, matchesFound[l], ReturnName(matchesFound[l]));

						if(l % 3 == 0 && l != 0 || l == 5-1)
						{
							SendClientMessage(playerid, COLOR_GREY, string);
							string[0] = 0;
						}
					}
				}
				else if(countMatches == 1)
				{
					SendClientMessageEx(playerid, COLOR_GREY, "(ID %i) %s | Level: %i", matchesFound[0], ReturnName(matchesFound[0]), PlayerData[matchesFound[0]][pLevel]);
				}
			}
			else return SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s não encontrado.", params);
		}
	}
	return true;
}

CMD:horas(playerid, params[])
{
	if(!PlayerData[playerid][pInjured])
	{
		if(isnull(params))
		{
		    if(!TimeTip{playerid})
			{
			    TimeTip{playerid} = true;

				SendNoticeMessage(playerid, "DICA: Você pode usar /horas [emote] para mudar a ação padrão.");
			}

			Annotation(playerid, "verifica as horas.");
		}
		else Annotation(playerid, params);
	}

 	new string[64], date[3];

	gettime(date[0], date[1], date[2]);
	FixHour(date[0]);
	date[0] = shifthour;

	if(PlayerData[playerid][pJailed])
	{
		switch(PlayerData[playerid][pJailed])
		{
			case PUNISHMENT_TYPE_AJAIL: format(string, sizeof(string), "ajail: %s", SecondsToString(PlayerData[playerid][pSentenceTime]));
			default: format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Tempo preso: %s", date[0], date[1], SecondsToString(PlayerData[playerid][pSentenceTime]));
		}
	}
	else format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|", date[0], date[1]);

	GameTextForPlayer(playerid, string, 2000, 1);
	return true;
}

//YCMD:data(playerid, params[], help) = servertime;

CMD:data(playerid, params[])
{
 	new
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	SendClientMessageEx(playerid, COLOR_GRAD1, "Data: %d/%d/%d -- Horas: %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]);
	return true;
}

FUNX::FallAnimation(playerid)
{
	PlayerData[playerid][pAnimation] = 1;

    if(GetPlayerAnimationIndex(playerid) != 1120)
	{
		ApplyAnimation(playerid, "PED", "EV_dive", 4.1, false, true, true, true, 0, 1);
	}
}

CMD:tackle(playerid, params[])
{
    if(PlayerData[playerid][pLevel] < 5 && !IsPolice(playerid))
	    return SendErrorMessage(playerid, "You need to be at least Level 5 to use the tackle feature.");

	if(TackleMode{playerid})
	{
	    TackleMode{playerid} = false;

	    SendNoticeMessage(playerid, "Tackling mode has been disabled.");
	    return true;
	}

	TackleMode{playerid} = true;

	SendNoticeMessage(playerid, "Tackling mode has been enabled.");

	SendClientMessage(playerid, COLOR_LIGHTRED, "If you punch someone, a tackle attempt will be registered.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "The player you hit will have a message flashed to them indicating that a tackle has been attempted.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "An automated emote will be sent in the chat that notifies the other players of the attempt.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "You will be forced into a diving animation to prevent misuse of the command.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "If a player doesn't role-play the tackle, make a report in-game.");
	return true;
}

//Help Commands

CMD:ajuda(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "___________ucp.ls-rp.com.br___________");
	SendClientMessage(playerid, COLOR_STAT1, "[CONTA] /regras /stats /levelup /levelinfo /setstyle");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /id /horas /data /comprar /telapreta /moeda /dado /nota /numero /(re)portar /licencas");
	SendClientMessage(playerid, COLOR_STAT1, "[GERAL] /(pkr)poker /roupas /trancar /an /anemp /ctrancar /gtrancar /ftrancar /entrar /sair /mascara /revistar");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /abrirpedagio /comida /curar /anims /porta /portao /atributos /veratributos /doar /pitems /liberdade");
	SendClientMessage(playerid, COLOR_STAT1, "[GERAL] /givedrink /bdrink");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /respawnme /aceitarmorte /ferimentos /mudarspawn /alterarspawn /emtrabalho /(cig)arettes /correr /andar");
	SendClientMessage(playerid, COLOR_STAT1, "[VEÍCULO] /(v)eiculo /alugarveiculo /desalugarveiculo /opendoor /rw /carsign /pullincar");
	SendClientMessage(playerid, COLOR_STAT2, "[DROGAS] /mydrugs /usedrug /dropdrug /transferdrug /givedrug /buildpackage /adjustpackage /tad /pad");
	SendClientMessage(playerid, COLOR_STAT1, "[ARMAS] /meupacote /armas /da /pa /dropgun /desempacotar /venderpacote /colocar /pegar");
	SendClientMessage(playerid, COLOR_STAT2, "[CHAT] /(s)ussurrar /baixo /(l)ocal /b (OOC) /t /tlow /(g)ritar /gp(orta) /cw | (OOC): /cb /pm /convo");
	SendClientMessage(playerid, COLOR_STAT1, "[EMOTES] /me(baixo) /do(baixo) /my /ame /amy /pdo /cumprimentar /aceitarcumprimento");
	SendClientMessage(playerid, COLOR_STAT2, "[BANCO] /saldo /sacar /depositar /savings /cheque");
	SendClientMessage(playerid, COLOR_STAT1, "[OUTROS] /ajudacelular /ajudacasa /ajudaempresa /ajudaemprego /ajudafaccao /ajudapesca");
	SendClientMessage(playerid, COLOR_STAT2, "[OUTROS] /ajudaradio /ajudaarmas /ajudadrogas /ajudalicenca");
	SendClientMessage(playerid, COLOR_STAT1, "[TOG] /tog /newspaper /tog(join)(news)(rnews)(ooc) /togall /blockb /blockpm /toghud");
	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	SendClientMessage(playerid, COLOR_STAT1, "Visite a seção Documentação de recursos no fórum ou digite /helpme para obter mais ajuda");
	return true;
}

/*CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "___________ucp.ls-rp.com.br___________");
	SendClientMessage(playerid, COLOR_STAT1, "[CONTA] /regras /stats /levelup /levelinfo /setstyle");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /id /horas /data /comprar /telapreta /moeda /dado /nota /numero /(re)portar /licencas");
	SendClientMessage(playerid, COLOR_STAT1, "[GERAL] /(pkr)poker /roupas /trancar /an /anemp /ctrancar /gtrancar /ftrancar /entrar /sair /mascara /revistar");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /abrirpedagio /comida /curar /anims /porta /portao /atributos /veratributos /doar /pitems /liberdade /job");
	SendClientMessage(playerid, COLOR_STAT1, "[GERAL] /bar /leavebar /selldrink /showmenu /drink /givedrink /bdrink /selllicense /collect");
	SendClientMessage(playerid, COLOR_STAT2, "[GERAL] /respawnme /aceitarmorte /ferimentos /changespawn /emtrabalho /(cig)arettes /correr");
	SendClientMessage(playerid, COLOR_STAT1, "[VEÍCULO] /(v)eiculo /alugarveiculo /desalugarveiculo /opendoor /rw /carsign /pullincar");
	SendClientMessage(playerid, COLOR_STAT2, "[DROGAS] /mydrugs /usedrug /dropdrug /transferdrug /givedrug /buildpackage /adjustpackage /tad /pad");
	SendClientMessage(playerid, COLOR_STAT1, "[ARMAS] /meupacote /weapons /da /pa /dropgun /desempacotar /venderpacote /colocar /pegar");
	SendClientMessage(playerid, COLOR_STAT2, "[CHAT] /(s)ussurrar /baixo /(l)ocal /b (OOC) /t /tlow /(g)ritar /gp(orta) /cw /cb (OOC) /pm (OOC) /convo (OOC)");
	SendClientMessage(playerid, COLOR_STAT1, "[EMOTES] /me(baixo) /do(baixo) /my /ame /amy /pdo /cumprimentar /aceitarcumprimento");
	SendClientMessage(playerid, COLOR_STAT2, "[BANCO] /saldo /sacar /depositar /savings /transfer /cheque");
	SendClientMessage(playerid, COLOR_STAT1, "[OUTROS] /phonehelp /househelp /businesshelp /jobhelp /factionhelp /pescarhelp");
	SendClientMessage(playerid, COLOR_STAT2, "[OUTROS] /radiohelp /dealinghelp /drughelp /ajudalicenca");
	SendClientMessage(playerid, COLOR_STAT1, "[TOG] /tog /newspaper /tog(join)(news)(rnews)(ooc) /togall /blockb /blockpm /toghud");
	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	SendClientMessage(playerid, COLOR_STAT1, "Visite a seção Documentação de recursos no fórum ou digite /helpme para obter mais ajuda");
	return true;
}*/

CMD:regras(playerid, params[])
{
	//SendClientMessage(playerid, COLOR_GRAD3, "Você pode saber mais sobre as regras do nosso servidor em www.ls-rp.com.br");
	SendClientMessage(playerid, COLOR_LIGHTRED, "__________________ Los Santos Roleplay __________________");
	SendClientMessage(playerid, COLOR_LIGHTRED, "Regras do Servidor");
	SendClientMessage(playerid, COLOR_WHITE, "As regras podem ser encontradas no site abaixo. Você já aceitou as regras ao se registrar...");
	SendClientMessage(playerid, COLOR_WHITE, "https://wiki.ls-rp.com.br");
	return true;
}

CMD:pkr(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GRAD3, "Sitema de poker esta offline.");
	return true;
}

CMD:ajudadrogas(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "Drug Commands:");
	SendClientMessage(playerid, COLOR_WHITE, "/mydrugs - /givedrug - /dropdrug - /usedrug");
	SendClientMessage(playerid, COLOR_WHITE, "/placedrug (/pd) - /placealldrugs (pad) - /takedrug (/td) - /takealldrugs (/tad)");
	SendClientMessage(playerid, COLOR_WHITE, "/checkdrugs - /transferdrug - /buildpackage - /adjustpackage - /givealldrugs - /vehdrugs");
	return true;
}

CMD:ajudaradio(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "|_____________________Ajuda Rádio______________________|");
	SendClientMessage(playerid, COLOR_YELLOW, "DICA: Você pode comprar rádio em uma 24-7's!");
	SendClientMessage(playerid, COLOR_WHITE, "/setchannel - Sets which channel you want on which slot.");
	SendClientMessage(playerid, COLOR_WHITE, "/setslot - Sets which slot on your radio you're currently responding too.");
	SendClientMessage(playerid, COLOR_WHITE, "/r - Talk over radio, in the channel you've set.");
	SendClientMessage(playerid, COLOR_WHITE, "/call 1000 - To rent a radio channel!");
	SendClientMessage(playerid, COLOR_WHITE, "/part - To part the radio channel you're currently in.");
	SendClientMessage(playerid, COLOR_WHITE, "/kickoffradio - Kick someone from a radio frequency that you have ownership over.");

	new channels[128], count;

	for(new i = 1; i < PlayerData[playerid][pRadio]; ++i)
	{
	    if(PlayerData[playerid][pRadioChan][i] >= 1)
	    {
	        if(!IsNumeric(ReturnChannelName(PlayerData[playerid][pRadioChan][i])))
				format(channels, 128, "%s[Slot %d: %s (%d)]", channels, i, ReturnChannelName(PlayerData[playerid][pRadioChan][i]), PlayerData[playerid][pRadioChan][i]);
			else
			    format(channels, 128, "%s[Slot %d: (%d)]", channels, i, PlayerData[playerid][pRadioChan][i]);

			count++;
	    }
	}

	if(count > 0) SendClientMessageEx(playerid, COLOR_WHITE, "Your current channels: {33AA33}%s", channels);

	SendClientMessage(playerid, COLOR_GREEN, "|_____________________________________________________|");
	return true;
}

CMD:nota(playerid, params[])
{
	SendClientMessage(playerid, COLOR_YELLOW2, "USE: /nota [ação]");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Mostrar] /note mostrar [notaID] [PlayerID / Nome]  (* You may not type in NoteID and PlayerID)");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Criar] /nota criar [texto]");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Deletar] /nota deletar [número 1-5]");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Entregar] /nota entregar [número 1-5] [PlayerID / Nome]");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Deixr]: /note deixar [número 1-5]");
	SendClientMessage(playerid, COLOR_YELLOW2, "[Adicionar]: /nota adicionar [número 1-5] [texto]");
	SendClientMessage(playerid, COLOR_YELLOW2, "____________________________________________________");
	SendClientMessage(playerid, COLOR_YELLOW2, "Você não tem nenhuma nota ( /nota ).");
	return true;
}

YCMD:ajudapacote(playerid, params[], help) = ajudaarmas;

CMD:ajudaarmas(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "Comandos de pacotes de armas:");
	SendClientMessage(playerid, COLOR_WHITE, "/desempacotar - /venderpacote (/vp) - /colocarpacote (/cp) - /colocarpacotetodos (/cpt)");
	SendClientMessage(playerid, COLOR_WHITE, "/pegarpacote (/pp) - /pegarpacotetodos (/ppt) - /meupacote - /vpacote");
	SendClientMessage(playerid, COLOR_WHITE, "/dropararma (/da) - /pegararma (/pa) - /dropgun - /colocar - /pegar");
	SendClientMessage(playerid, COLOR_WHITE, "/entregartodospacotes - /entregararma");
	return true;
}

CMD:ajudapesca(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	SendClientMessage(playerid, COLOR_CYAN2, "/meuspeixes /irpescar /pescar /pararpesca /descarregarpeixe");
	return true;
}

CMD:ajudalicenca(playerid, params[])
{
    SendClientMessage(playerid, COLOR_LIGHTRED, "Comandos de licenças:");
    SendClientMessage(playerid, COLOR_WHITE, "/licencas /examelicenca");
	return true;
}

CMD:ajudaemprego(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	SendClientMessage(playerid, COLOR_GRAD3, "O seu trabalho principal é:");
	SendClientMessageEx(playerid,COLOR_GRAD3, "%s", ReturnJobName(playerid, PlayerData[playerid][pJob]));

	if(PlayerData[playerid][pSideJob])
	{
		SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
		SendClientMessage(playerid, COLOR_GRAD3, "O seu trabalho secundário é:");
		SendClientMessageEx(playerid,COLOR_GRAD3, "%s", ReturnJobName(playerid, PlayerData[playerid][pSideJob]));
	}

	if(PlayerData[playerid][pJob] == JOB_MECHANIC || PlayerData[playerid][pSideJob] == JOB_MECHANIC)
	{
		if(PlayerData[playerid][pSideJob] == JOB_MECHANIC) SendClientMessage(playerid,COLOR_LIGHTRED, "Car Mechanic Commands [SIDE JOB]");
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Car Mechanic Commands:");

		SendClientMessage(playerid, COLOR_WHITE, "/buycomp - /checkcomponents - /service - /paintcar");
		SendClientMessage(playerid, COLOR_WHITE, "/colorlist - /attach - /detach");
	}

	if(PlayerData[playerid][pJob] == JOB_TAXI || PlayerData[playerid][pSideJob] == JOB_TAXI)
	{
	    if(PlayerData[playerid][pSideJob] == JOB_TAXI) SendClientMessage(playerid, COLOR_LIGHTRED, "Taxi Driver Commands [SIDE JOB]");
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Taxi Driver Commands:");

		SendClientMessage(playerid, COLOR_WHITE, "/taxi [accept / duty / fare / start / stop]");
	}

	if(PlayerData[playerid][pJob] == JOB_WPDEALER)
	{
	    SendClientMessage(playerid, COLOR_GRAD1, "Comandos:");
		SendClientMessage(playerid, COLOR_GRAD1, "/venderpacote (/vp)");
		SendClientMessage(playerid, COLOR_GRAD1, "/colocarpacote (/cp)");
		SendClientMessage(playerid, COLOR_GRAD1, "/pegarpacote (/pp)");
		SendClientMessage(playerid, COLOR_GRAD1, "/colocarpacotetodos (/cpt)");
		SendClientMessage(playerid, COLOR_GRAD1, "/pegarpacotetodos (/ppt)");
		SendClientMessage(playerid, COLOR_GRAD1, "/dealinghelp");
		SendClientMessage(playerid, COLOR_GRAD1, "/meupacote");
		SendClientMessage(playerid, COLOR_GRAD1, "/vpacote");

	}

	if(PlayerData[playerid][pJob] == JOB_SUPPLIER)
	{
		SendClientMessage(playerid, COLOR_WHITE, "/buyweapon - /venderpacote (vp) - /colocarpacote (/cp) - /pegarpacote (/pp)");
		SendClientMessage(playerid, COLOR_WHITE, "/colocarpacotetodos (/cpt) - /pegarpacotetodos (/ppt) - /meupacote - /vpacote");
	}

	if(PlayerData[playerid][pJob] == JOB_FARMER)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "Farmer Commands:");
		SendClientMessage(playerid, COLOR_WHITE, "/harvest");
		SendClientMessage(playerid, COLOR_WHITE, "/stopharvest");
	}

	if(PlayerData[playerid][pJob] == JOB_TRUCKER)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Read documentation on forums:");
		SendClientMessage(playerid, COLOR_GRAD1, "Server Information -> Feature Documentation -> Trucker Career");
		SendClientMessage(playerid, COLOR_GRAD1, "(http://forum.ls-rp.com.br)");
		SendClientMessage(playerid, COLOR_GRAD2, "You need to own a pickup, a van or a truck to perform this job.");

		SendClientMessage(playerid, COLOR_YELLOW, "Commands:{FFFFFF} Use{FFFF00} /cargo{FFFFFF} to see a list of available actions.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commands:{FFFFFF} Use{FFFF00} /tpda{FFFFFF} to show a trucker's PDA with information.");
		SendClientMessage(playerid, COLOR_YELLOW, "Commands:{FFFFFF} Use{FFFF00} /industry{FFFFFF} to show a trucker's PDA with information.");

		//if(PlayerData[playerid][pCareer]) SendClientMessageEx(playerid, COLOR_WHITE, "You have %d career hours.", PlayerData[playerid][pCareer]);

		SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	}

	SendNoticeMessage(playerid, "You have logged 0 hours on this job.");
	return true;
}

// /localtime COLOR_LIGHTRED %s changed the local time to %d hours.

CMD:ajudaempresa(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Comandos disponíveis para empresas:");
	SendClientMessage(playerid, COLOR_WHITE, " /bizinfo /compprice /bizfee /hire /fire /trancar");
	SendClientMessage(playerid, COLOR_WHITE, " /sellbiz /bizwithdraw /bizupgrade /bizbank");
	SendClientMessage(playerid, COLOR_WHITE, " /comida config");
	return true;
}

CMD:ajudacasa(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Comandos disponíveis para casas:");
	SendClientMessage(playerid, COLOR_WHITE, " /entrar /sair /trancar /casa /minhacasa /bater /campainha");
	SendClientMessage(playerid, COLOR_WHITE, " /casaupgrade /mobilia /mobiliaperm /cmdspot /ofereceraluguel");
	SendClientMessage(playerid, COLOR_WHITE, " /aluguel /precoaluguel /despejartodos /inquilinos /despejar");
	SendClientMessage(playerid, COLOR_WHITE, " /chavescasa /darchave /pegarchave");
	return true;
}

CMD:ajudacelular(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "Phone Commands:");
	SendClientMessage(playerid, COLOR_WHITE, "/c(all) - /p(ickup) - /h(angup) - /ph(one)");
	SendClientMessage(playerid, COLOR_WHITE, "/text - /txt - /sms - /loudspeaker - /dropcell - /selfie - /passcall");
	SendClientMessage(playerid, COLOR_WHITE, "/phone switch - /burnerhelp");
	return true;
}

CMD:ajudaroupas(playerid, params[])
{
    //SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");

	//SendClientMessage(playerid, COLOR_WHITE,"*** HELP *** Type the commands for additional assistance.");
	SendClientMessage(playerid, COLOR_WHITE,"{FFFF00}/ROUPAS {FFFFFF}para acessar a interface.");
	SendClientMessage(playerid, COLOR_WHITE,"Como excluir itens de roupa? {FFFF00}/roupas dropar [Slot ID]{FFFFFF}. É solicitada a confirmação.");
	SendClientMessage(playerid, COLOR_WHITE,"Se você for um um doador prata, você pode recuperar a última posição salva de uma peça de roupa que você perdeu. (/roupas recover)");
	SendClientMessage(playerid, COLOR_LIGHTRED,"[ ! ]{FFFFFF} Your clothing items are lost when you /aceitarmorte.");

	//SendClientMessage(playerid, COLOR_GRAD3,"/roupas [ação]");
	//SendClientMessage(playerid, COLOR_GRAD4, "Ações disponíveis: (c)olocar, (d)ropar, (a)justar, (e)ntregar");
	return true;
}

YCMD:passjoint(playerid, params[], help) = passcig;

CMD:passcig(playerid, params[])
{
	new userid, emote[64];

	if(sscanf(params, "uS()[64]", userid, emote))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /passcig [id/nome] [opcional: ação/emote]");

	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_SMOKE_CIGGY)
	    return SendErrorMessage(playerid, "You aren't smoking anything.");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid playerid/partOfName.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Not close enough.");

	if(GetPlayerState(userid) != PLAYER_STATE_ONFOOT || GetPlayerSpecialAction(userid) != SPECIAL_ACTION_NONE)
	    return SendErrorMessage(playerid, "You can't do this now. They need to be on foot and unoccupied.");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_SMOKE_CIGGY);

	if(!strlen(emote)) SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s passes their cigarette / joint to %s.", ReturnName(playerid, 0), ReturnName(userid, 0));
	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s %s", ReturnName(playerid, 0), emote);

	SendClientMessageEx(playerid, COLOR_YELLOW, "Your cigarette / joint was passed to %s.", ReturnName(userid, 0));
	SendClientMessageEx(userid, COLOR_YELLOW, "%s has passed their cigarette / joint to you.", ReturnName(playerid, 0));
	return true;
}

CMD:pitems(playerid, params[])
{
    SendClientMessage(playerid, 0x7e98b6FF, "{7e98b6}[ ! ] {a9c4e4}Você não tem itens de prisão.");
	return true;
}

YCMD:cig(playerid, params[], help) = cigarette;
YCMD:cigs(playerid, params[], help) = cigarette;

CMD:cigarette(playerid, params[])
{
	new oneString[30], secString[90], thirdString[30];

	if(sscanf(params, "s[30]S()[90]S()[90]", oneString, secString, thirdString))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You have %d cigarettes on you.", PlayerData[playerid][pCigarettes]);
		SendClientMessageEx(playerid, COLOR_WHITE, "{7e98b6}[ ! ] Usage: {a9c4e4}/cigarettes use, give, drop & /passjoint");
		return true;
	}

	if(!strcmp(oneString, "use"))
	{
		if(!PlayerData[playerid][pCigarettes])
		    return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You don't have any cigarettes left.");

        PlayerData[playerid][pCigarettes] --;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
        
        Annotation(playerid, "smokes a cigarette.");
		SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}Press ENTER to stop smoking.");
	}
	else if(!strcmp(oneString, "give"))
	{
	    new
			userid,
			amount,
			str[60 + MAX_PLAYER_NAME]
		;

		if(sscanf(secString, "u", userid))
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] Usage: {a9c4e4}/cigarettes give [id/nome] [Amount (default: 1)]");

		if(!IsPlayerConnected(userid))
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}Invalid player.");

		if(playerid == userid)
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You're that player.");

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You aren't close enough to them.");

		if(sscanf(thirdString, "i", amount))
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] Usage: {a9c4e4}/cigarettes give [id/nome] [Amount (default: 1)]");

		if(amount < 1)
		    return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}Invalid amount.");

		if(amount > PlayerData[playerid][pCigarettes])
		    return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You don't have that amount.");

        PlayerData[playerid][pCigarettes] -= amount;
        PlayerData[userid][pCigarettes] += amount;

		format(str, sizeof(str), "gave cigarettes to %s.", ReturnName(userid, 0));
		Annotation(playerid, str);

        SendClientMessageEx(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You gave %d cigarettes to %s.", amount, ReturnName(userid));
        SendClientMessageEx(userid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}%s gave you %d cigarettes.", ReturnName(playerid), amount);
	}
	else if(!strcmp(oneString, "drop"))
	{
	    new
			amount
		;

		if(sscanf(secString, "i", amount))
			return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] Usage: {a9c4e4}/cigarettes drop [Amount]");

		if(amount < 1 || amount > PlayerData[playerid][pCigarettes])
		    return SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}Invalid amount or you just don't have that many to give.");

        PlayerData[playerid][pCigarettes] -= amount;

        Annotation(playerid, "drops their cigarettes.");
		SendClientMessage(playerid, COLOR_WHITE, "{7e98b6}[ ! ] {a9c4e4}You dropped 1 cigarettes.");
	}
	return true;
}

//Drug System

YCMD:vehdrugs(playerid, params[], help) = checkdrugs;

CMD:checkdrugs(playerid, params[])
{
	new
		carid
	;

	if(sscanf(params, "d", carid) || PlayerData[playerid][pAdmin] < 1)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

		return ShowVehicleDrugs(GetPlayerVehicleID(playerid), playerid);
	}

	if(!IsValidVehicle(carid))
	    return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	ShowVehicleDrugs(carid, playerid);
	return true;
}

stock ShowVehicleDrugs(vehicleid, playerid)
{
	new
	    count
	;

	SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s's Drugs:", ReturnVehicleName(vehicleid));

	for(new d = 0; d < MAX_DRUG_SLOT; ++d)
	{
		if(Vehicle_Drugs[vehicleid][d][drug_amount] > 0.0)
		{
			SendClientMessageEx(playerid, -1, "{FF6347}[ {FFFFFF}%d. %s (%s: %.1f%s / %.1f%s) (Strength: %.0f) {FF6347}]",
			d + 1, s_NAMES[ Vehicle_Drugs[vehicleid][d][drug_storage] ], d_DATA[ Vehicle_Drugs[vehicleid][d][drug_type] ][dName], Vehicle_Drugs[vehicleid][d][drug_amount],
			(d_DATA[ Vehicle_Drugs[vehicleid][d][drug_type] ][IsPill] == true) ? (" Pills") : ("g"), ReturnStorageCapacity(Vehicle_Drugs[vehicleid][d][drug_storage],
			Vehicle_Drugs[vehicleid][d][drug_type]), (d_DATA[ Vehicle_Drugs[vehicleid][d][drug_type] ][IsPill] == true) ? (" Pills") : ("g"), Vehicle_Drugs[vehicleid][d][drug_strength]);

			count++;
		}
	}

	if(!count) return SendClientMessage(playerid, COLOR_WHITE, "No drugs to show.");

	SendNoticeMessage(playerid, "You can take a drug from the vehicle with /takedrug.");
	return true;
}

YCMD:tad(playerid, params[], help) = takealldrugs;

CMD:takealldrugs(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new count = 0, vehicleid = GetPlayerVehicleID(playerid);

 	if(Car_GetID(vehicleid) == -1)
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	for(new i = 0; i < MAX_DRUG_SLOT; ++i)
	{
	    if(Vehicle_Drugs[vehicleid][i][drug_amount] > 0.0)
	    {
			SendClientMessageEx(playerid, COLOR_YELLOW, "You have taken a %s of %s (%.1f%s) from the %s.", s_NAMES[ Vehicle_Drugs[vehicleid][i][drug_storage] ], d_DATA[ Vehicle_Drugs[vehicleid][i][drug_type] ][dName], Vehicle_Drugs[vehicleid][i][drug_amount], (d_DATA[ Vehicle_Drugs[vehicleid][i][drug_type] ][IsPill] == true) ? (" Pills") : ("g"), ReturnVehicleName(vehicleid));

			RefundPlayerDrug(playerid, Vehicle_Drugs[vehicleid][i][drug_type], Vehicle_Drugs[vehicleid][i][drug_amount], Vehicle_Drugs[vehicleid][i][drug_strength], Vehicle_Drugs[vehicleid][i][drug_storage]);

			RemoveVehicleDrug(vehicleid, i);

            count++;
	    }
	}

	if(!count) return SendErrorMessage(playerid, "No drugs found.");

	format(sgstr, sizeof(sgstr), "* %s makes movements inside the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 30.0, 6000);
	return true;
}

YCMD:td(playerid, params[], help) = takedrug;

CMD:takedrug(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new package, vehicleid = GetPlayerVehicleID(playerid);

	if(Car_GetID(vehicleid) == -1)
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	if(sscanf(params, "d", package))
	    return SendSyntaxMessage(playerid, "/takedrug [slot]");

	if(package < 1 || package > 10)
	    return SendErrorMessage(playerid, "PacoteID inválido.");

	if(Vehicle_Drugs[vehicleid][package - 1][drug_amount] <= 0.0)
	    return SendErrorMessage(playerid, "That drug slot is empty.");

	format(sgstr, sizeof(sgstr), "* %s makes movements inside the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 30.0, 6000);

	SendClientMessageEx(playerid, COLOR_YELLOW, "You have taken a %s of %s (%.1f%s) from the %s.", s_NAMES[ Vehicle_Drugs[vehicleid][package - 1][drug_storage] ], d_DATA[ Vehicle_Drugs[vehicleid][package - 1][drug_type] ][dName], Vehicle_Drugs[vehicleid][package - 1][drug_amount], (d_DATA[ Vehicle_Drugs[vehicleid][package - 1][drug_type] ][IsPill] == true) ? (" Pills") : ("g"), ReturnVehicleName(vehicleid));

	RefundPlayerDrug(playerid, Vehicle_Drugs[vehicleid][package - 1][drug_type], Vehicle_Drugs[vehicleid][package - 1][drug_amount], Vehicle_Drugs[vehicleid][package - 1][drug_strength], Vehicle_Drugs[vehicleid][package - 1][drug_storage]);

	RemoveVehicleDrug(vehicleid, package - 1);
	return true;
}

YCMD:pad(playerid, params[], help) = placealldrugs;

CMD:placealldrugs(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new count = 0, vehicleid = GetPlayerVehicleID(playerid);

	if(Car_GetID(vehicleid) == -1)
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	if(IsABicycle(vehicleid) || IsABike(vehicleid))
	    return SendErrorMessage(playerid, "You can't do this on a bike.");

	for(new i = 0; i < MAX_DRUG_SLOT; ++i)
	{
	    if(Player_Drugs[playerid][i][dID] != -1)
	    {
			SendClientMessageEx(playerid, COLOR_YELLOW, "You've put a %s of %s (%.1f%s) in the %s.", s_NAMES[ Player_Drugs[playerid][i][dStorage] ], d_DATA[ Player_Drugs[playerid][i][dType] ][dName], Player_Drugs[playerid][i][dAmount], (d_DATA[ Player_Drugs[playerid][i][dType] ][IsPill] == true) ? (" Pills") : ("g"), ReturnVehicleName(vehicleid));

		    InsertVehicleDrug(vehicleid, Player_Drugs[playerid][i][dType], Player_Drugs[playerid][i][dAmount], Player_Drugs[playerid][i][dStrength], Player_Drugs[playerid][i][dStorage], Player_Drugs[playerid][i][dStamp]);

			RemovePlayerDrug(playerid, i);

            count++;
	    }
	}

	if(!count) return SendErrorMessage(playerid, "You've got no drugs on you.");

	format(sgstr, sizeof(sgstr), "* %s makes movements inside the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 30.0, 6000);
	return true;
}

YCMD:pd(playerid, params[], help) = placedrug;

CMD:placedrug(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new package, vehicleid = GetPlayerVehicleID(playerid);

	if(Car_GetID(vehicleid) == -1)
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	if(IsABicycle(vehicleid) || IsABike(vehicleid))
	    return SendErrorMessage(playerid, "You can't do this on a bike.");

	if(sscanf(params, "d", package))
	    return SendSyntaxMessage(playerid, "/placedrug [package ID]");

	if(package < 1 || package > 10)
	    return SendErrorMessage(playerid, "PacoteID inválido.");

	package--;

	if(Player_Drugs[playerid][package][dAmount] <= 0.0)
	    return SendErrorMessage(playerid, "That drug slot is empty.");

	format(sgstr, sizeof(sgstr), "* %s makes movements inside the %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);

	SendClientMessageEx(playerid, COLOR_YELLOW, "You've put a %s of %s (%.1f%s) in the %s.", s_NAMES[ Player_Drugs[playerid][package][dStorage] ], d_DATA[ Player_Drugs[playerid][package][dType] ][dName], Player_Drugs[playerid][package][dAmount], (d_DATA[ Player_Drugs[playerid][package][dType] ][IsPill] == true) ? (" Pills") : ("g"), ReturnVehicleName(vehicleid));

    InsertVehicleDrug(vehicleid, Player_Drugs[playerid][package][dType], Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dStrength], Player_Drugs[playerid][package][dStorage], Player_Drugs[playerid][package][dStamp]);

	RemovePlayerDrug(playerid, package);
	return true;
}

CMD:mydrugs(playerid, params[])
{
    ShowPlayerDrugs(playerid, playerid);
    return true;
}

CMD:transferdrug(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "You cannot perform this action right now.");		

	new package;

	if(sscanf(params, "d", package))
	    return SendSyntaxMessage(playerid, "/transferdrug [package ID]");

	if(package < 1 || package > 10)
	    return SendErrorMessage(playerid, "PacoteID inválido.");

	if(Player_Drugs[playerid][package - 1][dAmount] <= 0.0)
	    return SendErrorMessage(playerid, "That drug slot is empty.");

	SetPVarInt(playerid, "d_TransferPackage", package - 1);

	Dialog_Show(playerid, Drug_Menu, DIALOG_STYLE_LIST, "Drug Transfer:", "{A9C4E4}Transfer to a new package\n{A9C4E4}Transfer to an existing package", "Select", "Exit");
	return true;
}

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None",
		id;

    if(model < 400 || model > 611)
	    return name;

	id = Car_GetID(vehicleid);

	if(id >= 0)
	{
	    if(strlen(CarData[id][carName]) > 0)
			format(name, sizeof(name), CarData[id][carName]);
	    else
			format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	}
	else format(name, sizeof(name), g_arrVehicleNames[model - 400]);

	return name;
}

stock isSmokable(drug)
{
	if(drug == 1)
		return true;

	return false;
}

stock ResetDrugBoost(playerid)
{
	PlayerData[playerid][pDrugBoost] = 0;
	PlayerData[playerid][pDrugEffects] = -1;
	PlayerData[playerid][pDrugTick] = 0;
}

//(1-20, 21-50, 51-75, 79-90, 91-99, 100)

CMD:usedrug(playerid, params[])
{
	if(IsBrutallyWounded(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new package, Float:amount;

	if(sscanf(params, "df", package, amount))
	    return SendSyntaxMessage(playerid, "/usedrug [package_id] [amount]");

	if(package < 1 || package > 10)
	    return SendErrorMessage(playerid, "PacoteID inválido.");

	if(Player_Drugs[playerid][package - 1][dAmount] <= 0.0)
		return SendErrorMessage(playerid, "You don't have a package in that slot.");

	if(amount < 0.1)
		return SendErrorMessage(playerid, "Invalid amount specified. Has to be more than 0.0.");

	if(amount > 0.3)	
		return SendErrorMessage(playerid, "Max usage limit is 0.3.");

	if(Player_Drugs[playerid][package - 1][dAmount] < amount)
	    return SendErrorMessage(playerid, "You don't have that much %s.", d_DATA[ Player_Drugs[playerid][package - 1][dType] ][dName]);

	new string[128];

	if(isSmokable(Player_Drugs[playerid][package - 1][dType]))
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

		SendNoticeMessage(playerid, "You can pass the joint to another player with /passjoint!");

		SendClientMessageEx(playerid, COLOR_YELLOW, "You've smoked some %s.", d_DATA[ Player_Drugs[playerid][package - 1][dType] ][dName]);
		
		format(string, sizeof(string), "* %s uses %s.", ReturnName(playerid, 0), d_DATA[ Player_Drugs[playerid][package - 1][dType] ][dName]);
	}
	else
	{
	    new boost;

	    switch(floatround(Player_Drugs[playerid][package - 1][dStrength]))
	    {
	        case 100:
				boost = randomEx(30, 40);
			case 91..99:
			    boost = randomEx(30, 35);
			case 79..90:
			    boost = randomEx(25, 30);
			case 51..78:
			    boost = randomEx(20, 25);
			case 21..50:
			    boost = randomEx(15, 20);
			case 1..20:
			    boost = randomEx(5, 10);
		}

		PlayerData[playerid][pDrugBoost] = boost;
		PlayerData[playerid][pDrugEffects] = Player_Drugs[playerid][package - 1][dType];
		PlayerData[playerid][pDrugTick] = 0;
		PlayerData[playerid][pDrugStamp] = gettime();

		SendClientMessageEx(playerid, COLOR_YELLOW, "You've taken %.1f%s of %s.", amount, (d_DATA[ Player_Drugs[playerid][package - 1][dType] ][IsPill] == true) ? (" Pills") : ("g"), d_DATA[ Player_Drugs[playerid][package - 1][dType] ][dName]);

        format(string, sizeof(string), "* %s takes %s.", ReturnName(playerid, 0), d_DATA[ Player_Drugs[playerid][package - 1][dType] ][dName]);
	}

	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);

	Player_Drugs[playerid][package - 1][dAmount] -= amount;

	if(Player_Drugs[playerid][package - 1][dAmount] < 0.1)
	{
		RemovePlayerDrug(playerid, package - 1);
	}
	else
	{
	    new query[128];
		mysql_format(dbCon, query, sizeof(query), "UPDATE `player_drugs` SET `drugAmount` = '%f' WHERE `idx` = '%d' LIMIT 1", Player_Drugs[playerid][package - 1][dAmount], Player_Drugs[playerid][package - 1][dID]);
		mysql_tquery(dbCon, query);
	}
	
	SQL_LogAction(playerid, string);
	return true;
}

YCMD:passdrug(playerid, params[], help) = givedrug;

CMD:givedrug(playerid, params[])
{
	if(PassingDrugs{playerid})
	    return SendErrorMessage(playerid, "Wait a second.");

	new userid, package;

	if(sscanf(params, "ud", userid, package))
	    return SendSyntaxMessage(playerid, "/givedrug [id/nome] [package_id]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(package < 1 || package > 10)
	    return SendErrorMessage(playerid, "PacoteID inválido.");

	package--;

	if(Player_Drugs[playerid][package][dAmount] <= 0.0)
		return SendErrorMessage(playerid, "You don't have a package in that slot.");

	if(playerid == userid)
	    return SendErrorMessage(playerid, "You can't pass drugs to yourself.");

	new package_id = -1;

	for(new i = 0; i < MAX_PLAYER_DRUGS; ++i)
	{
	    if(Player_Drugs[userid][i][dID] == -1)
	    {
	        package_id = i;
	        break;
		}
	}

	if(package_id == -1)
	    return SendErrorMessage(playerid, "That player has no drug slots left.");

    PassingDrugs{playerid} = true;

    SendClientMessageEx(userid, COLOR_YELLOW, "%s has given you a %s (%s).", ReturnName(playerid, 0), s_NAMES[ Player_Drugs[playerid][package][dStorage] ], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);
    SendClientMessageEx(playerid, COLOR_YELLOW, "You have given %s a %s (%s).", ReturnName(userid, 0), s_NAMES[ Player_Drugs[playerid][package][dStorage] ], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);

    RefundPlayerDrug(userid, Player_Drugs[playerid][package][dType], Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dStrength], Player_Drugs[playerid][package][dStorage], Player_Drugs[playerid][package][dStamp]);

    SQL_LogAction(playerid, "Gave %s a %s (%.2f, %.0f)", ReturnName(userid), d_DATA[ Player_Drugs[playerid][package][dType] ][dName], Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dStrength]);
    SQL_LogAction(userid, "%s gave %s (%.2f, %.0f)", ReturnName(playerid), d_DATA[ Player_Drugs[playerid][package][dType] ][dName], Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dStrength]);

	RemovePlayerDrug(playerid, package);

	PassingDrugs{playerid} = false;
	return true;
}

stock ShowPlayerWeapons(playerid, toplayer)
{
	SendClientMessageEx(toplayer, COLOR_GREEN, "_______Pacote de armas de %s:_______", ReturnName(playerid, 0));

	new
	    count,
	    total_weapons,
	    string[256],
	    str[128]
	;

	for(new i = 0; i < MAX_PLAYER_WEAPON_PACKAGE; ++i)
	{
		if(PlayerData[playerid][pPackageWP][i] > 0)
		{
			format(str, sizeof(str), "[  %d. %s (%d/%d)  ]", i + 1, GetWeaponPackageName(PlayerData[playerid][pPackageWP][i]), PlayerData[playerid][pPackageAmmo][i], GetWeaponPackage(g_aWeaponSlots[PlayerData[playerid][pPackageWP][i]]));
			strcat(string, str);

            count++;

			if(count == 2)
			{
			    SendClientMessage(toplayer, COLOR_WHITE, string);

			    string[0] = EOS;

			    count = 0;
			}

			total_weapons++;
		}
	}

	if(strlen(string) > 0) SendClientMessage(toplayer, COLOR_WHITE, string);

	if(!total_weapons) SendClientMessage(toplayer, COLOR_WHITE, "Este jogador não tem pacotes de armas.");

	return true;
}

CMD:meupacote(playerid, params[])
{
	new
		userid
	;

	if(sscanf(params, "u", userid))
		return ShowPlayerWeapons(playerid, playerid);

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{ds[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

    ShowPlayerWeapons(playerid, userid);
	return true;
}

CMD:desempacotar(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "You cannot perform this action right now.");	

	if(PlayerData[playerid][pLevel] < 2)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER:Sorry, only level 2 and up.");

	new slot;

	if(sscanf(params, "d", slot))
	    return SendSyntaxMessage(playerid, "/desempacotar [slot]");

	if(slot < 1 || slot > MAX_PLAYER_WEAPON_PACKAGE)
	    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Invalid package slot. Must be 1-%d.", MAX_PLAYER_WEAPON_PACKAGE); //PacoteID inválido specified.

	slot--;

    if(!PlayerData[playerid][pPackageWP][slot])
    	return SendErrorMessage(playerid, "There's nothing in that slot.");

	if(!IsPlayerInAnyVehicle(playerid) && PlayerData[playerid][pLocal] == 255)
	    return SendErrorMessage(playerid, "You must be inside a vehicle or an interior.");

	if(Unpackaging{playerid})
	    return SendErrorMessage(playerid, "You're already unpackaging something.");

    GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

    new delay;

    switch(PlayerData[playerid][pPackageWP][slot])
    {
        case 30, 31, 33, 34:
            delay = 10;
		case 25, 26, 27:
			delay = 3;
		default:
		    delay = 3;
    }

	format(sgstr, sizeof(sgstr), "* %s begins to unpackage a weapon.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 30.0, 6000);

	SendNoticeMessage(playerid, "Your %s is being unpackaged, this will take %d seconds - do not move.", GetWeaponPackageName(PlayerData[playerid][pPackageWP][slot]), delay);

    Unpackaging{playerid} = true;

	UnpackageTimer[playerid] = SetTimerEx("WeaponUnpackaged", delay * 1000, false, "ddd", playerid, slot, PlayerData[playerid][pID]);
	return true;
}

FUNX::WeaponUnpackaged(playerid, slot, sqlid)
{
	if(!Unpackaging{playerid}) return false;

	if(!IsPlayerConnected(playerid)) return false;

	if(!Spawned{playerid}) return false;

	if(PlayerData[playerid][pID] != sqlid) return false;

	if((slot < 0 || slot >= MAX_PLAYER_WEAPON_PACKAGE) || !PlayerData[playerid][pPackageWP][slot]) return false;

	new
	    weaponid = PlayerData[playerid][pPackageWP][slot],
	    ammo = PlayerData[playerid][pPackageAmmo][slot]
	;

	PlayerData[playerid][pPackageWP][slot] = 0;
	PlayerData[playerid][pPackageAmmo][slot] = 0;

	if(weaponid == 47)
	{
		SetPlayerArmourEx(playerid, 50);
	}
	else
	{
		GivePlayerValidWeapon(playerid, weaponid, ammo);
	}

	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(weaponid == 24)
	    {
	        SetPlayerArmedWeapon(playerid, 0);
	    }
	}

	SendNoticeMessage(playerid, "You've unpackaged your %s; you can pass it to another player with /entregararma.", ReturnWeaponName(weaponid));

	Unpackaging{playerid} = false;

	Player_SavePackage(playerid);
	return true;
}

YCMD:cp(playerid, params[], help) = colocarpacote;

CMD:colocarpacote(playerid, params[])
{
	new slot;

	if(sscanf(params, "d", slot))
	    return SendSyntaxMessage(playerid, "/colocarpacote [slot]");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid), carid = -1;

	if(slot < 1 || slot > MAX_PLAYER_WEAPON_PACKAGE)
	    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Invalid package slot. Must be 1-%d.", MAX_PLAYER_WEAPON_PACKAGE);

	slot--;

    if(!PlayerData[playerid][pPackageWP][slot])
    	return SendErrorMessage(playerid, "There's nothing in that slot.");
    	
	if((carid = Car_GetID(vehicleid)) == -1)
	    return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

	new
		free_slot = FindFreeCarPackageSlot(carid)
	;

	if(free_slot == -1)
	    return SendErrorMessage(playerid, "No space left in the vehicle.");

    CarData[carid][carPackageWP][free_slot] = PlayerData[playerid][pPackageWP][slot];
    CarData[carid][carPackageAmmo][free_slot] = PlayerData[playerid][pPackageAmmo][slot];

	PlayerData[playerid][pPackageWP][slot] = 0;
	PlayerData[playerid][pPackageAmmo][slot] = 0;

    SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've stored a %s and %d ammo inside the vehicle.", GetWeaponPackageName(CarData[carid][carPackageWP][free_slot]), CarData[carid][carPackageAmmo][free_slot]);

    Player_SavePackage(playerid);
    Car_SavePackage(carid);
	return true;
}

YCMD:cpt(playerid, params[], help) = colocarpacotetodos;

CMD:colocarpacotetodos(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid), bool:success, carid = -1, weapon_count;

	if((carid = Car_GetID(vehicleid)) == -1)
	    return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

	for(new slot = 0; slot != MAX_PLAYER_WEAPON_PACKAGE; ++slot)
	{
		if(PlayerData[playerid][pPackageWP][slot] > 0)
		{
		    success = true;

			for(new vehslot = 0; vehslot != MAX_CAR_WEAPON_PACKAGE; ++vehslot)
			{
   				if(!CarData[carid][carPackageWP][vehslot])
				{
					weapon_count++;

				    CarData[carid][carPackageWP][vehslot] = PlayerData[playerid][pPackageWP][slot];
				    CarData[carid][carPackageAmmo][vehslot] = PlayerData[playerid][pPackageAmmo][slot];

					PlayerData[playerid][pPackageWP][slot] = 0;
					PlayerData[playerid][pPackageAmmo][slot] = 0;
                    break;
				}
			}
		}
	}

	if(!success)
	    return SendErrorMessage(playerid, "You don't have any weapon packages on you.");

	if(weapon_count)
	{
		SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've stored %d weapons inside the vehicle.", weapon_count);

	    Player_SavePackage(playerid);
	    Car_SavePackage(carid);
	}
	else SendErrorMessage(playerid, "No space left in the vehicle.");

	return true;
}

YCMD:pp(playerid, params[], help) = pegarpacote;

CMD:pegarpacote(playerid, params[])
{
	new vehslot, string[10];

	if(sscanf(params, "dS()[10]", vehslot, string))
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /pegarpacote(/pp) [vehicle slot] ([slot])");
		SendClientMessage(playerid, COLOR_LIGHTRED, "HINT: If you don't input [slot] it will put contents of vehicle package's slot in your package's empty slot.");
		return true;
	}

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid), carid = -1;

	if(vehslot < 1 || vehslot > MAX_CAR_WEAPON_PACKAGE)
	    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Invalid package slot. Must be 1-%d.", MAX_CAR_WEAPON_PACKAGE);

    vehslot--;

	if((carid = Car_GetID(vehicleid)) == -1)
	    return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

  	if(!CarData[carid][carPackageWP][vehslot])
  		return SendErrorMessage(playerid, "There's nothing in that slot.");

	new
		free_slot
	;

	if(sscanf(string, "d", free_slot))
	{
		free_slot = FindFreePackageSlot(playerid);

		if(free_slot == -1)
		    return SendErrorMessage(playerid, "You don't have any free slots left.");
	}
	else
	{
		if(free_slot < 1 || free_slot > MAX_PLAYER_WEAPON_PACKAGE)
		    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Invalid package slot. Must be 1-%d.", MAX_PLAYER_WEAPON_PACKAGE);

		free_slot--;

		if(PlayerData[playerid][pPackageWP][free_slot])
		    return SendErrorMessage(playerid, "That slot is occupied.");
	}


	PlayerData[playerid][pPackageWP][free_slot] = CarData[carid][carPackageWP][vehslot];
	PlayerData[playerid][pPackageAmmo][free_slot] = CarData[carid][carPackageAmmo][vehslot];

	CarData[carid][carPackageWP][vehslot] = 0;
	CarData[carid][carPackageAmmo][vehslot] = 0;

	SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've taken %s and %d ammo from the vehicle.", GetWeaponPackageName(PlayerData[playerid][pPackageWP][free_slot]), PlayerData[playerid][pPackageAmmo][free_slot]);

	Player_SavePackage(playerid);
	Car_SavePackage(carid);
	return true;
}

YCMD:ppt(playerid, params[], help) = pegarpacotetodos;

CMD:pegarpacotetodos(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid), bool:success, carid = -1, found;

	if((carid = Car_GetID(vehicleid)) == -1)
	    return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

	for(new i = 0; i != MAX_CAR_WEAPON_PACKAGE; ++i)
	{
		if(CarData[carid][carPackageWP][i] != 0)
		{
		    found++;

			new
				free_slot = FindFreePackageSlot(playerid)
			;

			if(free_slot == -1) continue;

			PlayerData[playerid][pPackageWP][free_slot] = CarData[carid][carPackageWP][i];
			PlayerData[playerid][pPackageAmmo][free_slot] = CarData[carid][carPackageAmmo][i];

			CarData[carid][carPackageWP][i] = 0;
			CarData[carid][carPackageAmmo][i] = 0;

            success = true;
		}
	}

	if(success)
	{
	    SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've taken %d weapons from the vehicle.", found);

		Player_SavePackage(playerid);
		Car_SavePackage(carid);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "Either there are no weapons in vehicle package or your package is full.");

	return true;
}

CMD:entregartodospacotes(playerid, params[])
{
	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/entregartodospacotes [id/nome/MaskID]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{dS()[64]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == playerid)
		return SendServerMessage(playerid, "You are not allowed to sell to yourself.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are too far from that person.");

	SetPVarInt(playerid, "SellingPackages", userid);

	format(sgstr, sizeof(sgstr), "Are you sure you want to give %s all your weapon packages?", ReturnName(userid, 0));
	ConfirmDialog(playerid, "Are You Sure?", sgstr, "OnPlayerGiveWeaponPackages");
	return true;
}

FUNX::OnPlayerGiveWeaponPackages(playerid, response)
{
    new userid = GetPVarInt(playerid, "SellingPackages");

    DeletePVar(playerid, "SellingPackages");

	if(response)
	{
	    if(!IsPlayerConnected(userid))
	        return SendErrorMessage(playerid, "The player has disconnected.");

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are too far from that person.");

		new count = 0, free_slot;

	    for(new slot = 0; slot < MAX_PLAYER_WEAPON_PACKAGE; ++slot)
	    {
	        if(PlayerData[playerid][pPackageWP][slot] != 0)
	        {
				free_slot = FindFreePackageSlot(userid);

				if(free_slot == -1)
				    return SendErrorMessage(playerid, "Player doesn't have any free slots left.");

				PlayerData[userid][pPackageWP][free_slot] = PlayerData[playerid][pPackageWP][slot];
				PlayerData[userid][pPackageAmmo][free_slot] = PlayerData[playerid][pPackageAmmo][slot];

				PlayerData[playerid][pPackageWP][slot] = 0;
				PlayerData[playerid][pPackageAmmo][slot] = 0;

				format(sgstr, sizeof(sgstr), "* %s gives %s [not finalized] to %s.", ReturnName(playerid, 0), GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), ReturnName(userid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);

				SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've given %s and %d ammo to %s.", GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), PlayerData[userid][pPackageAmmo][free_slot], ReturnName(userid, 0));
			  	SendClientMessageEx(userid, COLOR_GREEN, "[Package] You've received %s and %d ammo from %s.", GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), PlayerData[userid][pPackageAmmo][free_slot], ReturnName(playerid, 0));

			  	count++;
			}
	    }

	    if(count)
	    {
			Player_SavePackage(userid);
			Player_SavePackage(playerid);
	    }
	    else SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have any weapon packages.");
	}

	return true;
}

YCMD:vp(playerid, params[], help) = venderpacote;

CMD:venderpacote(playerid, params[])
{
	new userid, slot;

	if(sscanf(params, "ud", userid, slot))
	    return SendSyntaxMessage(playerid, "/venderpacote [id/nome] [slot]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{dS()[64]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == playerid)
		return SendServerMessage(playerid, "Você não tem permissão para vender para si mesmo.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você está muito longe dessa pessoa.");

	if(slot < 1 || slot > MAX_PLAYER_WEAPON_PACKAGE)
	    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Slot de pacote inválido. Must be 1-%d.", MAX_PLAYER_WEAPON_PACKAGE);

    slot--;

	if(!PlayerData[playerid][pPackageWP][slot])
     	return SendErrorMessage(playerid, "Você não tem nenhum pacote nesse slot.");

	new
		free_slot = FindFreePackageSlot(userid)
	;

	if(free_slot == -1)
	    return SendErrorMessage(playerid, "O jogador não tem mais slots livres.");

	PlayerData[userid][pPackageWP][free_slot] = PlayerData[playerid][pPackageWP][slot];
	PlayerData[userid][pPackageAmmo][free_slot] = PlayerData[playerid][pPackageAmmo][slot];

	PlayerData[playerid][pPackageWP][slot] = 0;
	PlayerData[playerid][pPackageAmmo][slot] = 0;

	format(sgstr, sizeof(sgstr), "* %s gives %s [not finalized] to %s.", ReturnName(playerid, 0), GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), ReturnName(userid, 0));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);

	SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've given %s and %d ammo to %s.", GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), PlayerData[userid][pPackageAmmo][free_slot], ReturnName(userid, 0));
  	SendClientMessageEx(userid, COLOR_GREEN, "[Package] You've received %s and %d ammo from %s.", GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), PlayerData[userid][pPackageAmmo][free_slot], ReturnName(playerid, 0));

	Player_SavePackage(userid);
	Player_SavePackage(playerid);

	//Log_Write("RawLogs/sellweapon.txt", "[%s] %s: sold a %s(%d) to %s", ReturnDate(), ReturnName(playerid), GetWeaponPackageName(PlayerData[userid][pPackageWP][free_slot]), PlayerData[playerid][pPackageAmmo][slot], ReturnName(playerid));
	return true;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(EnableTP{playerid})
	{
        if(!fX || !fY || !fZ) return true;

		LastTeleport[playerid] = gettime();

		SetPlayerPosFindZ(playerid, fX, fY, fZ);
	}
    return true;
}

//phone system

YCMD:ph(playerid, params[], help) = phone;

CMD:phone(playerid, params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

    if(DeathMode{playerid} || PlayerData[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	if(PlayerData[playerid][pPnumber])
	{
     	if(!PhoneOpen{playerid})
	    {
			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");

			Annotation(playerid, "takes out their phone.");

			ShowPlayerPhone(playerid);

			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Press ESC to go back to walking mode.");
		}
		else
		{
			ClosePlayerPhone(playerid, true);
	      	CancelSelectTextDraw(playerid);

			if(ph_menuid[playerid] != 7) RemovePlayerAttachedObject(playerid, 9);

			Annotation(playerid, "puts their phone away.");
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "   You do not have a phone");

	return true;
}

YCMD:phonecursor(playerid, params[], help) = pc;

CMD:pc(playerid, params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

	if(!PhoneOpen{playerid} && PlayerData[playerid][pPnumber] && !DeathMode{playerid} && !PlayerData[playerid][pInjured])
	{
		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");

		ShowPlayerPhone(playerid);

		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Press ESC to go back to walking mode.");
	}
	else SelectTextDraw(playerid, 0x58ACFAFF);

	return true;
}

YCMD:c(playerid, params[], help) = call;

CMD:call(playerid, params[])
{
	CallNumber(playerid, params);
	return true;
}

CMD:sms(playerid, params[])
{
	SendSMS(playerid, params);
	return true;
}

CMD:selfie(playerid, params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

    if(DeathMode{playerid} || PlayerData[playerid][pInjured] || Dialog_Opened(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

    OnPhoneClick_Selfie(playerid);
	return true;
}

CMD:dropcell(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	new query[128];

	if(PlayerData[playerid][pPnumber])
	{
	    format(query, sizeof(query), "DELETE FROM phone_contacts WHERE contactAdded = '%d'", PlayerData[playerid][pPnumber]); // Delete Contacts
		mysql_pquery(dbCon, query);

	    format(query, sizeof(query), "DELETE FROM phone_sms WHERE PhoneReceive = '%d'", PlayerData[playerid][pPnumber]); // Delete a message
		mysql_pquery(dbCon, query);

		if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
		{
			SendClientMessage(PlayerData[playerid][pCallLine], COLOR_GRAD2, "[ ! ] They hung up.");
			CancelCall(playerid);
		}

        PhoneSelfie_Stop(playerid);

     	PlayerData[playerid][pPnumber] = 0;
     	PlayerData[playerid][pPhoneModel] = 0;

		SendNoticeMessage(playerid, "You've dropped your mobile phone.");
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "   You don't have a phone");

	return true;
}

CMD:loudspeaker(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	ph_speaker{playerid} = !ph_speaker{playerid};	

	if(ph_speaker{playerid})
	{
	    Annotation(playerid, "turns on their phone's speakers.");
	}
	else
	{
        Annotation(playerid, "turns off their phone's speakers.");
	}
	return true;
}

/*CMD:passcall(playerid, params[])
{
    if(DeathMode{playerid} || PlayerData[playerid][pInjured] || GetPlayerSpecialAction(playerid) > 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	if(ph_menuid[playerid] == 7 && ph_sub_menuid[playerid] == 2)
	{		
		if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID && !PlayerData[playerid][pIncomingCall])
	}
	else SendErrorMessage(playerid, "You're not on a call.");

	return true;
}*/

YCMD:pickup(playerid, params[], help) = p;

CMD:p(playerid, params[])
{
    if(DeathMode{playerid} || PlayerData[playerid][pInjured] || GetPlayerSpecialAction(playerid) > 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	if(ph_menuid[playerid] == 7 && ph_sub_menuid[playerid] == 2)
	{
		new targetid = PlayerData[playerid][pCallConnect];

		if(targetid != INVALID_PLAYER_ID)
		{
			SendClientMessage(targetid, COLOR_GREY, "[ ! ] You can talk now by using the chat box.");

			PlayerData[targetid][pCellTime] = 0;
			PlayerData[targetid][pCallLine] = playerid;

	  		ph_sub_menuid[targetid] = 1;
			RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);

			AddPlayerCallHistory(playerid, PlayerData[targetid][pPnumber], PH_INCOMING);
		}

		PlayerData[playerid][pIncomingCall] = 0;
		PlayerData[playerid][pCellTime] = 0;
		PlayerData[playerid][pCallLine] = targetid;

		ph_sub_menuid[playerid] -= 1;

  		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
  		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	}
	else SendErrorMessage(playerid, "Nobody's calling you.");

	return true;
}

YCMD:hangup(playerid, params[], help) = h;

CMD:h(playerid, params[])
{
    if(PlayerData[playerid][pInjured])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot use the phone at this time.");

	if(ph_menuid[playerid] == 7)
	{
		new targetid = PlayerData[playerid][pCallConnect];

		if(targetid != INVALID_PLAYER_ID)
		{
			SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up. (( Use /phone to hide the phone ))");

			PlayerData[targetid][pCellTime] = 0;
			PlayerData[targetid][pCallLine] = INVALID_PLAYER_ID;

			RenderPlayerPhone(targetid, 0, 0);

			if(GetPlayerSpecialAction(targetid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(targetid,SPECIAL_ACTION_STOPUSECELLPHONE);

			PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;
			PlayerData[targetid][pCallConnect] = INVALID_PLAYER_ID;
		}

		if(ph_menuid[playerid] == 7 && ph_sub_menuid[playerid] == 0)
		{
			if(calltimer[playerid])
			{
				KillTimer(calltimer[playerid]);

				calltimer[playerid] = 0;
			}
		}
		else SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] You hung up.");

		PlayerData[playerid][pCellTime] = 0;
		PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;

		RenderPlayerPhone(playerid, 0, 0);

		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return true;
}

CMD:levelup(playerid, params[])
{
	new
		exp_count,
		str[128]
	;

	exp_count = ((PlayerData[playerid][pLevel]) * 4 + 4);

	if(PlayerData[playerid][pExp] < exp_count)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "   Você precisa %d pontos de experiência, você tem [%d]", exp_count, PlayerData[playerid][pExp]);
		return true;
	}

	PlayerData[playerid][pLevel]++;
	PlayerData[playerid][pExp] = 0;

	if(PlayerData[playerid][pDonateRank] > 0)
	{
		PlayerData[playerid][pExp] -= exp_count;

		new total = PlayerData[playerid][pExp];

		if(total > 0)
		{
			PlayerData[playerid][pExp] = total;
		}
		else
		{
			PlayerData[playerid][pExp] = 0;
		}
	}
	else
	{
		PlayerData[playerid][pExp] = 0;
	}

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SetPlayerScore(playerid, PlayerData[playerid][pLevel]);

	SendClientMessageEx(playerid, COLOR_GRAD2, "   Parabéns, você chegou ao level %d!", PlayerData[playerid][pLevel]);

	format(str, sizeof(str), "~g~Level Up~n~~w~ %i", PlayerData[playerid][pLevel]);
	GameTextForPlayer(playerid, str, 5000, 1);
	return true;
}

CMD:levelinfo(playerid, params[])
{
	new combined_level = (AccountData[playerid][aCombinedLevel][1] + PlayerData[playerid][pLevel]) / AccountData[playerid][aCombinedLevel][0];

	SendClientMessageEx(playerid, -1, "Your combined level is %d, on this account it's %d. Showing level %d.", combined_level, PlayerData[playerid][pLevel], PlayerData[playerid][pLevel]);
	SendClientMessageEx(playerid, -1, "Your experience points are %d, xp_counter is %d.", PlayerData[playerid][pExp], PlayerData[playerid][pExpCounter]);
	return true;
}

CMD:atributos(playerid, params[])
{
	if(isnull(params))
	{
	    SendClientMessage(playerid, COLOR_GRAD1, "USE: /atributo [descrição]");

	    if(!isnull(PlayerData[playerid][pAttribute]) && strlen(PlayerData[playerid][pAttribute]))
			SendClientMessageEx(playerid, COLOR_GRAD1, "Atualmente: %s", PlayerData[playerid][pAttribute]);
	    else
			SendClientMessage(playerid, COLOR_GRAD1, "Seus atributos não foram definidos.");

		return true;
	}

    format(PlayerData[playerid][pAttribute], 128, params);

    SendClientMessage(playerid, COLOR_WHITE, "Você mudou seus atributos.");

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Attribute` = '%e' WHERE `ID` = '%d'", params, PlayerData[playerid][pID]);
	mysql_pquery(dbCon, gquery);
	return true;
}

CMD:veratributos(playerid, params[])
{
	new
		userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/veratributos [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

 	format(sgstr, sizeof(sgstr), "%s%s%s", ReturnName(userid, 0), strlen(PlayerData[userid][pAttribute]) ? (" | ") : (""), PlayerData[userid][pAttribute]);
	SetPlayerChatBubble(userid, sgstr, COLOR_PURPLE, 20.0, 6000);
	return true;
}

CMD:doar(playerid, params[])
{
	new
	    amount
	;

	if(sscanf(params, "d", amount))
	    return SendSyntaxMessage(playerid, "/doar [valor]");

	if(amount < 1)
	    return SendErrorMessage(playerid, "Valor inválido.");

	TakePlayerMoney(playerid, amount);

	SendClientMessageEx(playerid, COLOR_GRAD2, "%s, obrigado pela sua doação de %s (%s).", ReturnName(playerid), FormatNumber(amount), ReturnSiteDate());

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s fez uma doação de $%d", ReturnName(playerid), amount);
	return true;
}

CMD:pagar(playerid, params[])
{
	if(IsBrutallyWounded(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

	new userid, amount, emote[24];

	if(sscanf(params, "udS()[24]", userid, amount, emote))
	    return SendSyntaxMessage(playerid, "/pagar [id/nome] [valor] [ação/emote]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{dS()[24]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você não está perto o suficiente dele.");

	if(userid == playerid)
		return SendErrorMessage(playerid, "Você não pode pagar a si mesmo.");

	if(amount < 1)
	    return SendErrorMessage(playerid, "O valor é muito baixo.");

	if(amount > 1000 && ReturnPlayingHours(playerid) < 2)
	    return SendErrorMessage(playerid, "Você não tem 2 horas de jogo.");

	if(amount > PlayerData[playerid][pCash])
	    return SendErrorMessage(playerid, "Você não tem esse dinheiro.");

	TakePlayerMoney(playerid, amount);
	SendPlayerMoney(userid, amount);

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

	SendClientMessageEx(playerid, COLOR_GRAD1, " Você enviou %s para %s.", FormatNumber(amount), ReturnName(userid, 0));
	SendClientMessageEx(userid, COLOR_GRAD1, " Você recebeu %s de %s.", FormatNumber(amount), ReturnName(playerid, 0));

	if(!strlen(emote))
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s tira algum dinheiro e entrega para %s.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	else
	{
	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s %s (( Câmbio de dinheiro ))", ReturnName(playerid, 0), emote, ReturnName(userid, 0));
	}

	if(amount >= 10000) SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s has paid $%d to %s", ReturnName(playerid), amount, ReturnName(userid));

    SQL_LogAction(playerid, "%s has paid $%d to %s", ReturnName(playerid), amount, ReturnName(userid));
	return true;
}

Dialog:BuyGun(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new str[128], type[24];
		GetPVarString(playerid, "buygun_name", type, sizeof(type));
		format(str, 128, "%s %d %d confirm", type, GetPVarInt(playerid, "buygun_ammo"), GetPVarInt(playerid, "buygun_add"));
		//cmd_buygun(playerid, str);
	}

	DeletePVar(playerid, "buygun_name");
	DeletePVar(playerid, "buygun_ammo");
	DeletePVar(playerid, "buygun_add");
	return true;
}

Dialog:BuyWeapon(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new str[128], type[24];
		GetPVarString(playerid, "buygun_name", type, sizeof(type));
		format(str, 128, "%s %d confirm", type, GetPVarInt(playerid, "buygun_ammo"));
		//cmd_buyweapon(playerid, str);
	}

	DeletePVar(playerid, "buygun_name");
	DeletePVar(playerid, "buygun_ammo");
	return true;
}

stock ReturnAmmoPrice(const weapon[])
{
	if(!strcmp(weapon, "knuckles", true)) return 200;
	if(!strcmp(weapon, "knife", true)) return 300;
	if(!strcmp(weapon, "poolcue", true)) return 200;
	if(!strcmp(weapon, "dildo2", true)) return 100;
	if(!strcmp(weapon, "flowers", true)) return 100;
	if(!strcmp(weapon, "molotov", true)) return 2000;
	if(!strcmp(weapon, "deagle", true)) return 15;
	if(!strcmp(weapon, "mp5", true)) return 30;
	if(!strcmp(weapon, "tec9", true)) return 30;
	if(!strcmp(weapon, "fireex", true)) return 20;

	if(!strcmp(weapon, "golfclub", true)) return 200;
	if(!strcmp(weapon, "bat", true)) return 300;
	if(!strcmp(weapon, "katana", true)) return 400;
	if(!strcmp(weapon, "dildo3", true)) return 100;
	if(!strcmp(weapon, "cane", true)) return 300;
	if(!strcmp(weapon, "colt", true)) return 10;
	if(!strcmp(weapon, "shotgun", true)) return 15;
	if(!strcmp(weapon, "ak47", true)) return 30;
	if(!strcmp(weapon, "rifle", true)) return 40;
	if(!strcmp(weapon, "camera", true)) return 2000;

	if(!strcmp(weapon, "nightstick", true)) return 200;
	if(!strcmp(weapon, "shovel", true)) return 200;
	if(!strcmp(weapon, "dildo1", true)) return 100;
	if(!strcmp(weapon, "dildo4", true)) return 100;
	if(!strcmp(weapon, "grenade", true)) return 2000;
	if(!strcmp(weapon, "sdpistol", true)) return 10;
	if(!strcmp(weapon, "mac10", true)) return 30;
	if(!strcmp(weapon, "m4", true)) return 30;
	if(!strcmp(weapon, "sprifle", true)) return 2500;
	if(!strcmp(weapon, "parachute", true)) return 500;

	return 0;
}

stock ReturnWeaponPrice(const weapon[])
{
	if(!strcmp(weapon, "knuckles", true)) return 200;
	if(!strcmp(weapon, "knife", true)) return 300;
	if(!strcmp(weapon, "poolcue", true)) return 200;
	if(!strcmp(weapon, "dildo2", true)) return 100;
	if(!strcmp(weapon, "flowers", true)) return 100;
	if(!strcmp(weapon, "molotov", true)) return 6000;
	if(!strcmp(weapon, "deagle", true)) return 7000;
	if(!strcmp(weapon, "mp5", true)) return 13500;
	if(!strcmp(weapon, "tec9", true)) return 8600;
	if(!strcmp(weapon, "fireex", true)) return 2000;

	if(!strcmp(weapon, "golfclub", true)) return 200;
	if(!strcmp(weapon, "bat", true)) return 300;
	if(!strcmp(weapon, "katana", true)) return 400;
	if(!strcmp(weapon, "dildo3", true)) return 100;
	if(!strcmp(weapon, "cane", true)) return 300;
	if(!strcmp(weapon, "colt", true)) return 5000;
	if(!strcmp(weapon, "shotgun", true)) return 7000;
	if(!strcmp(weapon, "ak47", true)) return 15000;
	if(!strcmp(weapon, "rifle", true)) return 15000;
	if(!strcmp(weapon, "camera", true)) return 50;

	if(!strcmp(weapon, "nightstick", true)) return 200;
	if(!strcmp(weapon, "shovel", true)) return 200;
	if(!strcmp(weapon, "dildo1", true)) return 100;
	if(!strcmp(weapon, "dildo4", true)) return 100;
	if(!strcmp(weapon, "grenade", true)) return 8000;
	if(!strcmp(weapon, "sdpistol", true)) return 8000;
	if(!strcmp(weapon, "mac10", true)) return 9500;
	if(!strcmp(weapon, "m4", true)) return 17500;
	if(!strcmp(weapon, "sprifle", true)) return 50000;
	if(!strcmp(weapon, "parachute", true)) return 500;

	return 0;
}

new WeaponName[48][32] =
{
	"Fists","knuckles","golfclub","nightstick","knife","baseball","shovel",
	"poolcue","katana","Chainsaw","dildo1","dildo2","dildo3","dildo4","flowers","cane",
	"grenade","teargas","molotov","","","","colt","sdpistol","deagle","shotgun","sawnoff","combat",
	"uzi","mp5","ak47","m4","tec9","Rifle","sprifle","rocket","heat","flamethrower",
	"minigun","satchel","detonator","spraycan","fireex","camera","nigtvision","goggles","parachute","armour"
};

stock GetWeaponIDFromName(const name[])
{
	for(new i = 0;i <= 46;++i)
	{
	    if(strfind(WeaponName[i], name, true) == -1) continue;

		return i;
	}

	return -1;
}

CMD:buyweapon(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_SUPPLIER)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a weapon supplier.");

	new id = InBusiness[playerid];

	if(id == -1 || BusinessData[id][bType] != 13)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in any weapon factory.");

	if(!BusinessData[id][bProducts])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "This factory is out of stock.");

	new weapon[32], ammo, slot;

	if(sscanf(params, "s[32]dD(-1)", weapon, ammo, slot))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /buyweapon [weapon] [ammo] ([slot])");
		SendClientMessage(playerid, COLOR_CYAN, "[ knuckles: $200; ammo: $200 ]  [ golfclub: $200; ammo: $200 ]  [ nightstick: $200; ammo: $200 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ knife: $300; ammo: $300 ]  [ bat: $300; ammo: $300 ]  [ shovel: $200; ammo: $200 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ poolcue: $200; ammo: $200 ]  [ katana: $400; ammo: $400 ]  [ dildo1: $100; ammo: $100 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ dildo2: $100; ammo: $100 ]  [ dildo3: $100; ammo: $100 ]  [ dildo4: $100; ammo: $100 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ flowers: $100; ammo: $100 ]  [ cane: $300; ammo: $300 ]  [ grenade: $8000; ammo: $2000 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ molotov: $6000; ammo: $2000 ]  [ colt: $5000; ammo: $10 ]  [ sdpistol: $8000; ammo: $10 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ deagle: $7000; ammo: $15 ]  [ shotgun: $7000; ammo: $15 ]  [ mac10: $9500; ammo: $30 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ mp5: $13500; ammo: $30 ]  [ ak47: $15000; ammo: $30 ]  [ m4: $17500; ammo: $30 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ tec9: $8600; ammo: $30 ]  [ rifle: $10000; ammo: $40 ]  [ sprifle: $50000; ammo: $2500 ]");
		SendClientMessage(playerid, COLOR_CYAN, "[ fireex: $2000; ammo: $20 ]  [ camera: $500; ammo: $5 ]  [ parachute: $500; ammo: $500 ]");
		return true;
	}

	new free_slot = -1;

	if(slot == -1)
	{
		free_slot = FindFreePackageSlot(playerid);

		if(free_slot == -1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Your package is full.");
	}
	else
	{
		if(slot < 1 || slot > MAX_PLAYER_WEAPON_PACKAGE)
		    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Invalid package slot. Must be 1-%d.", MAX_PLAYER_WEAPON_PACKAGE);

		slot--;

	    if(PlayerData[playerid][pPackageWP][slot])
	    	return SendErrorMessage(playerid, "That package slot is occupied.");

	    free_slot = slot;
	}

	new weapon_price = ReturnWeaponPrice(weapon), ammo_price, price, weaponid;

	weaponid = GetWeaponIDFromName(weapon);

	if(!weapon_price || !weaponid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /buyweapon [weapon] [ammo] ([slot])");

	new max_ammo = GetWeaponPackage(g_aWeaponSlots[weaponid]);

	if(ammo < 1 || ammo > max_ammo)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ammo cannot be lower than 1 or more than %d.", max_ammo);

	ammo_price = ReturnAmmoPrice(weapon);
	price = weapon_price + (ammo * ammo_price);

	if(PlayerData[playerid][pCash] < price)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro suficiente.");

	TakePlayerMoney(playerid, price);

	BusinessData[id][bProducts] -= 1;

	PlayerData[playerid][pPackageWP][free_slot] = weaponid;
	PlayerData[playerid][pPackageAmmo][free_slot] = ammo;

	SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've bought %s and %d ammo and paid $%d", GetWeaponPackageName(weaponid), ammo, price);

	SQL_LogAction(playerid, "Bought a %s with %d ammo from bizid %d price $%d", GetWeaponPackageName(weaponid), ammo, BusinessData[id][bID], price);
	return true;
}

CMD:buygun(playerid, params[])
{
	ProccessBuyGunCommand(playerid, params);
	return true;
}

ProccessBuyGunCommand(playerid, const params[])
{
    new id = InBusiness[playerid];

	if((id == -1) || BusinessData[id][bType] != 2)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not inside an ammunition.");

	if(!PlayerData[playerid][pWepLic])
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "You need to obtain a weapon license to purchase weapons here.");
		SendClientMessage(playerid, COLOR_GRAD2, "Contact LSPD to obtain a weapon license.");
		return true;
	}

	new weapon[32], ammo, confirm[16];

	if(sscanf(params, "s[32]dS()[16]", weapon, ammo, confirm))
	{
	    SendSyntaxMessage(playerid, "/buygun [weapon] [ammo]");
		SendClientMessage(playerid, COLOR_CYAN, " [ colt: $12500; ammo: $25 ] [ deagle: $17500; ammo: $38 ] [ shotgun: $17500; ammo: $38 ]");
		SendClientMessage(playerid, COLOR_CYAN, " [ rifle: $25000; ammo: $100 ] [ parachute: $1250; ammo: $1250 ] [ armour: $2000; ammo: $2000 ]");
		return true;
	}

	if(!ammo) return SendErrorMessage(playerid, "Invalid ammo specified.");

	new weaponid = -1, price, ammo_price, max_ammo;

	if(isnull(confirm) || strcmp(confirm, "confirm", true) > 0)
	{
		if(!strcmp(weapon, "colt", true))
		{
			weaponid = 22; price = 12500; ammo_price = 25;
		}
		else if(!strcmp(weapon, "deagle", true))
		{
			weaponid = 24; price = 17500; ammo_price = 38;
		}
		else if(!strcmp(weapon, "shotgun", true))
		{
			weaponid = 25; price = 17500; ammo_price = 38;
		}
		else if(!strcmp(weapon, "rifle", true))
		{
			weaponid = 33; price = 25000; ammo_price = 100;
		}
		else if(!strcmp(weapon, "parachute", true))
		{
			weaponid = 46; price = 1250; ammo_price = 1250;
		}
		else if(!strcmp(weapon, "armour", true))
		{
			weaponid = 47; price = 2000; ammo_price = 2000;
		}

		if(!weaponid || !price || !ammo_price) return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /buyweapon [weapon] [ammo]"); //[add(0/1)]

		if(weaponid == 47) ammo = 1;

		max_ammo = GetWeaponPackage(g_aWeaponSlots[weaponid]);

		if(ammo < 1 || ammo > max_ammo)
			return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ammo cannot be lower than 1 or more than %d.", max_ammo);

		price = price + (ammo * ammo_price);

		SetPVarInt(playerid, "buygun_weapon", weaponid);
		SetPVarInt(playerid, "buygun_ammo", ammo);
		SetPVarInt(playerid, "buygun_price", price);

		new string[128];
		format(string, sizeof(string), "Are you sure you want to purchase %s with %d ammo for %s?", GetWeaponPackageName(weaponid), ammo, FormatNumber(price));
		ConfirmDialog(playerid, "Confirmation", string, "OnPlayerPruchaseWeapon");
		return true;
	}

	weaponid = GetPVarInt(playerid, "buygun_weapon");
	ammo = GetPVarInt(playerid, "buygun_ammo");
	price = GetPVarInt(playerid, "buygun_price");

	if(!weaponid || !price)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /buyweapon [weapon] [ammo]");

	if(PlayerData[playerid][pCash] < price)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro suficiente.");

	TakePlayerMoney(playerid, price);

	if(weaponid == 47) SetPlayerArmourEx(playerid, 50.0);
	else GivePlayerValidWeapon(playerid, weaponid, ammo);

	BusinessData[id][bTill] += floatround(price * 0.7);
	BusinessData[id][bProducts] -= 1;

	SendClientMessageEx(playerid, COLOR_GREEN, "[Weapon] You've bought %s and %d ammo and paid $%d", GetWeaponPackageName(weaponid), ammo, price);
	SendClientMessage(playerid, COLOR_LIGHTRED, "(( WARNING: Selling/giving away or stockpilling weapons is bannable. Read the licensing rules. ))");

	SQL_LogAction(playerid, "Bought a %s with %d ammo from bizid %d price $%d", GetWeaponPackageName(weaponid), ammo, BusinessData[id][bID], price);
	return true;	
}

FUNX::OnPlayerPruchaseWeapon(playerid, response)
{
	if(response)
	{
		new str[64];
		format(str, 64, "weapon %d confirm", GetPVarInt(playerid, "buygun_ammo"));
		ProccessBuyGunCommand(playerid, str);
	}

	DeletePVar(playerid, "buygun_weapon");
	DeletePVar(playerid, "buygun_ammo");
	DeletePVar(playerid, "buygun_price");
    return true;
}

CMD:comprar(playerid, params[])
{
	new itemid, id = Business_Inside(playerid);

    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1163.0109,-1470.7698,15.7941))
    {
        if(isnull(params) || !IsNumeric(params))
            return SendSyntaxMessage(playerid, "/comprar [quantidade]; $1,000 por cada");

		new amount = strval(params);

		if((amount * 1000) > PlayerData[playerid][pCash])
			return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");

		TakePlayerMoney(playerid, amount * 1000);

		PlayerData[playerid][pHasLabel] += amount;

		SendClientMessageEx(playerid, COLOR_GREEN, "Você comprou %d advert signs. {FFFFFF}/carsign", amount);
        return true;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1112.4480, -1527.4012, 15.7981)) cl_buying[playerid] = BUYSPORTS;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1096.2791, -1439.8060, 15.7981)) cl_buying[playerid] = BUYZIP;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1090.9180, -1506.6713, 15.7963)) cl_buying[playerid] = BUYMUSIC;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1086.8405, -1449.5437, 22.7434))
    {
        SendClientMessage(playerid, COLOR_WHITE, "DICA: Use {F2EB35}ESPAÇO {FFFFFF}para olhar em volta. Pressione {F2EB35}ESC {FFFFFF}para recusar.");

        PCoverColor[playerid] = 0;

	    for(new i = 0; i != sizeof(TD_PhoneCover); ++i)
			TextDrawShowForPlayer(playerid, TD_PhoneCover[i]);

	    PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18868);
	    PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);

	    SelectTextDraw(playerid, 0x00000080);
	    PCoverOpening{playerid} = true;
        return true;
    }
    else if(id != -1)
    {
 	    if(InBusiness[playerid] == id && BusinessData[id][bType] == 3) // 24-7
	    {
			if(BusinessData[id][bLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Fechado", 5000, 1);

			if(BusinessData[id][bProducts] == 0)
				return GameTextForPlayer(playerid, "~r~Fora de Estoque", 5000, 1);

	        ShowShopList(playerid, true);
	        return true;
		}
    }
    else return SendErrorMessage(playerid, "Você não tem o que comprar aqui.");

	if(sscanf(params, "d", itemid))
 	{
		ShowClothingDialog(playerid, 0);
		return true;
	}

	if((cl_buyingpslot[playerid] = ClothingExistSlot(playerid)) != -1)
	{
		if(!PurchaseClothing(playerid, itemid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Este item não pode ser comprado.");
	}
	return true;
}

CMD:roupas(playerid, params[])
{
	new
	    name[16],
	    userid,
	    clothingid
	;

	if(sscanf(params, "s[16]D(-1)U(65535)", name, clothingid, userid))
 	{
		cl_ShowClothingMenu(playerid);
		return true;
	}

	if(!HasCooldown(playerid, COOLDOWN_CLOTHES))
	{
        clothingid = clothingid - 1;

		if(!strcmp(name, "help", true))
		{
		    SendSyntaxMessage(playerid, "/roupas (c)olocar | (a)justar | (d)ropar | (e)ntregar"); //| restore | info
		}
		else if(!strcmp(name, "colocar", true) || !strcmp(name, "c", true))
		{
		    if(clothingid < 0)
			{
			    SendSyntaxMessage(playerid, "/roupas colocar [Roupa ID]");

				for(new id = 0; id < MAX_CLOTHES; ++id)
				{
				    if(ClothingData[playerid][id][cl_object])
					{
				        SendClientMessageEx(playerid, COLOR_GREY, "%d. %s", id+1, ClothingData[playerid][id][cl_name]);
	            	}
	            }
			    return 1;
			}

			if(ClothingData[playerid][clothingid][cl_object])
			{
				if(ClothingData[playerid][clothingid][cl_equip])
				{
					RemovePlayerAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot]);
					SendClientMessageEx(playerid, COLOR_WHITE, "You took off your {FFFF00}%s{FFFFFF}.", ClothingData[playerid][clothingid][cl_name]);
					ClothingData[playerid][clothingid][cl_equip] = 0;
				}
				else
				{
		   			SetPlayerAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot], ClothingData[playerid][clothingid][cl_object], ClothingData[playerid][clothingid][cl_bone], ClothingData[playerid][clothingid][cl_x], ClothingData[playerid][clothingid][cl_y],
					ClothingData[playerid][clothingid][cl_z], ClothingData[playerid][clothingid][cl_rx], ClothingData[playerid][clothingid][cl_ry], ClothingData[playerid][clothingid][cl_rz], ClothingData[playerid][clothingid][cl_scalex], ClothingData[playerid][clothingid][cl_scaley], ClothingData[playerid][clothingid][cl_scalez]);
					SendClientMessageEx(playerid, COLOR_WHITE, "You put on your {FFFF00}%s{FFFFFF}.", ClothingData[playerid][clothingid][cl_name]);

					for(new i = 0; i < MAX_CLOTHES; ++i)
					{
						if(ClothingData[playerid][i][cl_object] && ClothingData[playerid][i][cl_equip] && ClothingData[playerid][i][cl_slot] == ClothingData[playerid][clothingid][cl_slot])
						{
							ClothingData[playerid][i][cl_equip] = 0;
						}
					}

					ClothingData[playerid][clothingid][cl_equip] = 1;
				}
			}
            else SendClientMessage(playerid, COLOR_LIGHTRED, "Nothing is there...");
		}
		else if(!strcmp(name, "dropar", true) || !strcmp(name, "d", true))
		{
      		if(clothingid < 0)
			{
			    SendSyntaxMessage(playerid, "/roupas dropar [ID]");

				for(new id = 0; id < MAX_CLOTHES; ++id)
				{
				    if(ClothingData[playerid][id][cl_object])
					{
				        SendClientMessageEx(playerid, COLOR_WHITE, "%d: %s", id+1, ClothingData[playerid][id][cl_name]);
	            	}
	            }
			    return 1;
			}

			if(ClothingData[playerid][clothingid][cl_object])
			{
				if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[playerid][clothingid][cl_slot])) RemovePlayerAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot]);
                ClothingData[playerid][clothingid][cl_object] = 0;

				new query[128];
				mysql_format(dbCon, query, sizeof(query), "DELETE FROM `clothing` WHERE `owner` = '%d' and `id` = '%d' LIMIT 1",PlayerData[playerid][pID], ClothingData[playerid][clothingid][cl_sid]);
				mysql_pquery(dbCon, query);

				SendClientMessageEx(playerid, COLOR_GRAD1, "You dropped your %s - #%d.", ClothingData[playerid][clothingid][cl_name], clothingid + 1);

				SetCooldown(playerid, COOLDOWN_CLOTHES, 5);
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "Nothing at all..");

		}
		else if(!strcmp(name, "ajustar", true) || !strcmp(name, "a", true))
		{
      		if(clothingid < 0)
			{
			    SendSyntaxMessage(playerid, "/roupas ajustar [ID]");

				for(new id = 0; id < MAX_CLOTHES; ++id)
				{
				    if(ClothingData[playerid][id][cl_object])
					{
				        SendClientMessageEx(playerid, COLOR_WHITE, "%d: %s", id+1, ClothingData[playerid][id][cl_name]);
	            	}
	            }
			    return 1;
			}

            if(ClothingData[playerid][clothingid][cl_object])
			{
                cl_selected[playerid] = clothingid;
			    SetPlayerAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot], ClothingData[playerid][clothingid][cl_object], ClothingData[playerid][clothingid][cl_bone], ClothingData[playerid][clothingid][cl_x], ClothingData[playerid][clothingid][cl_y],
				ClothingData[playerid][clothingid][cl_z], ClothingData[playerid][clothingid][cl_rx], ClothingData[playerid][clothingid][cl_ry], ClothingData[playerid][clothingid][cl_rz], ClothingData[playerid][clothingid][cl_scalex], ClothingData[playerid][clothingid][cl_scaley], ClothingData[playerid][clothingid][cl_scalez]);

				ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 1, 0, 1);
				EditAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot]);

				EditClothing{playerid} = true;
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "Nothing at all..");
		}
		else if(!strcmp(name, "entregar", true) || !strcmp(name, "e", true))
		{
      		if(clothingid < 0)
			{
			    SendSyntaxMessage(playerid, "/roupas entregar [RoupaID] [id/nome]");

				for(new id = 0; id < MAX_CLOTHES; ++id)
				{
				    if(ClothingData[playerid][id][cl_object])
					{
				        SendClientMessageEx(playerid, COLOR_WHITE, "%d: %s", id+1, ClothingData[playerid][id][cl_name]);
	            	}
	            }
			    return 1;
			}

			if(userid == INVALID_PLAYER_ID)
			{
				new maskid[MAX_PLAYER_NAME];
				sscanf(params, "{s[16]D(-1)}s[24]", name);
				if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
				{
					return SendSyntaxMessage(playerid, "/roupas entregar [RoupaID] [id/nome]");
				}
			}

			if(!IsPlayerNearPlayer(playerid, userid, 5.0))
                return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

			if(ClothingData[playerid][clothingid][cl_object])
			{
				if(AddPlayerClothing(
				userid,
				ClothingData[playerid][clothingid][cl_object],
				ClothingData[playerid][clothingid][cl_x],
				ClothingData[playerid][clothingid][cl_y],
				ClothingData[playerid][clothingid][cl_z],
				ClothingData[playerid][clothingid][cl_rx],
				ClothingData[playerid][clothingid][cl_ry],
				ClothingData[playerid][clothingid][cl_rz],
				ClothingData[playerid][clothingid][cl_bone],
				ClothingData[playerid][clothingid][cl_slot],
				ClothingData[playerid][clothingid][cl_scalex],
				ClothingData[playerid][clothingid][cl_scaley],
				ClothingData[playerid][clothingid][cl_scalez],
				ClothingData[playerid][clothingid][cl_name],
				ClothingData[playerid][clothingid][cl_sid]) != -1)
				{
				    new query[128];
					mysql_format(dbCon, query, sizeof(query),"UPDATE clothing SET `owner` = '%d', `equip` = '0' WHERE `owner` = '%d' and `id` = '%d'", PlayerData[userid][pID], PlayerData[playerid][pID], ClothingData[playerid][clothingid][cl_sid]);
					mysql_pquery(dbCon, query);

					if(IsPlayerAttachedObjectSlotUsed(playerid, ClothingData[playerid][clothingid][cl_slot])) RemovePlayerAttachedObject(playerid, ClothingData[playerid][clothingid][cl_slot]);

					SendClientMessageEx(userid, COLOR_GRAD1, " Você recebeu %s #%d de %s.", ClothingData[playerid][clothingid][cl_name], clothingid + 1, ReturnName(playerid, 0));
					SendClientMessageEx(playerid, COLOR_GRAD1, " Você entregou %s #%d para %s.", ClothingData[playerid][clothingid][cl_name], clothingid + 1, ReturnName(userid, 0));

                    ClothingData[playerid][clothingid][cl_object] = 0;
					SetCooldown(playerid,COOLDOWN_CLOTHES, 5);
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode dar esta peça de roupa ao jogador.");

                SetCooldown(playerid, COOLDOWN_CLOTHES, 5);
            }
			else SendClientMessage(playerid, COLOR_LIGHTRED, "Nada mesmo..");
		}
		else SendErrorMessage(playerid, "Parâmetro inválido.");
	}
	else SendClientMessageEx(playerid, COLOR_LIGHTRED, "Por favor espera %d segundo(s) antes de tentar usar /clothing novamente.", GetCooldownLevel(playerid, COOLDOWN_CLOTHES));

	return true;
}

CMD:revistar(playerid, params[])
{
	new userid;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_GREY, "USE: /revistar [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Jogador não está próximo.");

	if(AdminDuty{playerid} || IsCuffed{userid} || GetPlayerSpecialAction(userid) == SPECIAL_ACTION_HANDSUP)
		return FriskPlayer(playerid, userid);

	if(!FriskApproved[userid][playerid])
	{
	    SendClientMessageEx(userid, COLOR_YELLOW, "SERVER: ID %d tentou revistar você, utilize /aceitarrevista %d para concluir", playerid, playerid);
        return SendServerMessage(playerid, "O jogador tera que utilizar /aceitarrevista [seunome/ID] antes de você revistar.");
	}

	FriskPlayer(playerid, userid);
	return true;
}

CMD:aceitarrevista(playerid, params[])
{
	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/aceitarrevista [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador não conectado.");
		}
	}

	if(FriskApproved[playerid][userid])
	    return SendServerMessage(playerid, "Esse jogador já tem a aprovação da sua parte.");

 	FriskApproved[playerid][userid] = 1;

    SendClientMessageEx(userid, COLOR_YELLOW, "SERVER: %s permitiu você de o resvista (/aceitarrevista), agora você pode utilizar (/revistar)", ReturnName(playerid, 0));
    SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: Você permitiu que %s revistasse você.", ReturnName(userid, 0));
	return true;
}

stock FriskPlayer(playerid, userid)
{
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s realiza uma revista em %s.", ReturnName(playerid, 0), ReturnName(userid, 0));

	SendClientMessage(playerid, COLOR_LIGHTRED, "");
	SendClientMessage(playerid, COLOR_LIGHTRED, "");
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s's Itens gerais:", ReturnName(userid, 0));

	if(PlayerData[userid][pCash] > 0 && PlayerData[userid][pCash] <= 500) SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ {FFFFFF}$%d+{FF6347} ]", floatround(float(PlayerData[userid][pCash]), floatround_floor));
	else if(PlayerData[userid][pCash] > 500) SendClientMessage(playerid, COLOR_LIGHTRED, "[ {FFFFFF}$500+{FF6347} ]");

	SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ {FFFFFF}Celular{FF6347} ]");

	for(new i = 0; i < 3; ++i)
	{
		if(PlayerData[userid][pWeapon][i] != 0 && PlayerData[userid][pAmmunation][i] != 0)
		{
		    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ {FFFFFF}%s{FF6347} ]", ReturnWeaponName(PlayerData[userid][pWeapon][i]));
		}
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "");
    ShowPlayerDrugs(userid, playerid); // drugs

	SendClientMessage(playerid, COLOR_LIGHTRED, "");
	ShowPlayerWeapons(userid, playerid); // weapon packages

	SendClientMessage(playerid, COLOR_LIGHTRED, "");
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s's Prison items:", ReturnName(userid, 0));
	SendClientMessage(playerid, COLOR_WHITE, "Este jogador não tem itens da prisão.");
	return true;
}

CMD:levantar(playerid, params[])
{
	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/levantar [id/nome/mask]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(!KnockedOut{userid})
	    return SendErrorMessage(playerid, "Ele não precisa da sua ajuda para nada.");

	if(playerid == userid)
	    return SendErrorMessage(playerid, "Dummy");

    if(DeathTimer[userid] > 0)
   		return SendErrorMessage(playerid, "Você deve esperar %d segundos antes de ajudar este jogador a se levantar.", DeathTimer[userid]);

   	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
   	    return SendErrorMessage(playerid, "Você não está próximo daquele jogador");

   	if(HelpingPlayer[playerid] != INVALID_PLAYER_ID)
   	    return SendErrorMessage(playerid, "Você já está levantando alguém.");

 	if(HelpingPlayer[userid] != INVALID_PLAYER_ID)
   	    return SendErrorMessage(playerid, "O jogador já está sendo levantado.");

  	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
    	return SendErrorMessage(playerid, "Você precisa estar agachado para ajudá-los a levantar.");

    HelpupStage[userid] = 15;
    HelpingPlayer[userid] = playerid;
    HelpingPlayer[playerid] = userid;

    format(sgstr, sizeof(sgstr), "* %s esta ajudando %s a levantar.", ReturnName(playerid, 0), ReturnName(userid, 0));
    SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 4000);

    KnockoutLabel[userid] = CreateDynamic3DTextLabel("(( --------------- ))\nHELPING UP", COLOR_GREEN2, 0.0, 0.0, 0.7, 10.0, userid);

    SendNoticeMessage(playerid, "Você está ajudando %s a levantar. Isso vai levar 15 segundos. Fique perto dele.", ReturnName(userid, 0));
	SendNoticeMessage(userid, "%s está te ajudando a levantar. Vai levar apenas 15 segundos.", ReturnName(playerid, 0));

	HelpUpTimer[userid] = SetTimerEx("KnockoutTimer", 1000, true, "dd", userid, playerid);
	return true;
}

FUNX::KnockoutTimer(playerid, userid)
{
	if(!IsPlayerNearPlayer(userid, playerid, 3.0) || GetPlayerSpecialAction(userid) != SPECIAL_ACTION_DUCK)
	{
	    HelpingPlayer[userid] = INVALID_PLAYER_ID;
	    HelpingPlayer[playerid] = INVALID_PLAYER_ID;

	    HelpupStage[playerid] = 0;

		KillTimer(HelpUpTimer[playerid]);

		if(IsValidDynamic3DTextLabel(KnockoutLabel[playerid])) DestroyDynamic3DTextLabel(KnockoutLabel[playerid]);

 		return SendErrorMessage(userid, "A ação foi cancelada porque você se moveu.");
	}

    HelpupStage[playerid]--;

	switch(HelpupStage[playerid])
	{
	    case 14: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |-------------- ))\nHELPING UP");
	    case 13: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||------------- ))\nHELPING UP");
	    case 12: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||------------ ))\nHELPING UP");
	    case 11: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||----------- ))\nHELPING UP");
	    case 10: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||||---------- ))\nHELPING UP");
	    case 9: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||--------- ))\nHELPING UP");
	    case 8: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||||||-------- ))\nHELPING UP");
	    case 7: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||||------- ))\nHELPING UP");
	    case 6: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||||||||------ ))\nHELPING UP");
	    case 5: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||||||----- ))\nHELPING UP");
	    case 4: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||||||||||---- ))\nHELPING UP");
	    case 3: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||||||||--- ))\nHELPING UP");
	    case 2: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( |||||||||||||-- ))\nHELPING UP");
	    case 1: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||||||||||- ))\nHELPING UP");
	    case 0: UpdateDynamic3DTextLabelText(KnockoutLabel[playerid], COLOR_GREEN2, "(( ||||||||||||||| ))\nHELPING UP");
	}

	if(!HelpupStage[playerid]) // playerid = knocked out player | userid = player who used /levantar
	{
	    HelpingPlayer[userid] = INVALID_PLAYER_ID;
	    HelpingPlayer[playerid] = INVALID_PLAYER_ID;

		KillTimer(HelpUpTimer[playerid]);

		if(IsValidDynamic3DTextLabel(KnockoutLabel[playerid])) DestroyDynamic3DTextLabel(KnockoutLabel[playerid]);

        RevivePlayer(playerid);

		SetPlayerHealthEx(playerid, 25.0);

		TogglePlayerControllable(playerid, true);

		format(sgstr, sizeof(sgstr), "** %s é levantado por %s.", ReturnName(playerid, 0), ReturnName(userid, 0));
	 	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 4000);		

		format(sgstr, sizeof(sgstr), "** %s levanta %s.", ReturnName(userid, 0), ReturnName(playerid, 0));
	 	SetPlayerChatBubble(userid, sgstr, COLOR_PURPLE, 20.0, 4000);

		SendNoticeMessage(userid, "Você levantou %s up!", ReturnName(playerid, 0));
	 	SendNoticeMessage(playerid, "%s levantou você!", ReturnName(userid, 0));
	}
 	return true;
}

CMD:aceitarmorte(playerid, params[])
{
    if(!PlayerData[playerid][pInjured] && !KnockedOut{playerid})
 		return SendErrorMessage(playerid, "Você não está brutalmente ferido.");

	if(DeathMode{playerid}) return true;

	if(DeathTimer[playerid] > 0)
	{
	    if(KnockedOut{playerid})
	    {
			SendErrorMessage(playerid, "Você ainda não pode aceitar a morte!");
			SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] >> {FFFFFF}Não aceite a morte logo depois de morrer. Faça um Roleplay adequado de seus ferimentos.");
			SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] >> {FFFFFF}Você pode aceitar a morte 120 segundos depois de morrer.");
	    }

	    return true;
	}

    MakePlayerDead(playerid);
	return true;
}

CMD:lostitems(playerid, params[])
{
	new lostitems[800];
	GetPVarString(playerid, "LostItems", lostitems, sizeof(lostitems));

	if(isnull(lostitems) || !strlen(lostitems))
		return SendNoticeMessage(playerid, "You haven't lost any items at death.");

	Dialog_Show(playerid, LostItems, DIALOG_STYLE_MSGBOX, "%s's lost items:", lostitems, "<<", ">>", ReturnName(playerid));
	return true;
}

CMD:ferimentos(playerid, params[])
{
	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/ferimentos [id/nome]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Jogador especificado não está conectado.");

	if(AdminDuty{playerid})
	{
		ShowPlayerDamages(userid, playerid, 1);
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendErrorMessage(playerid, "Muito longe de você.");

		ShowPlayerDamages(userid, playerid, 0);
	}
	return true;
}

/*CMD:corpse(playerid, params[])
{
	new Float:playerPos[3];

	for(new i = 0; i < MAX_PLAYERS; ++i)
	{
	    if(CORPSES[i][corpseSpawned])
	    {
	    	GetActorPos(CORPSES[i][corpseActor], playerPos[0], playerPos[1], playerPos[2]);

	    	if(IsPlayerInRangeOfPoint(playerid, 5.0, playerPos[0], playerPos[1], playerPos[2]))
	    	{
	    	    SendClientMessageEx(playerid, COLOR_ORANGE, "Here lies %s...", CORPSES[i][corpseName]);
	    	    return true;
	    	}
		}
	}

	SendErrorMessage(playerid, "You're not near any corpse.");
	return true;
}*/

CMD:respawnme(playerid, params[])
{
	if(!DeathMode{playerid})
	    return SendClientMessage(playerid, COLOR_YELLOW, "Você não está morto.");

	if(DeathTimer[playerid] > 0)
	    return SendClientMessageEx(playerid, COLOR_YELLOW, "-> Restam apenas %d segundos desde que você morreu, é preciso esperar até 60.", 60 - DeathTimer[playerid]);

	if(IsPlayerInAnyVehicle(playerid)) RemoveFromVehicle(playerid);

    ResetPlayer(playerid);
	ClearDamages(playerid, true);

	PlayerData[playerid][pInjured] = 0;
	PlayerData[playerid][pHealth] = 150.0;

	KnockedOut{playerid} = false;
	DeathMode{playerid} = false;
	DeathTimer[playerid] = 0;
 	MedicBill[playerid] = 0;
	BrokenLeg{playerid} = false;
	death_Pause[playerid] = 0;

    //CreatePlayerCorpse(playerid);

    SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[DEATH] %s's died.", ReturnFormatName(playerid));

    Spawned{playerid} = false;
	TogglePlayerControllable(playerid, true);
	SpawnPlayer(playerid);
	return true;
}

CMD:faction(playerid, params[])
{
	ViewFactions2(playerid);
	return true;
}

CMD:emtrabalho(playerid, params[])
{
	new cops, medics, docs, taxi, prisoners;

	foreach (new i : Player)
	{
	    if(TaxiDuty{i})
			taxi ++;

	    if(PlayerData[i][pJailed] == PUNISHMENT_TYPE_PRISON)
			prisoners++;

	    if(!PlayerData[i][pOnDuty])
			continue;

		switch(GetFactionType(i))
		{
		    case FACTION_POLICE, FACTION_SHERIFF:
				cops ++;
		    case FACTION_MEDIC:
				medics ++;
		    case FACTION_CORRECTIONAL:
				docs ++;
		    default:
				continue;
		}
	}

	SendNoticeMessage(playerid, "Há %d policiais, %d agentes penitenciários, %d médicos e %d taxistas em trabalho.", cops, docs, medics, taxi);
	SendNoticeMessage(playerid, "Há %d prisioneiros na SACF.", prisoners);
	return true;
}

CMD:prisoners(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_CORRECTIONAL && PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "Não autorizado.");

	new count;

	gstr[0] = EOS;

	foreach (new i : Player)
	{
	    if(PlayerData[i][pJailed] == PUNISHMENT_TYPE_PRISON)
	    {
	        format(gstr, sizeof(gstr), "%s\nCell A%d [%s]", gstr, PlayerCell[i] + 100, ReturnName(i));

	        count++;
	    }
	}

	if(!count) return SendClientMessage(playerid, COLOR_LIGHTRED, "There are currently no prisoners online in SACF.");

	new header[30];
	format(header, sizeof(header), "Inmatecount: %d", count);
	Dialog_Show(playerid, Prisoners, DIALOG_STYLE_LIST, header, gstr, "Exit", "");
	return true;
}

CMD:factionon(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

 	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	SendClientMessageEx(playerid, COLOR_GREY, "%s - Lista de membro online", FactionData[factionid][factionName]);

	foreach (new i : Player)
	{
        if(PlayerData[i][pFaction] == factionid)
        {
  			if(AdminDuty{i})
				SendClientMessageEx(playerid, COLOR_GRAD2, "(ID: %03d) {FF9900}%s %s", i, Faction_GetRank(i), ReturnName(i));
			else
				SendClientMessageEx(playerid, COLOR_GRAD2, "(ID: %03d) {%s}%s %s", i, (PlayerData[i][pOnDuty]) ? (GetFactionColor(factionid)) : ("BFC0C2"), Faction_GetRank(i), ReturnName(i));
        }
	}
	return true;
}

CMD:nofam(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

 	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	if(!HasFactionRank(playerid, 2))
	    return SendUnauthMessage(playerid, "You rank does not have permission to tog faction chat.");

	if(!FactionData[factionid][factionChat])
	{
		FactionData[factionid][factionChat] = 1;

 		SendFactionMessage(factionid, COLOR_LIGHTRED, "%s has switched /f chat off.", ReturnName(playerid, 0));
	}
	else
	{
		FactionData[factionid][factionChat] = 0;

		SendFactionMessage(factionid, COLOR_LIGHTRED, "%s has switched /f chat on.", ReturnName(playerid, 0));
	}
	return true;
}

YCMD:news(playerid, params[], help) = bcast;

CMD:bcast(playerid, params[])
{
    if(PlayerData[playerid][pFaction] == -1 || GetFactionType(playerid) != FACTION_NEWS)
        return SendErrorMessage(playerid, "You're not a news reporter.");

    if(isnull(params))
        return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /bcast (/n)ews [broadcasting news]");

    if(strlen(params) > 70)
    {
    	SendClientMessageToAllEx(COLOR_LIME, "[SAN] %s: %.70s ...", ReturnName(playerid, 0), params);
    	SendClientMessageToAllEx(COLOR_LIME, "[SAN] %s: ... %s", ReturnName(playerid, 0), params[70]);
	}
	else SendClientMessageToAllEx(COLOR_LIME, "[SAN] %s: %s", ReturnName(playerid, 0), params);

	return true;
}

YCMD:gov(playerid, params[], help) = government;

CMD:government(playerid, params[])
{
 	if(PlayerData[playerid][pFaction] == -1 || GetFactionType(playerid) == FACTION_GANG || GetFactionType(playerid) == FACTION_NEWS)
	    return SendClientMessage(playerid, COLOR_GRAD1, "   You must be a member of a faction.");

    if(PlayerData[playerid][pFactionRank] > 2)
  		return SendErrorMessage(playerid, "Voc? n?o esta autorizado a utilizar este coomando.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/(gov)ernment [mensagem]");

	if(strlen(params) > 67)
	{
	    SendClientMessageToAllEx(COLOR_GOVA, "[Government Announcement]: %.67s", params);
	    SendClientMessageToAllEx(COLOR_GOVA, "[Government Announcement]: ... %s", params[67]);
	}
	else
	{
	    SendClientMessageToAllEx(COLOR_GOVA, "[Government Announcement]: %s", params);
	}
	return true;
}

YCMD:f(playerid, params[], help) = fchat;
YCMD:g(playerid, params[], help) = fchat;

CMD:fchat(playerid, params[])
{
    new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	new color = FactionData[factionid][factionColorChat];

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/f [mensagem]");

	if(FactionData[factionid][factionChat] && !HasFactionRank(playerid, 2))
	    return SendErrorMessage(playerid, "Faction chat is disabled and your rank does not have ignore mute permissions.");

	new string[256], bool:toggle;

    if(PlayerFlags[playerid][factionChat])
	{
		toggle = true;

		PlayerFlags[playerid][factionChat] = false;
	}

	format(string, sizeof(string), "{%06x}**(( %s %s: %s ))**", FactionData[factionid][factionColorChat] >>> 8, Faction_GetRank(playerid), ReturnName(playerid, 0), params);

	foreach (new i : Player)
	{
		if(FactionEars{i} || PlayerData[i][pFaction] == factionid && !PlayerFlags[i][factionChat])
		{
			if(strlen(string) > 120)
			{
			    SendClientMessageEx(i, color, "%.120s", string);
			    SendClientMessageEx(i, color, "%s", string[120]);
			}
			else SendClientMessage(i, color, string);
		}
	}

	if(toggle) SendNoticeMessage(playerid, "/togfam has automatically been toggled as a result of you sending a message.");

	return true;
}

CMD:drugstore(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	if(!HasFactionRank(playerid, 1))
	    return SendErrorMessage(playerid, "Você não é o líder.");

	SendClientMessage(playerid, COLOR_GREY, "Em breve");
	return true;
}

CMD:managespawns(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	if(!HasFactionRank(playerid, 1))
	    return SendErrorMessage(playerid, "You're not the leader.");

    ShowFactionSpawns(playerid, factionid);
	return true;
}

CMD:factionmenu(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	if(!HasFactionRank(playerid, 1))
	    return SendErrorMessage(playerid, "You're not the leader.");

    ShowPlayerEditFaction(playerid, factionid);
	return true;
}

CMD:ajudafaccao(playerid, params[])
{
    new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
    	return SendErrorMessage(playerid, "You are not in a faction.");

    SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s Commands:", FactionData[factionid][factionName]);

    switch(GetFactionType(playerid))
    {
		case FACTION_POLICE, FACTION_SHERIFF:
		{
			SendClientMessage(playerid, COLOR_WHITE, "/(gov)ernment (/r)adio (/d)epartments (/m)egaphone /trabalho /uniforme /meuuniforme /porta /tolls /handcuff ");
			SendClientMessage(playerid, COLOR_WHITE, "/unhandcuff /carsign /remove_carsign /frisk /revoke /roadblock /cone /disband /siren /mdc /takedrugs");
			SendClientMessage(playerid, COLOR_WHITE, "/jail /prison /taser /vehiclefine /vehiclefines /fine /fines /swat /createscene /towcars /towcar /respawncar");
		}
		case FACTION_MEDIC:
		{
			SendClientMessage(playerid, COLOR_WHITE, "/trabalho /uniforme /(dep)artments /operation /putinambu /curar");
			SendClientMessage(playerid, COLOR_WHITE, "/siren /carsign /remove_carsign /towcars /towcar /respawncar");
		}
		default:
		{
			SendClientMessage(playerid, COLOR_WHITE, "Not applicable.");
		}
    }

	return true;
}

CanFactionInvite(playerid)
{
	if(PlayerData[playerid][pFaction] == -1) return false;

	switch(GetFactionType(playerid))
	{
		case FACTION_POLICE:
		{
			if(PlayerData[playerid][pFactionRank] <= 4 || FactionPermissions[playerid] <= 4) // Commander and UP.
			{
				return true;
			}
		}
		default:
		{
			if(PlayerData[playerid][pFactionRank] <= 1 || FactionPermissions[playerid] <= 1)
			{
				return true;
			}
		}
	}

	return false;
}

CMD:invite(playerid, params[])
{
	if(!CanFactionInvite(playerid))
	    return SendUnauthMessage(playerid, "Your rank is lacking power to invite members.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/invite [ID/Mask/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

    if(PlayerData[userid][pFaction] != -1)
	    return SendErrorMessage(playerid, "This player is already in a faction.");

	if(playerid == userid)
		return SendErrorMessage(playerid, "You can't invite yourself.");	

	PlayerData[userid][pFactionOffer] = playerid;
    PlayerData[userid][pFactionOffered] = PlayerData[playerid][pFaction];

   	SendClientMessageEx(playerid, COLOR_YELLOW, "You invited %s to join %s, they'll have to accept first.", ReturnName(userid, 0), Faction_GetName(playerid));

    SendClientMessageEx(userid, COLOR_YELLOW, "%s invited you to join %s, type /aceitar to accept the invitation.", ReturnName(playerid, 0), Faction_GetName(playerid));
    SendClientMessage(userid, COLOR_YELLOW, "You can use /recusar if you don't want to join.");
	return true;
}

CMD:uninvite(playerid, params[])
{
	if(!CanFactionInvite(playerid))
	    return SendUnauthMessage(playerid, "Your rank does not have any uninvite power at all.");

    new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/uninvite [ID/Mask/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(PlayerData[userid][pFaction] != PlayerData[playerid][pFaction])
	    return SendErrorMessage(playerid, "This player is not in your faction.");

	if(playerid == userid)
		return SendErrorMessage(playerid, "You can't uninvite yourself.");	

    SendClientMessageEx(playerid, COLOR_YELLOW, "You have successfully removed %s from your faction.", ReturnName(userid, 0));
    SendClientMessageEx(userid, COLOR_YELLOW, "You have been removed from your faction by %s.", ReturnName(playerid, 0));

    ResetFaction(userid);
	return true;
}

CMD:rank(playerid, params[])
{
    new factionid = PlayerData[playerid][pFaction];

	if(factionid == -1)
	    return SendErrorMessage(playerid, "You are not in any faction, you cannot rank anyone.");

	/*if(!HasFactionRank(playerid, 2))
	    return SendUnauthMessage(playerid, "Your rank is lacking power to rank members.");*/

	if(!CanFactionInvite(playerid))
	    return SendUnauthMessage(playerid, "Your rank is lacking power to invite members.");		

    new
	    userid,
		rankid
	;

	if(sscanf(params, "ud", userid, rankid))
	{
	    for(new i = 0; i < FactionData[factionid][factionRanks]; ++i)
	    {
	        if(strlen(FactionRanks[factionid][i]) > 0)
	        {
	        	SendClientMessageEx(playerid, COLOR_YELLOW, "Rank %d: %s", i + 1, FactionRanks[factionid][i]);
			}
	    }

	    return SendSyntaxMessage(playerid, "/rank [id/nome] [NewRankID]");
	}

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{d}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(PlayerData[userid][pFaction] != PlayerData[playerid][pFaction])
	    return SendErrorMessage(playerid, "This player is not in your faction.");

	if(rankid < 1 || rankid > FactionData[PlayerData[playerid][pFaction]][factionRanks])
	    return SendClientMessageEx(playerid, COLOR_GRAD1, "   Invalid rank. Rank must be between 1 to %d", FactionData[PlayerData[playerid][pFaction]][factionRanks]);

	if(PlayerData[playerid][pFactionRank] == PlayerData[userid][pFactionRank] || rankid < PlayerData[playerid][pFactionRank])
		return SendUnauthMessage(playerid, "You cannot modify ranks of people qeuivalent to your rank permission (%d) nor set people higher than it.", PlayerData[playerid][pFactionRank]);

	new oldrank = PlayerData[userid][pFactionRank] - 1, faction = PlayerData[userid][pFaction];

	PlayerData[userid][pFactionRank] = rankid;

	SendClientMessageEx(userid, COLOR_YELLOW, "Your rank has been updated from %s to %s by %s", ReturnRank(faction, oldrank), Faction_GetRank(userid), ReturnName(playerid, 0));
	SendClientMessageEx(playerid, COLOR_YELLOW, "Rank of %s changed to %s", ReturnName(userid, 0), Faction_GetRank(userid));
	return true;
}

stock CanUseMDC(playerid, type)
{
	if(PlayerData[playerid][pAdmin]) return true;

	switch(type)
	{
		case FACTION_POLICE, FACTION_SHERIFF:
			return true;
		default:
			return false;
	}

	return false;
}

CMD:aceitar(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/aceitar masculino ou /aceitar feminino, escreva corretamente.");

	if(PlayerData[playerid][pFactionOffer] == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você não tem nenhum convite para aceitar.");

	if(strcmp(params, "male", false) == 0 || strcmp(params, "female", true) == 0)
	{
	    new 
			targetid = PlayerData[playerid][pFactionOffer], 
			factionid = PlayerData[playerid][pFactionOffered]
		;

		if(!FactionData[factionid][factionExists] || PlayerData[targetid][pFactionRank] > 1)
		{
		    PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        	PlayerData[playerid][pFactionOffered] = -1;
	   	 	return SendErrorMessage(playerid, "A facção não existe ou você já está nela.");
		}

		SetFaction(playerid, factionid);

		new rank;

		for(new i = 18; i >= 0; i--)
		{
		    if(strlen(FactionRanks[factionid][i]) >= 1)
		    {
		        rank = i + 1;
		        break;
		    }
		}

		PlayerData[playerid][pFactionRank] = rank;

		SendClientMessageEx(playerid, COLOR_YELLOW, "Agora você é um membro da %s!", Faction_GetName(targetid));
		SendClientMessageEx(targetid, COLOR_YELLOW, "%s juntou-se à sua facção %s.", ReturnName(playerid, 0), Faction_GetName(targetid));

		AssignFactionPermissions(playerid);

        PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pFactionOffered] = -1;

  		if(IsPolice(playerid) && PlayerData[playerid][pAdmin] < 1)
		{
			if(!MDC_Created{playerid})
			{
				InitMDC(playerid);
			}
		}

 		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Faction` = '%d', `FactionRank` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pFactionID], PlayerData[playerid][pFactionRank], PlayerData[playerid][pID]);
		mysql_tquery(dbCon, gquery);
	}
	else SendSyntaxMessage(playerid, "/aceitar masculino ou /aceitar feminino, escreva corretamente.");

	return true;
}

CMD:recusar(playerid, params[])
{
	if(PlayerData[playerid][pFactionOffer] == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você não tem nenhum convite para recusar.");

	new
		targetid = PlayerData[playerid][pFactionOffer],
		factionid = PlayerData[playerid][pFactionOffered]
	;

	if(!FactionData[factionid][factionExists] || PlayerData[targetid][pFactionRank] > 1)
	{
		PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pFactionOffered] = -1;
	   	return SendErrorMessage(playerid, "A facção não existe ou você já está nela.");
	}

	PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
	PlayerData[playerid][pFactionOffered] = -1;

	SendClientMessageEx(playerid, COLOR_YELLOW, "Você recusou o convite para %s.", Faction_GetName(targetid));
	SendClientMessageEx(targetid, COLOR_YELLOW, "%s recusou seu convite de facção para %s.", ReturnName(playerid, 0), Faction_GetName(targetid));
	return true;
}

CMD:portao(playerid, params[])
{
	new
		Float:fDistance[2] = {99999.0, 0.0},
		i = -1
	;

	foreach (new x : Gates)
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, Gates[x][gatePosX], Gates[x][gatePosY], Gates[x][gatePosZ]);

		if(fDistance[1] < fDistance[0])
		{
			fDistance[0] = fDistance[1];

			i = x;
		}
	}

	if(i != -1 && fDistance[0] < 10)
	{
		if(Gates[i][gateFaction] == -1 || (Gates[i][gateFaction] != -1 && GateFactionPermissible(playerid, Gates[i][gateFaction], GetFactionType(playerid))))
		{
			if(Gates[i][gateOpened] == 1)
			{
				Gates[i][gateOpened] = 0;

				MoveDynamicObject(Gates[i][gateObject], Gates[i][gatePosX], Gates[i][gatePosY], Gates[i][gatePosZ], Gates[i][gateOpenSpeed], Gates[i][gatePosRX], Gates[i][gatePosRY], Gates[i][gatePosRZ]);
			}
			else
			{
				if(Gates[i][gateLocked])
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Portão trancada.");

				Gates[i][gateOpened] = 1;

				MoveDynamicObject(Gates[i][gateObject], Gates[i][gateMoveX], Gates[i][gateMoveY], Gates[i][gateMoveZ], Gates[i][gateOpenSpeed], Gates[i][gateMoveRX], Gates[i][gateMoveRY], Gates[i][gateMoveRZ]);
			}
			return true;
		}
	}
	return true;
}

GateFactionPermissible(playerid, gatefaction, faction)
{
	if(PlayerData[playerid][pAdmin] >= 4 && AdminDuty{playerid}) return true;
	if(gatefaction == faction) return true;
	if(gatefaction == FACTION_POLICE && faction == FACTION_SHERIFF) return true;
	if(gatefaction == FACTION_SHERIFF && faction == FACTION_POLICE) return true;
	if(gatefaction == FACTION_CORRECTIONAL && (faction == FACTION_POLICE || faction == FACTION_SHERIFF)) return true;
	return false;
}

CMD:porta(playerid, params[])
{
	new house = -1;

	if((house = InProperty[playerid]) != -1)
	{
		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		for(new x = 0; x != MAX_FURNITURE; ++x)
		{
			if(HouseFurniture[house][x][fOn] && isHouseDoor(HouseFurniture[house][x][fModel]))
			{
			    fDistance[1] = GetPlayerDistanceFromPoint(playerid, HouseFurniture[house][x][fPosX], HouseFurniture[house][x][fPosY], HouseFurniture[house][x][fPosZ]);

				if(fDistance[1] < fDistance[0])
				{
				    fDistance[0] = fDistance[1];

				    i = x;
				}
			}
		}

		if(i != -1 && fDistance[0] < 3)
		{
			if(HouseFurniture[house][i][fOpened] == false)
			{
				if(HouseFurniture[house][i][fLocked] == 1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Porta trancada.");

                HouseFurniture[house][i][fOpened] = true;

				MoveDynamicObject(HouseFurniture[house][i][fObject], HouseFurniture[house][i][fPosX], HouseFurniture[house][i][fPosY], HouseFurniture[house][i][fPosZ]/*+0.01*/, /*0.01*/1, HouseFurniture[house][i][fPosRX], HouseFurniture[house][i][fPosRY], HouseFurniture[house][i][fPosRZ]-90.0);
			}
			else
			{
				HouseFurniture[house][i][fOpened] = false;

				MoveDynamicObject(HouseFurniture[house][i][fObject], HouseFurniture[house][i][fPosX], HouseFurniture[house][i][fPosY], HouseFurniture[house][i][fPosZ], /*0.01*/1, HouseFurniture[house][i][fPosRX], HouseFurniture[house][i][fPosRY], HouseFurniture[house][i][fPosRZ]);
			}
			return true;
		}
		return true;
	}
	if((house = InBusiness[playerid]) != -1)
	{
		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		for(new x = 0; x != MAX_FURNITURE; ++x)
		{
			if(BizFurniture[house][x][fOn] && isHouseDoor(BizFurniture[house][x][fModel]))
			{
			    fDistance[1] = GetPlayerDistanceFromPoint(playerid, BizFurniture[house][x][fPosX], BizFurniture[house][x][fPosY], BizFurniture[house][x][fPosZ]);

				if(fDistance[1] < fDistance[0])
				{
				    fDistance[0] = fDistance[1];

				    i = x;
				}
			}
		}

		if(i != -1 && fDistance[0] < 3)
		{
			if(BizFurniture[house][i][fOpened] == false)
			{
				if(BizFurniture[house][i][fLocked] == 1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Porta trancada.");

                BizFurniture[house][i][fOpened] = true;

				MoveDynamicObject(BizFurniture[house][i][fObject], BizFurniture[house][i][fPosX], BizFurniture[house][i][fPosY], BizFurniture[house][i][fPosZ]/*+0.01*/, /*0.01*/1, BizFurniture[house][i][fPosRX], BizFurniture[house][i][fPosRY], BizFurniture[house][i][fPosRZ]-90.0);
			}
			else
			{
				BizFurniture[house][i][fOpened] = false;

				MoveDynamicObject(BizFurniture[house][i][fObject], BizFurniture[house][i][fPosX], BizFurniture[house][i][fPosY], BizFurniture[house][i][fPosZ], /*0.01*/1, BizFurniture[house][i][fPosRX], BizFurniture[house][i][fPosRY], BizFurniture[house][i][fPosRZ]);
			}
			return true;
		}
		return true;
	}
	else if((house = FindNearestCell(playerid)) != -1)
	{
		TogglePrisonCell(house);
	}	
    else
	{
		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		foreach (new x: Movedoors)
		{
			fDistance[1] = GetPlayerDistanceFromPoint(playerid, Doors[x][doorPosX], Doors[x][doorPosY], Doors[x][doorPosZ]);

			if(fDistance[1] < fDistance[0])
			{
				fDistance[0] = fDistance[1];

				i = x;
			}
		}

		if(i != -1 && fDistance[0] < 3)
		{
			if(Doors[i][doorFaction] == -1 || (Doors[i][doorFaction] != -1 && GetFactionType(playerid) == Doors[i][doorFaction]))
			{
				if(Doors[i][doorOpened] == 1)
				{
					Doors[i][doorOpened] = 0;

					MoveDynamicObject(Doors[i][doorObject], Doors[i][doorPosX], Doors[i][doorPosY], Doors[i][doorPosZ], Doors[i][doorOpenSpeed], Doors[i][doorPosRX], Doors[i][doorPosRY], Doors[i][doorPosRZ]);
				}
				else
				{
					if(Doors[i][doorLocked])
					    return SendClientMessage(playerid, COLOR_LIGHTRED, "Porta trancada.");

					Doors[i][doorOpened] = 1;

					MoveDynamicObject(Doors[i][doorObject], Doors[i][doorMoveX], Doors[i][doorMoveY], Doors[i][doorMoveZ], Doors[i][doorOpenSpeed], Doors[i][doorMoveRX], Doors[i][doorMoveRY], Doors[i][doorMoveRZ]);
				}
				return true;
			}
		}
	}
	return true;
}

CMD:elevador(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	    return SendErrorMessage(playerid, "Você não está a pé.");

	foreach	(new i: Entrance)
	{
	    if(EntranceData[i][pointType] != POINT_TYPE_ELEVATOR) continue;

	    if(InApartment[playerid] != EntranceData[i][outsideApartmentID] && InApartment[playerid] != EntranceData[i][insideApartmentID]) continue;

	    if(IsPlayerInRangeOfPoint(playerid, EntranceData[i][pointRange], EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]))
	    {
	        if(EntranceData[i][insidePos][0] == 0.0)
	        {
	            if(PlayerData[playerid][pAdmin] == 1337)
	            {
					SendErrorMessage(playerid, "As coordenadas de saída ainda não foram definidas para este ponto (id #d).", i);
	            }
	            return true;
	        }

	        SetPlayerPosEx(playerid, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]);
	        SetPlayerFacingAngle(playerid, EntranceData[i][insidePos][3]);

	        if(EntranceData[i][insideApartmentID] != -1)
	        {
				SetPlayerInteriorEx(playerid, ComplexData[ EntranceData[i][insideApartmentID] ][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[ EntranceData[i][insideApartmentID] ][aWorld]);

				PlayerData[playerid][pLocal] = EntranceData[i][insideApartmentID] + LOCAL_APARTMENT;
	        }
	        else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				DesyncPlayerInterior(playerid);
			}

            InApartment[playerid] = EntranceData[i][insideApartmentID];
	        return true;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, EntranceData[i][pointRange], EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]))
	    {
			SetPlayerPosEx(playerid, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]);
			SetPlayerFacingAngle(playerid, EntranceData[i][outsidePos][3]);

	        if(EntranceData[i][outsideApartmentID] != -1)
	        {
				SetPlayerInteriorEx(playerid, ComplexData[ EntranceData[i][outsideApartmentID] ][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[ EntranceData[i][outsideApartmentID] ][aWorld]);

				PlayerData[playerid][pLocal] = EntranceData[i][outsideApartmentID] + LOCAL_APARTMENT;
	        }
	        else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				DesyncPlayerInterior(playerid);
			}

            InApartment[playerid] = EntranceData[i][outsideApartmentID];
	        return true;
	    }
	}

	SendErrorMessage(playerid, "Você não está perto de um elevador.");
	return true;
}

CMD:entrar(playerid, params[])
{
	new id, str[128];

	if((id = nearApartment_var[playerid]) != -1)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.5, ComplexData[id][aEntranceX], ComplexData[id][aEntranceY], ComplexData[id][aEntranceZ]))
	    {
		    if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode entrar em um complexo de apartamentos enquanto estiver dentro de um veículo");

		    if(ComplexData[id][aLocked] == 1)
				return SendNoticeMessage(playerid, "%s está trancado.", ComplexData[id][aInfo]);

			SetPlayerPosEx(playerid, ComplexData[id][aExitX], ComplexData[id][aExitY], ComplexData[id][aExitZ]);
			SetPlayerInteriorEx(playerid, ComplexData[id][aInterior]);
			SetPlayerVirtualWorldEx(playerid, ComplexData[id][aWorld]);

			InApartment[playerid] = id;
			InProperty[playerid] = -1;
			InBusiness[playerid] = -1;

			PlayerData[playerid][pLocal] = id + LOCAL_APARTMENT;

			SQL_LogAction(playerid, "Entered complex id %d", ComplexData[id][aID]);
			return true;
		}
	}
	else if((id = nearProperty_var[playerid]) != -1)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.5, PropertyData[id][hEntranceX], PropertyData[id][hEntranceY], PropertyData[id][hEntranceZ]))
	    {
		    if(IsPlayerInAnyVehicle(playerid))
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode entrar em uma casa enquanto estiver dentro de um veículo");

			if(PropertyData[id][hLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Trancada", 5000, 1);

			SetPlayerPosEx(playerid, PropertyData[id][hExitX], PropertyData[id][hExitY], PropertyData[id][hExitZ]);
			SetPlayerInteriorEx(playerid, PropertyData[id][hInterior]);
			SetPlayerVirtualWorldEx(playerid, PropertyData[id][hWorld]);

			InProperty[playerid] = id;
			InBusiness[playerid] = -1;
			InApartment[playerid] = -1;

			PlayerData[playerid][pLocal] = id + LOCAL_HOUSE;

			if(PlayerData[playerid][pHouseKey] == id) GameTextForPlayer(playerid, "~w~Bem-vindo à sua casa", 5000, 1);

			if(PropertyData[id][hradioOn]) PlayAudioStreamForPlayer(playerid, PropertyData[id][hradioURL]);

			SQL_LogAction(playerid, "Entered property id %d", PropertyData[id][hID]);
			return true;
		}
	}
	else if((id = Business_Nearest(playerid)) != -1)
	{
		if(BusinessData[id][bType] == 4) return ShowPlayerDealershipMenu(playerid);

		if(BusinessData[id][bExitX] != 0.0 && BusinessData[id][bExitY] != 0.0)
		{
		    if(BusinessData[id][bType] != 6)
		    {
			    if(IsPlayerInAnyVehicle(playerid))
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode entrar em uma empresa enquanto estiver dentro de um veículo");
		    }

			if(BusinessData[id][bType] != 6)
			{
				if(BusinessData[id][bLocked] == 1)
					return GameTextForPlayer(playerid, "~r~Fechada", 5000, 1);
			}

			if(PlayerData[playerid][pPbiskey] != id)
			{
				if(BusinessData[id][bEntranceCost])
				{
				    if((gettime() - BizzEntrance[playerid][id]) <= 180)
				    {
				        if(PlayerData[playerid][pCash] < BusinessData[id][bEntranceCost])
				            return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro suficiente para pagar a taxa de entrada.");

						TakePlayerMoney(playerid, BusinessData[id][bEntranceCost]);

						BusinessData[id][bTill] += BusinessData[id][bEntranceCost];

						format(str, sizeof(str), "~r~-$%d~n~~w~digite /sair~n~para sair", BusinessData[id][bEntranceCost]);
						GameTextForPlayer(playerid, str, 5000, 3);
					}
				}
			}

			switch(BusinessData[id][bType])
			{
			    case 2:
				{
					SendClientMessage(playerid, COLOR_GREEN, "/buygun para comprar armas");
				}
			    case 3:
				{
					SendClientMessage(playerid, COLOR_GREEN, "24/7 Supermarket: /comprar /sacar /saldo");
				}
  				case 6:
				{
			 		if(!IsPlayerInAnyVehicle(playerid))
					 	return true;

			 		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			 		    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é motorista.");

				    foreach (new p : Player)
				    {
				    	if(InBusiness[p] == id)
				     	{
				        	return SendClientMessage(playerid, COLOR_WHITE, "Este Pay N Spray está cheio.");
				        }
		        	}

		        	if(PlayerData[playerid][pCash] < 1500)
						return GameTextForPlayer(playerid, "~r~dinheiro insuficiente", 2000, 1);

                    TogglePlayerControllable(playerid, false);

					GameTextForPlayer(playerid, BusinessData[id][bInfo], 2000, 1);
					SendClientMessage(playerid, COLOR_GREEN, "Consertando seu veículo!");
					SendClientMessage(playerid, COLOR_GREEN, "Auto-Voice: Você será movido em 10 segundos");

					new vehicleid = GetPlayerVehicleID(playerid);
					SetVehiclePos(vehicleid, BusinessData[id][bExitX], BusinessData[id][bExitY], BusinessData[id][bExitZ]);

					InBusiness[playerid] = id;
					InProperty[playerid] = -1;
					InApartment[playerid] = -1;

					SetTimerEx("SendPlayerToExit", 10000, false, "ddd", playerid, vehicleid, id);
					return true;
				}
				case 8: // Bars
				{
				    //SendClientMessage(playerid, COLOR_GREEN, "Tobacco & Drinks /buyitem /buycomp");
				}
			    case 9: // Restaurant
				{
					switch(BusinessData[id][bsubType])
					{
				        case 1: // Pizza
				        {
			        		SendClientMessage(playerid, COLOR_WHITE, "This is a {FF6347}pizza restaurant{FFFFFF}.");
						}
				        case 2: // Donut
				        {
			        		SendClientMessage(playerid, COLOR_WHITE, "This is a {FF6347}donut restaurant{FFFFFF}.");
						}
				        case 3: // Burger
				        {
			        		SendClientMessage(playerid, COLOR_WHITE, "This is a {FF6347}chicken fast-food{FFFFFF}.");
						}
				        case 4: // Chicken Bell
				        {
			        		SendClientMessage(playerid, COLOR_WHITE, "This is a {FF6347}chicken fast-food{FFFFFF}.");
						}
					}

					SendClientMessage(playerid, COLOR_WHITE, "Você pode pedir comida aqui. Use {FF6347}/comer{FFFFFF} or {FF6347}/comida pedir{FFFFFF}.");
				}
				case 12:
				{
					SendClientMessage(playerid, COLOR_GREEN, "Banco: /saldo /sacar /depositar /savings");
				}
				case 13:
				{
				    SendClientMessage(playerid, COLOR_GREEN, "/buyweapon to purchase non-finalized weapons");
				}
			}

   			GameTextForPlayer(playerid, BusinessData[id][bInfo], 5000, 1);

			SetPlayerPosEx(playerid, BusinessData[id][bExitX], BusinessData[id][bExitY], BusinessData[id][bExitZ]);
			SetPlayerInteriorEx(playerid, BusinessData[id][bInterior]);
			SetPlayerVirtualWorldEx(playerid, BusinessData[id][bWorld]);

			InBusiness[playerid] = id;
			InProperty[playerid] = -1;
			InApartment[playerid] = -1;

			PlayerData[playerid][pLocal] = id + LOCAL_BIZZ;

			if(BusinessData[id][bradioOn]) PlayAudioStreamForPlayer(playerid, BusinessData[id][bradioURL]);

			SQL_LogAction(playerid, "Entered business id %d", BusinessData[id][bID]);
		}
		else
		{
			if(PlayerData[playerid][pAdmin] == 1337)
			{
				SendErrorMessage(playerid, "Esta empresa não tem um interior setado.");
			}
		}
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 188.1628, 1933.2343, 17.6747)) // Outside > Guard Access Block
	{
		SetPlayerPosEx(playerid, 1273.3226, 884.7640, 1161.0986);
		SyncPrisonInterior(playerid);	
		return true;
	}	
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 221.6526, 1919.2972, 18.1025)) // Yard > Prison Hallway
	{
		SetPlayerPosEx(playerid, -467.3096, 1843.7053, 940.8353);
		SyncPrisonInterior(playerid, true);
		return true;
	}	
	else if(IsPlayerInRangeOfPoint(playerid, 1.5, 1097.8438, -1690.8442, 17.1001)) // Metro Enter Main Lobby
	{
		SetPlayerDynamicPos(playerid, 1097.8411, -1687.6068, 17.0860);
		return true;
	}

	// Dynamic Points
	foreach	(new i: Entrance)
	{
	    if(InApartment[playerid] != EntranceData[i][outsideApartmentID]) continue;

	    if(IsPlayerInRangeOfPoint(playerid, EntranceData[i][pointRange], EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]))
	    {
		    if(EntranceData[i][pointType] == POINT_TYPE_ELEVATOR)
		        return SendErrorMessage(playerid, "Este é um /elevador, então /entrar /sair não funciona.");

	        if(EntranceData[i][insidePos][0] == 0.0)
	        {
	            if(PlayerData[playerid][pAdmin] == 1337)
	            {
					SendErrorMessage(playerid, "As coordenadas de saída ainda não foram definidas para este ponto (id #d).", i);
	            }
	            return true;
	        }

			if(EntranceData[i][pointLocked])
				return SendNoticeMessage(playerid, "%s esta trancado.", EntranceData[i][pointName]);

	        switch(EntranceData[i][pointType])
	        {
	            case POINT_TYPE_ONFOOT:
	            {
	                if(IsPlayerInAnyVehicle(playerid)) return true;

	                SetPlayerPosEx(playerid, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]);
	                SetPlayerFacingAngle(playerid, EntranceData[i][insidePos][3]);
	            }
				case POINT_TYPE_VEHICLE:
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;

					new vehicleid = GetPlayerVehicleID(playerid);

					SetVehicleDynamicPos(vehicleid, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2], playerid);
					SetVehicleZAngle(vehicleid, EntranceData[i][insidePos][3]);

			        if(EntranceData[i][insideApartmentID] != -1)
			        {
			            LinkVehicleToInterior(vehicleid, ComplexData[ EntranceData[i][insideApartmentID] ][aInterior]);
			            SetVehicleVirtualWorld(vehicleid, ComplexData[ EntranceData[i][insideApartmentID] ][aWorld]);
			        }
				}
				case POINT_TYPE_BOTH:
				{
				    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				    {
						new vehicleid = GetPlayerVehicleID(playerid);

						SetVehicleDynamicPos(vehicleid, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2], playerid);
						SetVehicleZAngle(vehicleid, EntranceData[i][insidePos][3]);

				        if(EntranceData[i][insideApartmentID] != -1)
				        {
				            LinkVehicleToInterior(vehicleid, ComplexData[ EntranceData[i][insideApartmentID] ][aInterior]);
				            SetVehicleVirtualWorld(vehicleid, ComplexData[ EntranceData[i][insideApartmentID] ][aWorld]);
				        }
				    }
				    else
				    {
				        if(IsPlayerInAnyVehicle(playerid)) return true;

				        SetPlayerPosEx(playerid, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]);
				        SetPlayerFacingAngle(playerid, EntranceData[i][insidePos][3]);
				    }
				}
	        }

			if(PlayerData[playerid][pLocal] == 999) return true;

	        if(EntranceData[i][insideApartmentID] != -1)
	        {
				SetPlayerInteriorEx(playerid, ComplexData[ EntranceData[i][insideApartmentID] ][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[ EntranceData[i][insideApartmentID] ][aWorld]);

				PlayerData[playerid][pLocal] = EntranceData[i][insideApartmentID] + LOCAL_APARTMENT;
	        }
	        else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				DesyncPlayerInterior(playerid);
			}

            InApartment[playerid] = EntranceData[i][insideApartmentID];
	        return true;
	    }
	}
	return true;
}

FUNX::SendPlayerToExit(playerid, vehicleid, id)
{
	if(GetPlayerVehicleID(playerid) != vehicleid)
	{
	    SetVehiclePos(vehicleid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ]);
	    SetPlayerDynamicPos(playerid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ] + 2);
	}
	else
	{
	    SetVehiclePos(vehicleid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ]);
	}

	CoreVehicles[vehicleid][startup_delay_sender] = INVALID_PLAYER_ID;
	CoreVehicles[vehicleid][startup_delay] = 0;
	CoreVehicles[vehicleid][startup_delay_random] = 0;
	CoreVehicles[vehicleid][vehCrash] = 0;
	CoreVehicles[vehicleid][vehicleBadlyDamage] = 0;

	TogglePlayerControllable(playerid, true);

	DesyncPlayerInterior(playerid);
}

CMD:comer(playerid, params[])
{
	Business_FoodMenu(playerid);
	return true;
}

CMD:comida(playerid, params[])
{
	new type[24], menuid, value;

	if(sscanf(params, "s[24]D()D()", type, menuid, value))
 	{
	    SendClientMessage(playerid, COLOR_GRAD3, "Comandos disponíveis:");
	    SendClientMessage(playerid, -1, "{FF6347}/comida pedir {FFFFFF}- abre o menu do restaurante.");
        SendClientMessage(playerid, -1, "{FF6347}/comida fechar {FFFFFF}- fecha o menu de pedidos");
        SendClientMessage(playerid, -1, "{FF6347}/comida colocar {FFFFFF}- se você estiver segurando uma bandeja de refeição, você pode colocá-la sobre uma mesa");
        SendClientMessage(playerid, -1, "{FF6347}/comida pegar {FFFFFF}- você pode pegar sua bandeja de refeição.");
        SendClientMessage(playerid, -1, "{FF6347}/comida jogar {FFFFFF}- jogue fora sua bandeja de refeição.");
        SendClientMessage(playerid, -1, "{FF6347}/comida config {FFFFFF}- menu de configuração para proprietários de restaurantes");
		return true;
	}

	if(!strcmp(type, "fechar", true))
	{
		for(new i = 0; i != sizeof(TD_Restaurant); ++i)
			TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

        for(new i = 0; i != 9; ++i)
			PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

        CancelSelectTextDraw(playerid);
	}
	else if(!strcmp(type, "pedir", true))
	{
		Business_FoodMenu(playerid);
	}
	else if(!strcmp(type, "colocar", true))
	{
		if(IsHoldingMeal(playerid))
		{
            if(MealObject[playerid] == -1)
            {
		 		new Float:px, Float:py, Float:pz, Float:a;

				GetPlayerPos(playerid, px, py, pz);
				GetPlayerFacingAngle(playerid, a);

				px += (0.2 * floatsin(-a + 90.0, degrees));
				py += (0.2 * floatcos(-a + 90.0, degrees));

				px += (1.0 * floatsin(-a, degrees));
				py += (1.0 * floatcos(-a, degrees));

				if(MealHolding[playerid] >= 2221 && MealHolding[playerid] <= 2223)
				{
				    MealObject[playerid] = MealPlace(MealHolding[playerid], px, py, pz,0, 0, a + 67.5, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
				}
				else MealObject[playerid] = MealPlace(MealHolding[playerid], px, py, pz,-25.600013, 22.000013, a + 67.5, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));


                EditDynamicObject(playerid, MealDrop[MealObject[playerid]][mObject]);
                SetPlayerThrowMeal(playerid);

                SendClientMessage(playerid, COLOR_LIGHTRED, "Agora você pode posicionar sua bandeja. Pressione ESC para retornar, clique no ícone salvar para salvar.");
			}
            else SendErrorMessage(playerid, "Você não pediu uma refeição.");
		}
		else SendErrorMessage(playerid, "Você não está segurando uma bandeja de refeição.");
	}
	else if(!strcmp(type, "pegar", true))
	{
		if(GetPlayerNearMeal(playerid))
		{
		    MealHolding[playerid] = MealDrop[MealObject[playerid]][mID];

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);

			MealDestroy(MealObject[playerid]);
			MealObject[playerid] = -1;
		}
		else SendErrorMessage(playerid, "Você não está perto da bandeja de comida.");
	}
	else if(!strcmp(type, "jogar", true))
	{
    	if(MealObject[playerid] != -1 || IsHoldingMeal(playerid))
      	{
            SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s joga a bandeja de comida fora.", ReturnName(playerid, 0));

			if(MealObject[playerid] != -1)
			{
			    MealDestroy(MealObject[playerid]);
			    MealObject[playerid] = -1;
			    return true;
			}

			SetPlayerThrowMeal(playerid);
      	}
      	else SendClientMessage(playerid, -1, "Nada para jogar fora.");
	}
	else if(!strcmp(type, "config", true))
	{
	    new id = -1;

		if((id = Business_Inside(playerid)) != -1)
		{
			if(Business_IsOwner(playerid, id))
			{
			    if(BusinessData[InBusiness[playerid]][bType] == 9)
			    {
				    if(sscanf(params, "{s[24]}dd", menuid, value))
				    {
						SendClientMessage(playerid, COLOR_GRAD2, "USE: /comida config [menuid] [preço]");
						SendClientMessage(playerid, -1, "{FF6347}[Menu]");

						switch(BusinessData[InBusiness[playerid]][bsubType])
						{
						    case 1:
						    {
	          					SendClientMessageEx(playerid, -1, "1. Buster - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));
	          					SendClientMessageEx(playerid, -1, "2. Double D-Luxe - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));
	          					SendClientMessageEx(playerid, -1, "3. Full Rack - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));
	          					SendClientMessageEx(playerid, -1, "4. Salad Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));
						    }
						    case 2:
						    {
	          					SendClientMessageEx(playerid, -1, "1. Rusty's D-Luxe - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));
	          					SendClientMessageEx(playerid, -1, "2. Rusty's Double Barrel - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));
	          					SendClientMessageEx(playerid, -1, "3. Rusty's Huge Double - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));
						    }
						    case 3:
						    {
	          					SendClientMessageEx(playerid, -1, "1. Moo Kids Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));
	          					SendClientMessageEx(playerid, -1, "2. Beef Tower - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));
	          					SendClientMessageEx(playerid, -1, "3. Meat Stack - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));
	          					SendClientMessageEx(playerid, -1, "4. Salad Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));
						    }
						    case 4:
						    {
	          					SendClientMessageEx(playerid, -1, "1. Cluckin' Little Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));
	          					SendClientMessageEx(playerid, -1, "2. Cluckin' Big Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));
	          					SendClientMessageEx(playerid, -1, "3. Cluckin' Huge Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));
	          					SendClientMessageEx(playerid, -1, "4. Salad Meal - %s", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));
						    }
						}
				        return 1;
				    }

				    if(menuid >= 1 && (menuid <= 3 || (menuid <= 4 && BusinessData[InBusiness[playerid]][bsubType] != 2)))
				    {
						if(value < 1 || value > 9999)
						    return SendClientMessage(playerid, COLOR_GRAD2, "O preço deve ser no mínimo 1 e menor que 9999.");

						BusinessData[InBusiness[playerid]][bItems][menuid - 1] = value;

						SendClientMessageEx(playerid, COLOR_WHITE, "Você alterou o preço da comida no menu #%d.", menuid);
				    }
				    else SendClientMessage(playerid, COLOR_LIGHTRED, "Item de comida inválido especificado.");
			    }
			    else SendClientMessage(playerid, COLOR_LIGHTRED, "Isso é apenas para restaurantes.");
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o proprietário do restaurante.");
		}
		else
		{
		    SendClientMessage(playerid, -1, "Você não está em um restaurante.");
		}
	}
	return true;
}

stock ShowPlayerRestaurantMenu(playerid, id)
{
	new string[256];

	SendClientMessage(playerid, COLOR_WHITE, "Se você ficar preso no menu, você pode fechá-lo usando {FF6347}/comida fechar{FFFFFF}.");

	PRestaurantOpening{playerid} = true;

	switch(BusinessData[id][bsubType])
	{
		case 1: // Pizza
		{
		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][0], 2218);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][0]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][1], 2219);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][1]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][2], 2220);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][2]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][3], 2355);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][3]);

			format(string, sizeof(string), "Buster~n~~r~Health: +30~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][0]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][4], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][4]);

		    format(string, sizeof(string), "Double D-Luxe~n~~r~Health: +60~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][1]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][5], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][5]);

		    format(string, sizeof(string), "Full Rack~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][2]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][6], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][6]);

		    format(string, sizeof(string), "Salad Meal~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][3]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][7], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][7]);
		}
 		case 2: // Donut
		{
		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][0], 2221);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][0]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][1], 2223);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][1]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][2], 2222);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][2]);

            format(string, sizeof(string), "Rusty's D-Luxe~n~~r~Health: +30~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][0]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][4], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][4]);

            format(string, sizeof(string), "Rusty's Double Barrel~n~~r~Health: +60~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][1]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][5], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][5]);

		    format(string, sizeof(string), "Rusty's Huge Double~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][2]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][6], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][6]);
		}
 		case 3: // Burger
		{
		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][0], 2213);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][0]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][1], 2214);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][1]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][2], 2212);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][2]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][3], 2354);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][3]);

            format(string, sizeof(string), "Moo Kids Meal~n~~r~Health: +30~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][0]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][4], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][4]);

            format(string, sizeof(string), "Beef Tower~n~~r~Health: +60~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][1]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][5], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][5]);

            format(string, sizeof(string), "Meat Stack~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][2]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][6], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][6]);

            format(string, sizeof(string), "Salad Meal~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][3]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][7], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][7]);
		}
 		case 4: // Cluckin
		{
		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][0], 2215);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][0]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][1], 2216);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][1]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][2], 2217);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][2]);

		    PlayerTextDrawSetPreviewModel(playerid,PTD_Restaurant[playerid][3], 2353);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][3]);

            format(string, sizeof(string), "Cluckin' Little Meal~n~~r~Health: +30~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][0]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][4], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][4]);

            format(string, sizeof(string), "Cluckin' Big Meal~n~~r~Health: +60~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][1]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][5], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][5]);

            format(string, sizeof(string), "Cluckin' Huge Meal~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][2]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][6], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][6]);

            format(string, sizeof(string), "Salad Meal~n~~r~Health: +100~n~Removes hunger~n~~b~Price: %s", FormatNumber(BusinessData[id][bItems][3]));
			PlayerTextDrawSetString(playerid,PTD_Restaurant[playerid][7], string);
		    PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][7]);
		}
	}

	for(new i = 0; i != sizeof(TD_Restaurant); ++i)
		TextDrawShowForPlayer(playerid, TD_Restaurant[i]);

    PlayerTextDrawSetString(playerid, PTD_Restaurant[playerid][8], ClearGameTextColor(BusinessData[id][bInfo]));
	PlayerTextDrawShow(playerid, PTD_Restaurant[playerid][8]);

	SelectTextDraw(playerid, 0x00FF00FF);
}

CMD:sair(playerid, params[])
{
	new id;

	if((id = Apartment_Inside(playerid)) != -1)
	{
 		if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[id][aExitX], ComplexData[id][aExitY], ComplexData[id][aExitZ]))
		{
			SetCameraBehindPlayer(playerid);
			SetPlayerPosEx(playerid, ComplexData[id][aEntranceX], ComplexData[id][aEntranceY], ComplexData[id][aEntranceZ], 1000);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);

			DesyncPlayerInterior(playerid);

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

			SQL_LogAction(playerid, "Exited complex id %d", ComplexData[id][aID]);
			return true;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1097.8411, -1687.6068, 17.0860)) // Metro Exit Main Lobby
		{
			SetPlayerDynamicPos(playerid, 1097.8438, -1690.8442, 17.1001);
			return true;
		}		
	}
	else if((id = Property_Inside(playerid)) != -1)
	{
 		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][hExitX], PropertyData[id][hExitY], PropertyData[id][hExitZ]))
		{
			SetCameraBehindPlayer(playerid);

			if(PropertyData[id][hComplexID] != -1)
			{
				SetPlayerPosEx(playerid, PropertyData[id][hEntranceX], PropertyData[id][hEntranceY], PropertyData[id][hEntranceZ], 1000);

				new aptid = PropertyData[id][hComplexID];

				SetPlayerInteriorEx(playerid, ComplexData[aptid][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[aptid][aWorld]);

				InApartment[playerid] = aptid;
				InProperty[playerid] = -1;
				InBusiness[playerid] = -1;

				PlayerData[playerid][pLocal] = aptid + LOCAL_APARTMENT;
			}
			else
			{
				SetPlayerPosEx(playerid, PropertyData[id][hEntranceX], PropertyData[id][hEntranceY], PropertyData[id][hEntranceZ], 1000);

				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);

				DesyncPlayerInterior(playerid);
			}

			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

			if(PropertyData[id][hradioOn]) StopAudioStreamForPlayer(playerid);

			SQL_LogAction(playerid, "Exited property id %d", PropertyData[id][hID]);
			return true;
		}
	}
	else if((id = Business_Inside(playerid)) != -1)
	{
 		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[id][bExitX], BusinessData[id][bExitY], BusinessData[id][bExitZ]))
		{
			if((gettime() - BizzEntrance[playerid][id]) > 180)
		    {
		        BizzEntrance[playerid][id] = gettime();

		        SendClientMessage(playerid, COLOR_GREEN, "You may enter this business for free the next 3 minutes.");
			}

			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerDynamicPos(playerid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ]);

			DesyncPlayerInterior(playerid);

			if(PlayerData[playerid][pFreeze])
			{
				KillTimer(PlayerData[playerid][pFreezeTimer]);

				PlayerData[playerid][pFreeze] = 0;
				TogglePlayerControllable(playerid, 1);
			}

			if(BusinessData[id][bradioOn]) StopAudioStreamForPlayer(playerid);

			SQL_LogAction(playerid, "Exited business %d", BusinessData[id][bID]);
			return true;
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1273.3226, 884.7640, 1161.0986)) // Guard Access Block > Outside
	{
		SetPlayerPosEx(playerid, 188.1628, 1933.2343, 17.6747);
		SetPlayerInteriorEx(playerid, 0);
		SetPlayerVirtualWorldEx(playerid, 0);
		DesyncPlayerInterior(playerid);
		return true;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, -467.3096, 1843.7053, 940.8353)) // Prison Hallway > Yard
	{
		SetPlayerPosEx(playerid, 221.6526, 1919.2972, 18.1025);
		SetPlayerInteriorEx(playerid, 0);
		SetPlayerVirtualWorldEx(playerid, 0);
		DesyncPlayerInterior(playerid);
		SetPlayerTime(playerid, ghour, 0);
		return true;
	}
		
	// Dynamic Points
	foreach	(new i: Entrance)
	{
	    if(InApartment[playerid] != EntranceData[i][insideApartmentID]) continue;

	    if(IsPlayerInRangeOfPoint(playerid, EntranceData[i][pointRange], EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]))
	    {
		    if(EntranceData[i][pointType] == POINT_TYPE_ELEVATOR)
		        return SendErrorMessage(playerid, "Este é um /elevador, então /entrar /sair não funciona.");

			if(EntranceData[i][pointLocked])
				return SendNoticeMessage(playerid, "%s esta trancado.", EntranceData[i][pointName]);				

	        switch(EntranceData[i][pointType])
	        {
	            case POINT_TYPE_ONFOOT:
	            {
	                if(IsPlayerInAnyVehicle(playerid)) return true;

	                SetPlayerPosEx(playerid, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]);
	                SetPlayerFacingAngle(playerid, EntranceData[i][outsidePos][3]);
	            }
				case POINT_TYPE_VEHICLE:
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;

					new vehicleid = GetPlayerVehicleID(playerid);

					SetVehicleDynamicPos(vehicleid, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2], playerid);
					SetVehicleZAngle(vehicleid, EntranceData[i][outsidePos][3]);

			        if(EntranceData[i][insideApartmentID] != -1)
			        {
			            LinkVehicleToInterior(vehicleid, ComplexData[ EntranceData[i][outsideApartmentID] ][aInterior]);
			            SetVehicleVirtualWorld(vehicleid, ComplexData[ EntranceData[i][outsideApartmentID] ][aWorld]);
			        }
				}
				case POINT_TYPE_BOTH:
				{
				    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				    {
						new vehicleid = GetPlayerVehicleID(playerid);

						SetVehicleDynamicPos(vehicleid, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2], playerid);
						SetVehicleZAngle(vehicleid, EntranceData[i][outsidePos][3]);

				        if(EntranceData[i][insideApartmentID] != -1)
				        {
				            LinkVehicleToInterior(vehicleid, ComplexData[ EntranceData[i][outsideApartmentID] ][aInterior]);
				            SetVehicleVirtualWorld(vehicleid, ComplexData[ EntranceData[i][outsideApartmentID] ][aWorld]);
				        }
				    }
				    else
				    {
				        if(IsPlayerInAnyVehicle(playerid)) return true;

				        SetPlayerPosEx(playerid, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]);
				        SetPlayerFacingAngle(playerid, EntranceData[i][outsidePos][3]);
				    }
				}
	        }

			if(PlayerData[playerid][pLocal] == 999) return true;

	        if(EntranceData[i][outsideApartmentID] != -1)
	        {
				SetPlayerInteriorEx(playerid, ComplexData[ EntranceData[i][outsideApartmentID] ][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[ EntranceData[i][outsideApartmentID] ][aWorld]);

				PlayerData[playerid][pLocal] = EntranceData[i][outsideApartmentID] + LOCAL_APARTMENT;
	        }
	        else
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				DesyncPlayerInterior(playerid);
			}

            InApartment[playerid] = EntranceData[i][outsideApartmentID];
	        return true;
	    }
	}
	return true;
}

YCMD:rcp(playerid, params[], help) = removecheckpoint;
YCMD:removecp(playerid, params[], help) = removecheckpoint;

CMD:removecheckpoint(playerid, params[])
{
	switch(gPlayerCheckpointStatus[playerid])
	{
		case CHECKPOINT_VEH:
		{
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		}
		case CHECKPOINT_GOFISHING:
		{
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		}
	}

    DisablePlayerCheckpoint(playerid);
    DisablePlayerRaceCheckpoint(playerid);
	return true;
}

CMD:updatemission(playerid, params[])
{
	new bool:debugger;

	if(gPlayerCheckpointStatus[playerid] != CHECKPOINT_NONE)
	{
	    switch(gPlayerCheckpointStatus[playerid])
	    {
	        case CHECKPOINT_FARMER:
			{
	            SetPlayerCheckpoint(playerid, gPlayerCheckpointX[playerid], gPlayerCheckpointY[playerid], gPlayerCheckpointZ[playerid], 5.0);

                debugger = true;
			}
	        case CHECKPOINT_GOFISHING:
			{
	            SetPlayerCheckpoint(playerid, gPlayerCheckpointX[playerid], gPlayerCheckpointY[playerid], gPlayerCheckpointZ[playerid], 30.0);

                debugger = true;
			}
	    }
	}

	if(PlayerData[playerid][pCP_Type] != -1)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "Checkpoint was rebuilt! (If you don't see anything, try /removecp and then /updatemission)");

	    SetPlayerRaceCheckpoint(playerid, 2, PlayerData[playerid][pCP_X], PlayerData[playerid][pCP_Y], PlayerData[playerid][pCP_Z], 0.0, 0.0, 0.0, 3.5);

        debugger = true;
	}

	if(!debugger) SendClientMessage(playerid, COLOR_WHITE, "No mission found.");

	return true;
}

CMD:comprarcasa(playerid, params[])
{
	new h = -1;

	if((h = nearProperty_var[playerid]) != -1 && !PropertyData[h][hOwned])
	{
		if(CountPlayerOwnHouse(playerid) >= MAX_BUYHOUSES)
			return SendClientMessage(playerid, COLOR_GRAD1, "Você tem o número máximo de casas permitidas, /sellhouse para vender sua propriedade.");

		if(PlayerData[playerid][pLevel] < PropertyData[h][hLevelbuy])
			return SendClientMessageEx(playerid, COLOR_GRAD5, "Você deve ser level %d ou mais para comprar isto.", PropertyData[h][hLevelbuy]);

		if(PlayerData[playerid][pCash] < PropertyData[h][hPrice])
			return SendClientMessage(playerid, COLOR_GRAD1, "Você não pode comprar esta propriedade.");

		SetPVarInt(playerid, "PropertyID", h);

		format(sgstr, sizeof(sgstr), "Esta casa custa %s. Tem certeza de que deseja comprar?", FormatNumber(PropertyData[h][hPrice]));
		ConfirmDialog(playerid, "Confirmação", sgstr, "OnPlayerPurchaseProperty");
		return true;
 	}

	if((h = nearApartment_var[playerid]) != -1 && !ComplexData[h][aOwned])
	{
		if(PlayerData[playerid][pLevel] < ComplexData[h][aLevelbuy])
		    return SendClientMessageEx(playerid, COLOR_GRAD5, "Você deve ser level %d ou mais para comprar isto.", ComplexData[h][aLevelbuy]);

		if(PlayerData[playerid][pCash] < ComplexData[h][aPrice])
			return SendClientMessage(playerid, COLOR_GRAD1, "Você não pode comprar esta propriedade.");

		if(ComplexData[h][aFaction] != PlayerData[playerid][pFaction])
		    return SendClientMessage(playerid, COLOR_GRAD1, "Você não pode comprar este complexo de apartamentos.");

        TakePlayerMoney(playerid, ComplexData[h][aPrice]);

		ComplexData[h][aOwned] = 1;
		ComplexData[h][aLocked] = 0;
		ComplexData[h][aOwnerSQLID] = PlayerData[playerid][pID];

		format(ComplexData[h][aOwner], MAX_PLAYER_NAME, ReturnName(playerid));

		SendClientMessage(playerid, COLOR_GREEN, "Parabéns pela sua nova aquisição.");

		Complex_Refresh(h);
		Complex_Save(h);
		return true;
 	}
	return true;
}

CMD:ofereceraluguel(playerid, params[])
{
	new house = InProperty[playerid];

 	if(!Property_IsOwner(playerid, house))
 	    return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

 	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/ofereceraluguel [playeridid/nome]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(userid == playerid)
		return SendErrorMessage(playerid, "Não pode ser você.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(InProperty[userid] != house)
		return SendErrorMessage(playerid, "Ele deve estar dentro de sua propriedade.");

	SendNoticeMessage(playerid, "Sua oferta foi enviada para %s.", ReturnName(userid, 0));

	pToAccept[userid] = playerid;
	tToAccept[userid] = OFFER_TYPE_RENT;

	format(sgstr, sizeof(sgstr), "%s ofereceu-lhe para alugar em sua propriedade~n~~p~pressione ~g~Y~p~ para aceitar ou ~r~N ~p~para recusar.", ReturnName(pToAccept[userid], 0));
	ShowPlayerFooter(userid, sgstr, -1);
	return true;
}

CMD:aluguel(playerid, params[])
{
	new house = -1;

	if((house = InProperty[playerid]) != -1)
	{
		if(!Property_IsOwner(playerid, house))
			return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

		if(!PropertyData[house][hRentable])
		{
			PropertyData[house][hRentable] = 1;

			SendClientMessage(playerid, COLOR_GREEN, "Agora sua casa pode ser alugada por outras pessoas. Alternativamente, você pode usar /offerrent para uma única pessoa.");
			SendClientMessageEx(playerid, COLOR_GREEN, "Seu aluguel atual está definido em [$%d]. Para alterá-lo, use /precoaluguel.", PropertyData[house][hRentprice]);
		}
		else
		{
			PropertyData[house][hRentable] = 0;

			SendClientMessage(playerid, COLOR_GREEN, "Sua casa não está mais disponível para alugar!");
		}

		Property_Save(house);
		return true;
	}
	else if((house = InApartment[playerid]) != -1)
	{
		if(!Complex_IsOwner(playerid, house))
			return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

		if(!ComplexData[house][aRentable])
		{
			ComplexData[house][aRentable] = 1;

			SendClientMessage(playerid, COLOR_GREEN, "Seu imóvel agora pode ser alugado por outras pessoas. lternativamente, você pode usar /offerrent para uma única pessoa.");
			SendClientMessageEx(playerid, COLOR_GREEN, "Seu aluguel atual está definido em [$%d]. Para alterá-lo, use /precoaluguel.", ComplexData[house][aRentprice]);
		}
		else
		{
			ComplexData[house][aRentable] = 0;

			SendClientMessage(playerid, COLOR_GREEN, "Seu imóvel não está mais disponível para alugar!");
		}

		Complex_Save(house);
		return true;
	}

	return true;
}

CMD:precoaluguel(playerid, params[])
{
	new house = -1;

	if((house = InProperty[playerid]) != -1)
	{	
		if(!Property_IsOwner(playerid, house))
			return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

		new
			amount
		;

		if(sscanf(params, "d", amount) || amount < 1 || amount > 25000)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "O preço do aluguel só pode ser entre $1 - $25,000!");

		PropertyData[house][hRentprice] = amount;

		SendClientMessageEx(playerid, COLOR_WHITE, "Seu aluguel agora está definido para %d", PropertyData[house][hRentprice]);

		Property_Save(house);
		return true;
	}
	else if((house = InApartment[playerid]) != -1)
	{	
		if(!Complex_IsOwner(playerid, house))
			return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

		new
			amount
		;

		if(sscanf(params, "d", amount) || amount < 1 || amount > 25000)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "O preço do aluguel só pode ser entre $1 - $25,000!");

		ComplexData[house][aRentprice] = amount;

		SendClientMessageEx(playerid, COLOR_WHITE, "Seu aluguel agora está definido para %d", ComplexData[house][aRentprice]);

		Complex_Save(house);
		return true;
	}	
	return true;
}

CMD:alugarquarto(playerid, params[])
{
	new house = -1;

	if((house = nearProperty_var[playerid]) != -1)
	{
		if(!PropertyData[house][hOwned] || PropertyData[house][hOwned])
		{
			if(PropertyData[house][hRentable] == 0)
				return SendClientMessage(playerid, COLOR_GRAD1, "Esta casa não está disponível para alugar.");

			if(PlayerData[playerid][pCash] < PropertyData[house][hRentprice])
				return SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente.");

            TakePlayerMoney(playerid, PropertyData[house][hRentprice]);

			PlayerData[playerid][pHouseKey] = house;
			PlayerData[playerid][pSpawnPoint] = 2;

			PropertyData[house][hCash] += PropertyData[house][hRentprice];

			new
			    playerStreet[MAX_ZONE_NAME]
			;

			GetStreet(PropertyData[house][hEntranceX], PropertyData[house][hEntranceY], playerStreet, MAX_ZONE_NAME);

			SendNoticeMessage(playerid, "Agora você está alugando em %s por $%d.", playerStreet, PropertyData[house][hRentprice]);
			SendNoticeMessage(playerid, "Você vai spawnar aqui até parar de alugar.");

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d', `SpawnPoint` = '2', `playerComplexKey` = '-1', `playerHouseKey` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], house, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);

			Property_Save(house);

			SQL_LogAction(playerid, "Rented house #%d", PropertyData[house][hID]);
			return true;
		}
	}
	else if((house = nearApartment_var[playerid]) != -1)
	{
		if(!ComplexData[house][aOwned] || ComplexData[house][aOwned])
		{
			if(ComplexData[house][aRentable] == 0)
				return SendClientMessage(playerid, COLOR_GRAD1, "Esta casa não está disponível para alugar.");

			if(PlayerData[playerid][pCash] < ComplexData[house][aRentprice])
				return SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente.");

            TakePlayerMoney(playerid, ComplexData[house][aRentprice]);

			PlayerData[playerid][pComplexKey] = house;
			PlayerData[playerid][pSpawnPoint] = 3;

			new
			    playerStreet[MAX_ZONE_NAME]
			;

			GetStreet(ComplexData[house][aEntranceX], ComplexData[house][aEntranceY], playerStreet, MAX_ZONE_NAME);

			SendNoticeMessage(playerid, "Agora você está alugando em %s por $%d.", playerStreet, ComplexData[house][aRentprice]);
			SendNoticeMessage(playerid, "Você vai spawnar aqui até parar de alugar.");

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d', `SpawnPoint` = '3', `playerHouseKey` = '-1', `playerComplexKey` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], house, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);

			Complex_Save(house);

			SQL_LogAction(playerid, "Rented complex #%d", ComplexData[house][aID]);
			return true;
		}
	}	
	else SendErrorMessage(playerid, "You are not near a property.");

	return true;
}
//stoprent
YCMD:pararaluguel(playerid, params[], help) = desalugar;
//unrent
CMD:desalugar(playerid, params[])
{
	new housekey = PlayerData[playerid][pHouseKey];

	if(housekey == -1)
	    return SendErrorMessage(playerid, "Você não está alugando em lugar nenhum.");

	if(PropertyData[housekey][hOwnerSQLID] == PlayerData[playerid][pID])
		return SendErrorMessage(playerid, "É sua própria casa.");

    PlayerData[playerid][pSpawnPoint] = 0;
	PlayerData[playerid][pHouseKey] = -1;

	SendNoticeMessage(playerid, "Você não está mais alugando em %s, San Andreas.", ReturnPropertyAddress(housekey));

	format(gquery, sizeof(gquery), "UPDATE `characters` SET `SpawnPoint` = '0', `playerHouseKey` = '-1' WHERE `ID` = '%d'", PlayerData[playerid][pID]);
	mysql_pquery(dbCon, gquery);
	return true;
}

CMD:casaupgrade(playerid, params[])
{
	new house = InProperty[playerid];

	if(!Property_IsOwner(playerid, house))
	    return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

	new option[24], itemnumb;

	if(sscanf(params, "s[24]D(-1)", option, itemnumb))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /casaupgrade [comprar ou remover]");
		SendClientMessage(playerid, COLOR_GRAD1, "|Comprar: To purchase new items </casaupgrade buy to see more details.>");
		SendClientMessage(playerid, COLOR_GRAD1, "|Remover: To Remove current items </casaupgrade remove to see more details.>");
		return true;
	}

	if(!strcmp(option, "buy", true))
	{
 		if(itemnumb < 1 || itemnumb > 2)
		{
			SendClientMessage(playerid, COLOR_WHITE, "USE: /casaupgrade comprar [itemid]");
			SendClientMessage(playerid, COLOR_GRAD1, "|_______ Items to Buy _______|");
			SendClientMessage(playerid, COLOR_GRAD1, "| ItemID  | Preço | Nome:");
			SendClientMessage(playerid, COLOR_GRAD3, "| 1       | $6125 | Geladeira");
			SendClientMessage(playerid, COLOR_GRAD3, "| 2       | $8000 | XM Rádio");
			return true;
		}

		new price = 0;
		if(itemnumb == 1) price = 6125;
		else if(itemnumb == 2) price = 8000;

	    if(PlayerData[playerid][pCash] < price)
			return SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente.");

		new bool:count;

		for(new z = 0; z != MAX_HOUSE_ITEMS; ++z)
		{
			if(!PropertyData[house][hItems][z])
			{
	  			switch(itemnumb)
				{
					case 1: SendClientMessage(playerid, COLOR_GRAD1, "Você adicionou uma geladeira em sua casa. (/casa itens)");
				    case 2: SendClientMessage(playerid, COLOR_GRAD1, "Você adicionou um XM Rádio em sua casa. (/casa itens)");
			 	}

                PlayerData[playerid][pCash] -= price;
				PropertyData[house][hItems][z] = itemnumb;

				mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `items` = '%e' WHERE `id` = '%d'", FormatPropertyItems(house), PropertyData[house][hID]);
				mysql_tquery(dbCon, gquery);

				count = true;
				break;
			}
		}

		if(!count) return SendClientMessage(playerid, COLOR_LIGHTRED, "Não é possível comprar mais itens agora.");
	}
	else if(!strcmp(option, "remover", true))
	{
		if(itemnumb < 0 || itemnumb > 3)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "USE: /casaupgrade remover [item]");
			ShowHouseItemDetail(playerid, house);
			return true;
		}

		if(PropertyData[house][hItems][itemnumb])
		{
			switch(PropertyData[house][hItems][itemnumb])
			{
				case 1:
				{
					SendClientMessage(playerid, COLOR_GRAD1, "Você removeu o item 'Geladeira' da sua casa.");
				}
				case 2:
			 	{
					SendClientMessage(playerid, COLOR_GRAD1, "Você removeu o item 'XM Rádio' da sua casa.");

					StopHouseBoomBox(house);
				}
			}

			PropertyData[house][hItems][itemnumb] = 0;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `items` = '%e' WHERE `id` = '%d'", FormatPropertyItems(house), PropertyData[house][hID]);
			mysql_tquery(dbCon, gquery);
		}
		else return SendClientMessage(playerid, COLOR_LIGHTRED, "Não há itens nesta caixa.");
	}
	else SendServerMessage(playerid, "Invalid Parameter.");

	return true;
}

CMD:cmdspot(playerid, params[])
{
	new house = InProperty[playerid];

	if(!Property_IsOwner(playerid, house))
	    return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

	GetPlayerPos(playerid, PropertyData[house][hCheckPosX], PropertyData[house][hCheckPosY], PropertyData[house][hCheckPosZ]);

	SendClientMessage(playerid, COLOR_CYAN, "Você definiu um novo local para executar determinados comandos.");
	SendClientMessage(playerid, COLOR_CYAN, "/pegar, /colocar, /checar, em um novo local seguro");

	Property_Save(house);
	return true;
}

stock ShowHouseItemDetail(targetid, house)
{
	SendClientMessage(targetid, COLOR_GRAD1, "|_______ Itens na Casa _______|");

	new bool:count;

 	for(new z = 0; z != MAX_HOUSE_ITEMS; ++z)
	{
		switch(PropertyData[house][hItems][z])
		{
		 	case 1:
			{
		 		SendClientMessageEx(targetid, COLOR_GRAD2, "Slot %d - Geladeira", z);
		 		SendClientMessage(targetid, COLOR_YELLOW, "(Hint):{FFFFFF} /curar: to increase the blood itself.");

		 		count = true;
		 	}
		 	case 2:
			{
		 		SendClientMessageEx(targetid, COLOR_GRAD2, "Slot %d - XM Rádio", z);
		 		SendClientMessage(targetid, COLOR_YELLOW, "(Hint):{FFFFFF} /setstation");

		 		count = true;
			}
		}
	}

	if(!count) SendClientMessage(targetid, COLOR_GRAD1, "Itens não encontrados.");
}

CMD:chavescasa(playerid, params[])
{
    new house =  Property_Nearest(playerid);

    if(house == -1)
        return SendUnauthMessage(playerid, "Você deve estar em sua propriedade para usar este comando.");

	if(!Property_IsOwner(playerid, house))
	    return SendUnauthMessage(playerid, "Você não é o dono desta propriedade.");

	SendClientMessage(playerid, COLOR_YELLOW, "-> Ninguém tem acesso a esta propriedade.");
	return true;
}
//givepropkey
CMD:darchave(playerid, params[])
{
    new house =  Property_Nearest(playerid);

    if(house == -1)
        return SendUnauthMessage(playerid, "Você deve estar em sua propriedade para usar este comando.");

	if(!Property_IsOwner(playerid, house))
	    return SendUnauthMessage(playerid, "Você não é o dono desta propriedade.");

    SendClientMessageEx(playerid, COLOR_YELLOW, "-> Você entregou para %s a chave da sua casa.", ReturnName(playerid, 0));
	return true;
}
//takepropkey
CMD:pegarchave(playerid, params[])
{
    new house =  Property_Nearest(playerid);

    if(house == -1)
        return SendUnauthMessage(playerid, "Você deve estar em sua propriedade para usar este comando.");

	if(!Property_IsOwner(playerid, house))
	    return SendUnauthMessage(playerid, "Você não é o dono desta propriedade.");

	return true;
}
YCMD:minhacasa(playerid, params[], help) = casa;

CMD:casa(playerid, params[])
{
    new house =  Property_Nearest(playerid);

	if(!Property_IsOwner(playerid, house))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve estar na varanda da sua casa.");

	new oneString[32], secString[32], thirdString[32];

	if(sscanf(params, "s[32]S()[32]S()[32]", oneString, secString, thirdString))
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "O endereço da sua casa é %s, San Andreas", ReturnPropertyAddress(house));
		SendClientMessage(playerid, COLOR_GRAD2, "USE: /casa [opção]");
		SendClientMessage(playerid, COLOR_GRAD2, "| Info | Itens");
		SendClientMessage(playerid, COLOR_GRAD2, "| Cofre | Sacar | Depositar");
		SendClientMessage(playerid, COLOR_GRAD3, "DICA: /casaupgrade para atualizar sua casa.");
		return true;
	}

	if(!strcmp(oneString, "info", true))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Informações da casa:");
		SendClientMessageEx(playerid, COLOR_GRAD3, "O preço da sua casa é: %d", PropertyData[house][hPrice]);
		SendClientMessageEx(playerid, COLOR_GRAD4, "O nível da sua casa é: %d", PropertyData[house][hLevelbuy]);
	}
	else if(!strcmp(oneString, "cofre", true))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Seu cofre tem %s", FormatNumber(PropertyData[house][hCash]));

		if(!strcmp(secString, "sacar", true))
		{
		    new amount;

		    if(sscanf(thirdString, "d", amount))
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Por favor insira quanto dinheiro.");

			if(amount < 1)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Por favor insira um valor.");

			if(amount > PropertyData[house][hCash])
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem tanto dinheiro!");

            PropertyData[house][hCash] -= amount;
            SendPlayerMoney(playerid, amount);

			SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "Você retirou %s do cofre da sua casa.", FormatNumber(amount));

			Property_Save(house);
		}
		else if(!strcmp(secString, "depositar", true))
		{
		    new amount;

		    if(sscanf(thirdString, "d", amount))
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Por favor insira quanto dinheiro.");

			if(amount < 1)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Por favor insira um valor.");

			if(amount > PlayerData[playerid][pCash])
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem tanto dinheiro!");

			TakePlayerMoney(playerid, amount);
			PropertyData[house][hCash] += amount;

			SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "Você depositou %s no cofre da sua casa.", FormatNumber(amount));

			Property_Save(house);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREEN, "/casa cofre sacar <valor> - Para sacar dinheiro.");
			SendClientMessage(playerid, COLOR_GREEN, "/casa cofre depositar <valor> - Para depositar dinheiro.");
		}
	}
	else if(!strcmp(oneString, "itens", true))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "|_______ Itens da Casa _______|");

	 	for(new z = 0; z != MAX_HOUSE_ITEMS; ++z)
		{
		    if(!PropertyData[house][hItems][z])
		    {
		        SendClientMessageEx(playerid, COLOR_GRAD3, "Slot %d -  Vazio", z);
		    }
		    else
		    {
				switch(PropertyData[house][hItems][z])
				{
				 	case 1:
					{
				 		SendClientMessageEx(playerid, COLOR_GRAD3, "Slot %d -  Geladeira", z);
				 		SendClientMessage(playerid, COLOR_YELLOW, "   -(Dica):{FFFFFF} /curar: cura automática..");
				 	}
				 	case 2:
					{
				 		SendClientMessageEx(playerid, COLOR_GRAD3, "Slot %d -  XM Radio", z);
				 		SendClientMessage(playerid, COLOR_YELLOW, "   -(Dica):{FFFFFF} /setstation");
					}
				}
			}
		}

		/*Slot 0 -  Safe
		(Hint):{FFFFFF} /code: Slows down and or stops robbers from getting to your cash..
		Slot 1 -  Mole Protection
		(Hint):{FFFFFF} Protects your house from detective moles.
		Slot 2 -  Dresser
		(Hint):{FFFFFF} /changeclothes: Buy a skin from a store and change it with this..
		ShowHouseItemDetail(playerid, house);*/
	}
	else SendServerMessage(playerid, "Invalid Parameter.");

	return true;
}

CMD:inquilinos(playerid, params[])
{
	new house = InProperty[playerid];

	if(!Property_IsOwner(playerid, house))
	    return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

	format(gquery, sizeof(gquery), "SELECT `char_name` FROM `characters` WHERE `playerHouseKey` = %d and `ID` != %d", house, PlayerData[playerid][pID]);
	mysql_tquery(dbCon, gquery, "ShowTenantsAmount", "ii", playerid, house);
	return true;
}

CMD:despejar(playerid, params[])
{
	new house = InProperty[playerid];

 	if(!Property_IsOwner(playerid, house))
 	    return SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

 	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_GREEN, "/despejar [playerid/nome]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(userid == playerid)
		return SendErrorMessage(playerid, "Você não pode se despejar.");

	if(PlayerData[userid][pHouseKey] != house)
		return SendErrorMessage(playerid, "Ele não aluga sua propriedade.");

	PlayerData[userid][pHouseKey] = -1;

	SendClientMessage(userid, COLOR_GREEN, "You have been evicted.");
	SendClientMessage(playerid, COLOR_GREEN, "O inquilino foi despejado.");
	return true;
}

CMD:despejartodos(playerid, params[])
{
	new house = InProperty[playerid];

	if(Property_IsOwner(playerid, house))
	{
		format(gquery, sizeof(gquery), "UPDATE `characters` SET `playerHouseKey` = '-1' WHERE `playerHouseKey` = '%d' AND `ID`!= '%d'", house, PlayerData[playerid][pID]);
		mysql_tquery(dbCon, gquery, "OnPlayerEvictTenant", "ii", playerid, house);

		SendClientMessage(playerid, COLOR_YELLOW, "Todos os inquilinos foram despejados de sua casa.");
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "Você deve estar em uma casa sua.");

	return true;
}

stock ShowPlayerCurrentFurniture(playerid, page = 0)
{
	new houseid = InProperty[playerid], count, string[2048];

	if(houseid != -1)
	{
		for(new i = page * MAX_FURNITURE_PERPAGE; i != MAX_FURNITURE; ++i)
		{
			if(HouseFurniture[houseid][i][fOn])
			{
				if(count >= MAX_FURNITURE_PERPAGE)
				{
					format(string, sizeof(string), "%s>>\n", string);
					break;
				}

				format(string, sizeof(string), "%sSlot %d: %s\n", string, i, HouseFurniture[houseid][i][fName]);

				count++;
			}
		}

		if(page > 0) format(string, sizeof(string), "%s<<\n", string);
		format(string, sizeof(string), "%s{FFFF00}*Select The Furniture*", string);

		format(sgstr, sizeof(sgstr), "{FFFFFF}Current Furniture({33AA33}%d{FFFFFF})", GetHouseFurnitures(houseid));
		Dialog_Show(playerid, DisplayFurniture, DIALOG_STYLE_LIST, sgstr, string, "Select", "<<");
		return true;
	}

	houseid = InBusiness[playerid];

	if(houseid != -1)
	{
		for(new i = page * MAX_FURNITURE_PERPAGE; i != MAX_FURNITURE; ++i)
		{
			if(BizFurniture[houseid][i][fOn])
			{
				if(count >= MAX_FURNITURE_PERPAGE)
				{
					format(string, sizeof(string), "%s>>\n", string);
					break;
				}

				format(string, sizeof(string), "%sSlot %d: %s\n", string, i, BizFurniture[houseid][i][fName]);

				count++;
			}
		}

		if(page > 0) format(string, sizeof(string), "%s<<\n", string);
		format(string, sizeof(string), "%s{FFFF00}*Select The Furniture*", string);

		format(sgstr, sizeof(sgstr), "{FFFFFF}Current Furniture({33AA33}%d{FFFFFF})", GetBizFurnitures(houseid));
		Dialog_Show(playerid, DisplayFurniture, DIALOG_STYLE_LIST, sgstr, string, "Select", "<<");
		return true;
	}
	return true;
}

CMD:mobiliaperm(playerid, params[])
{
    new house = InProperty[playerid];

	if(house != -1)
	{
		if(!Property_IsOwner(playerid, house))
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o dono.");

		new userid;

		if(sscanf(params, "u", userid))
		    return SendSyntaxMessage(playerid, "/mobiliaperm [id/nome]");

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "s[24]", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
			}
		}

		if(!SQL_IsLogged(userid))
			return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

		if(InProperty[userid] != house)
		    return SendErrorMessage(playerid, "O jogador deve estar dentro da sua casa.");

		if(GrantBuild[userid] == house)
		{
		    GrantBuild[userid] = -1;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Você revogou o acesso para mobiliar sua casa para %s .", ReturnName(userid, 0));
			SendClientMessageEx(userid, COLOR_YELLOW, "-> %s revogou seu acesso para mobiliar sua casa.", ReturnName(playerid, 0));
		}
		else
		{
		    GrantBuild[userid] = house;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Você concedeu acesso para %s mobiliar sua casa.", ReturnName(userid, 0));
			SendClientMessageEx(userid, COLOR_YELLOW, "-> %s concedeu-lhe acesso para mobiliar a casa dele.", ReturnName(playerid, 0));
		}
		return true;
	}

	house = InBusiness[playerid];

	if(house != -1)
	{
	    if(!strcmp(ReturnName(playerid), BusinessData[house][bOwner], false))
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o dono.");

		new userid;

		if(sscanf(params, "u", userid))
		    return SendSyntaxMessage(playerid, "/mobiliaperm [id/nome]");

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "s[24]", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
			}
		}

		if(!SQL_IsLogged(userid))
			return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

		if(InBusiness[userid] != house)
		    return SendErrorMessage(playerid, "O jogador deve estar dentro da sua empresa.");

		if(GrantBuild[userid] == house)
		{
		    GrantBuild[userid] = -1;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Você revogou o acesso para mobiliar sua empresa para %s.", ReturnName(userid, 0));
			SendClientMessageEx(userid, COLOR_YELLOW, "-> %s revogou seu acesso para mobiliar sua empresa.", ReturnName(playerid, 0));
		}
		else
		{
		    GrantBuild[userid] = house;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Você concedeu acesso para %s mobiliar sua empresa.", ReturnName(userid, 0));
			SendClientMessageEx(userid, COLOR_YELLOW, "-> %s concedeu-lhe acesso para mobiliar a casa dele.", ReturnName(playerid, 0));
		}
	    return true;
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve estar dentro de sua casa/empresa");
	return true;
}

CMD:mobilia(playerid, params[])
{
	new house = InProperty[playerid];

	if(house != -1)
	{
		if(!Property_IsOwner(playerid, house) && GrantBuild[playerid] != house)
		    return SendClientMessage(playerid, COLOR_GRAD1, "You can't furnish here.");

		Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
		return true;
	}

	house = InBusiness[playerid];

	if(house != -1)
	{
	    if(!Business_IsOwner(playerid, house) && GrantBuild[playerid] != house)
                return SendClientMessage(playerid, COLOR_GRAD1, "You can't furnish here.");

		Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
        return true;
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a home/business");
	return true;
}

CMD:abrirpedagio(playerid, params[])
{
 	new L_i_TollID;

	if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 623.9500, -1183.9774, 19.2260) || IsPlayerInRangeOfPoint(playerid, 10.0, 607.9684, -1194.2866, 19.0043)) // Richman tolls
	{
		L_i_TollID = RichmanToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 39.7039, -1522.9891, 5.1995) || IsPlayerInRangeOfPoint(playerid, 10.0, 62.7378, -1539.9891, 5.0639)) // Flint tolls
	{
		L_i_TollID = FlintToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 1795.9447, 704.2550, 15.0006) || IsPlayerInRangeOfPoint(playerid, 10.0, 1778.9886, 702.6728, 15.2574)) // LV tolls
	{
		L_i_TollID = LVToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 612.53070, 346.59592, 17.92614) || IsPlayerInRangeOfPoint(playerid, 10.0, 604.37152, 346.88141, 17.92614)) // BlueberryR tolls
	{
		L_i_TollID = BlueberryTollR;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, -195.2768,252.2416,12.0781) || IsPlayerInRangeOfPoint(playerid, 10.0, -199.5153,260.3405,12.0781)) // BlueberryL tolls
	{
		L_i_TollID = BlueberryTollL;
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está perto o suficiente de uma cabine de pedágio.");
		return true;
	}

	if(aTolls[L_i_TollID][E_tOpenTime] > 0)
		return SendNoticeMessage(playerid, "O pedágio já foi aberto, passe antes que ele feche.");

    if(!PlayerData[playerid][pOnDuty])
	{
		if(aTolls[L_i_TollID][E_tLocked])
			return SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "O guarda de pedágio diz: Desculpe, mas estamos temporariamente fechados. Volte mais tarde..");

		if(PlayerData[playerid][pCash] < TollCost)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro suficiente.");

		TakePlayerMoney(playerid, TollCost);

		TollsPayed += TollCost;

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "%s paga $%d tpara o guarda de pedágio.", ReturnName(playerid, 0), TollCost);
	}

	SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "O guarda de pedágio diz: Obrigado, dirija com segurança.");
	SendClientMessage(playerid, COLOR_LIGHTRED, "Você tem 6 segundos para passar pelo pedágio, tome cuidado para não ficar preso!");

	Toll_OpenToll(L_i_TollID);
	return true;
}

CMD:fireduty(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_MEDIC)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For doctors only.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "You are not on EMT Duty. /trabalho");

	new id = PlayerData[playerid][pFaction];

	if(!IsNearFactionSpawn(playerid, id))
	    return SendErrorMessage(playerid, "You can't get on fireman duty here.");

	if(PlayerData[playerid][pFireman])
	{
        PlayerData[playerid][pFireman] = false;

        SendClientMessage(playerid, COLOR_LIGHTRED, "You are now off fireman duty!");
	}
	else
	{
        PlayerData[playerid][pFireman] = true;

        SendClientMessage(playerid, COLOR_LIGHTRED, "You are now on fireman duty!");
	}
	return true;
}

CMD:operation(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_MEDIC)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For doctors only.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "You are not on EMT Duty. /trabalho");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/operation [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GRAD1, "The player is disconnected.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendClientMessage(playerid, COLOR_GRAD1, "You need to be near a person to operate on them.");

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_GRAD1, "You cannot operate on yourself.");

	if(!PlayerData[userid][pInjured] || DeathMode{userid})
	    return SendClientMessage(playerid, COLOR_GRAD1, "The player is not injured or the player is dead.");

	if(PlayerData[playerid][pLocal] == 255)
	    return SendClientMessage(playerid, COLOR_GRAD1, " Not enough tools here, go to a hospital!");

    RevivePlayer(userid);
	SetPlayerHealthEx(userid, 50.0);
	TogglePlayerControllable(userid, true);
	SetPlayerChatBubble(userid, "(( Respawn ))", COLOR_WHITE, 10.0, 1000);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s finished operation %s", ReturnName(playerid, 0), ReturnName(userid, 0));
	return true;
}

CMD:putinambu(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_MEDIC)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "For doctors only.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "You are not on EMT Duty. /trabalho");

	new
	    userid,
		seatid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/putinambu [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 10.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "The player is disconnected. Or not near you");

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You can not move yourself into an ambulance.");

	if(!PlayerData[userid][pInjured] || DeathMode{userid})
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "The player is not injured or the player is dead.");

	foreach (new i : StreamedVehicle[playerid])
	{
		if(GetVehicleModel(i) == 416)
		{
			if((GetPlayerVehicleID(playerid) == i || IsPlayerNearBoot(playerid, i)))
			{
				seatid = GetAvailableSeat(i, 2);

				if(seatid == -1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "There is no space for patients.");

				death_Pause[userid] = 2;
				PutPlayerInVehicle(userid, i, seatid);
				TogglePlayerControllable(userid, true);

				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts %s in ambulance", ReturnName(playerid, 0), ReturnName(userid, 0));
				return true;
			}
		}
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "You must be near or in an ambulance.");
	return true;
}

CMD:isafk(playerid, params[])
{
	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/isafk [id/nome]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(PlayerData[userid][pAdmin] && PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "Tailing admins' afk status isn't necessary.");

	SendNoticeMessage(playerid, "%s (%d) has been AFK / Tabbed for %d seconds.", ReturnName(userid), userid, AFKCount[userid]);
	return true;
}

YCMD:pl(playerid, params[], help) = packetloss;

CMD:packetloss(playerid, params[])
{
	new
		userid
	;

	if(sscanf(params, "u", userid))
	{
		SendSyntaxMessage(playerid, "/packetloss [ID, name or mask]");
		return ShowPacketloss(playerid, playerid);
	}

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

    ShowPacketloss(userid, playerid);
	return true;
}

YCMD:cc(playerid, params[], help) = clearchat;

CMD:clearchat(playerid, params[])
{
	for(new i = 0; i < 21; ++i)
	{
		SendClientMessage(playerid, COLOR_WHITE, " ");
	}
	return true;
}

CMD:tpda(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_TRUCKER && PlayerData[playerid][pSideJob] != JOB_TRUCKER)
	    return SendClientMessage(playerid, COLOR_GRAD1, "You're not a Trucker.");

	Dialog_Show(playerid, TruckerPDA, DIALOG_STYLE_LIST, "Trucker PDA", "{B4B5B7}Show{FFFFFF} All Industries\n{B4B5B7}Show{FFFFFF} Businesses Accepting Cargo\n{B4B5B7}Show{FFFFFF} Ship Information", "Select", "Exit");
	return true;
}

CMD:industry(playerid, params[])
{
	new i;

	if((i = Industry_Nearest(playerid)) != -1)
	{
		ShowIndustry(playerid, StorageData[i][in_industryid]);
	}
	return true;
}

CMD:cargo(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_TRUCKER && PlayerData[playerid][pSideJob] != JOB_TRUCKER)
	    return SendClientMessage(playerid, COLOR_GRAD1, "You're not a Trucker.");

	new option[16], amount, id = -1;

	if(sscanf(params, "s[16]D(0)", option, amount))
	{
	    SendClientMessage(playerid, COLOR_GRAD3, "Available commands:");
	    SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo list {FFFFFF}- shows cargo loaded in the nearest unlocked vehicle");
	    SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo listpickup [ID] {FFFFFF}- if {FFFF00}/cargo list{FFFFFF} is bugged, use this; [ID] is the number in the list");
        SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo place {FFFFFF}- places the create you're holding to the nearest vehicle");
        //SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo fork {FFFFFF}- forks cargo from a nearest vehicle to your Forklift");
        SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo putdown {FFFFFF}- puts on ground the cargo you are holding");
        SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo pickup {FFFFFF}- picks cargo up from the ground");
        SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo buy {FFFFFF}- allows you to buy cargo from an industry");
        SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}/cargo sell {FFFFFF}- sells cargo to an industry / a business");
		return true;
	}

	if(!strcmp(option, "list", true))
	{
	    new vehicleid = -1;

	    if(!IsPlayerInAnyVehicle(playerid)) vehicleid = Car_Nearest(playerid);
		else vehicleid = GetPlayerVehicleID(playerid);

		if(vehicleid && (GetTrunkStatus(vehicleid) || IsVehicleTrunkBroken(vehicleid)))
		{
		    new count, str[512];

			for(new i = 0; i < MAX_TRUCKER_ITEMS; ++i)
			{
				if(CoreVehicles[vehicleid][vehicleCrate][i])
				{
					format(str, 512, "%s{000000}%02d\t{E5FF00}%s\t{FFFFFF}%d %s\n", str, i + 1, GetBusinessCargoDesc(i), CoreVehicles[vehicleid][vehicleCrate][i], ReturnCargoUnit(i));
					count++;
				}
			}

			if(!count) return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Vehicle Cargo", "{E5FF00}There is no cargo loaded in the vehicle.", "Close", "");

			Dialog_Show(playerid, VehicleCargoStorage, DIALOG_STYLE_TABLIST, "Vehicle Cargo", str, "Pick Up", "Close");
		}
		else SendClientMessage(playerid, COLOR_WHITE, "No{FFFF00} unlocked{FFFFFF} vehicle's trunk found around you.");
	}
	else if(!strcmp(option, "listpickup", true))
	{
		if(amount > 0)
		{
		    amount--;

			if(carryCrate[playerid] == -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 9))
			{
				new vehicleid = Car_Nearest(playerid);

				if(vehicleid && (GetTrunkStatus(vehicleid) || IsVehicleTrunkBroken(vehicleid)) && IsPlayerNearBoot(playerid, vehicleid))
				{
	                if(IsVehicleCargo(amount) == -1)
					{
						if(CoreVehicles[vehicleid][vehicleCrate][amount])
						{
						    CoreVehicles[vehicleid][vehicleCrate][amount]--;
						    UpdateVehicleObject(vehicleid);

						    carryCrate[playerid] = amount;

							ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0, 1);

							SetTimerEx("PickupCrate", 200, false, "ii", playerid, (!strcmp(ReturnCargoUnits(amount), "strongboxes", true) ? 1 : 0));
							return true;
						}
					}
				}
			}
		}

		SendClientMessage(playerid, COLOR_WHITE, "Invalid value.");
	}
	else if(!strcmp(option, "place", true))
	{
    	if(carryCrate[playerid] != -1 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
		{
		    new vid = -1;

		    if(!IsPlayerInAnyVehicle(playerid))
			{
				foreach (new i : StreamedVehicle[playerid])
				{
					if(IsPlayerNearBoot(playerid, i))
					{
						vid = i;
						break;
					}
				}
			}
			else vid = GetPlayerVehicleID(playerid);

			if(vid && (GetTrunkStatus(vid) || IsVehicleTrunkBroken(vid)))
			{
				if(IsVehicleTransport(vid, carryCrate[playerid]))
				{
					if(CountVehicleSlot(vid) + GetCargoSlot(carryCrate[playerid]) <= GetVehicleCargoSlot(GetVehicleModel(vid)))
					{
						CoreVehicles[vid][vehicleCrate][carryCrate[playerid]]++;

						UpdateVehicleObject(vid);

						ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);

						SetTimerEx("PlaceCrate", 200, false, "i", playerid);

						carryCrate[playerid] = -1;

						new targetid = INVALID_PLAYER_ID;

					    if((targetid = GetVehicleDriver(vid)) != INVALID_PLAYER_ID)
					    {
					        new vehicleid = GetPlayerVehicleID(targetid);

					        if(IsTrucker(vehicleid))
					        {
						        new model = GetVehicleModel(vehicleid), trailerid = GetVehicleTrailer(vehicleid);

								if(GetVehicleCargoLoad((!trailerid) ? vid : trailerid) != -1 && !IsVehicleCargoSkill(model, PlayerData[targetid][pJobRank]))
								{
									RemovePlayerFromVehicle(targetid);

									//SendClientMessage(targetid, COLOR_WHITE, "");
								}
							}
						}
					}
					else SendClientMessage(playerid, COLOR_WHITE, "Not enough space in the vehicle.");
				}
				else SendClientMessage(playerid, COLOR_WHITE, "Your vehicle can not carry this type of cargo.");
			}
			else SendClientMessage(playerid, COLOR_WHITE, "No{FFFF00} unlocked{FFFFFF} vehicle's trunk found around you.");
		}
    	else SendClientMessage(playerid, COLOR_WHITE, "You aren't holding any crate.");
	}
	/*else if(!strcmp(option, "fork", true))
	{

	}*/
	else if(!strcmp(option, "putdown", true))
	{
    	if(carryCrate[playerid] != -1 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
		{
			new cid = -1, count;

			for(new i = 0; i < MAX_CRATE; ++i)
			{
				if(CrateInfo[i][cOn] && CrateInfo[i][cOwned] == PlayerData[playerid][pID]) count++;

				if(!CrateInfo[i][cOn] && cid == -1) cid = i;
			}

			if(cid != -1 && count <= 2)
			{
		     	ApplyAnimation(playerid, "CARRY","putdwn", 4.1, 0, 0, 0, 0, 0, 1);

		      	SetTimerEx("PutdownCrate", 900, false, "iii", playerid, cid, carryCrate[playerid]);

	    	    carryCrate[playerid] = -1;
    	    }
    	    else SendClientMessage(playerid, COLOR_LIGHTRED, "You can not put a crate right now.");
    	}
    	else SendClientMessage(playerid, COLOR_WHITE, "You do not have a crate.");
	}
	else if(!strcmp(option, "pickup", true))
	{
    	if(carryCrate[playerid] == -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 9))
		{
			for(new i = 0; i < MAX_CRATE; ++i)
			{
				if(CrateInfo[i][cOn])
				{
					if(IsPlayerInRangeOfPoint(playerid,3.0,CrateInfo[i][cX],CrateInfo[i][cY],CrateInfo[i][cZ]))
					{
					   	ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);

					  	SetTimerEx("PickupCrate", 900, false, "ii", playerid, (!strcmp(ReturnCargoUnits(CrateInfo[i][cID]), "strongboxes", true) ? 1 : 0));

						carryCrate[playerid] = CrateInfo[i][cID];
						DestroyDynamicObject(CrateInfo[i][cObject]);
						DestroyDynamic3DTextLabel(CrateInfo[i][clabel]);
                        CrateInfo[i][cOn] = 0;
						return true;
				    }
				}
			}

			SendClientMessage(playerid, COLOR_WHITE, "There is nothing to pick up.");
    	}
    	else SendClientMessage(playerid, COLOR_WHITE, "You're already holding a crate.");
	}
	else if(!strcmp(option, "buy", true))
	{
		if((id = Industry_Nearest(playerid, 5.0)) != -1 && !IndustryData[StorageData[id][in_industryid]][in_close])
		{
		    new type = -1;

			if((type = IsVehicleCargo(StorageData[id][in_item])) != -1)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
						return SendClientMessage(playerid, COLOR_GRAD1, "Você não é o motorista.");

				    if(type != 2)
					{
					    if(amount <= 0)
						{
							SendClientMessage(playerid, -1, "You must specify the amount of this cargo. Use {E5FF00}/cargo buy [amount]");

							switch(type)
							{
							    case 0: // Loose
							    {
									SendClientMessage(playerid, -1, "Dump trailer capacity: {E5FF00}30 tonnes");
									SendClientMessage(playerid, -1, "Flatbed capacity: {E5FF00}16 tonnes");
							    }
							    case 1: // Liquids
							    {
									SendClientMessage(playerid, -1, "Tanker capacity: {E5FF00}40 cubic meters");
							    }
							}
					        return 1;
					    }
				    }
				    else amount = 1;

				    new vehicleid = GetPlayerVehicleID(playerid);

					if(IsVehicleTransport(vehicleid, StorageData[id][in_item]))
					{
					    if(IsVehicleCargoSkill(GetVehicleModel(vehicleid), PlayerData[playerid][pJobRank]))
						{
							if(!StorageData[id][in_trading_type] && IndustryData[StorageData[id][in_industryid]][in_type] != 3)
							{
	                            if(PlayerData[playerid][pCash] >= StorageData[id][in_price] * amount)
								{
	                                new trailerid = GetVehicleTrailer(vehicleid);

									if(CountVehicleSlot(vehicleid) + (GetCargoSlot(StorageData[id][in_item]) * amount) <= GetVehicleCargoSlot(GetVehicleModel((!trailerid) ?  vehicleid : trailerid)))
									{
									    if(type == 2)
										{
											CoreVehicles[vehicleid][vehicleCrate][StorageData[id][in_item]]++;
											UpdateVehicleObject(vehicleid);

										    StorageData[id][in_stock]--;

				                            UpdateStorage(id);

				                            TakePlayerMoney(playerid, StorageData[id][in_price]);
									    }
									    else
									    {
									        if(trailerid)
									        {
												if(GetLockStatus(trailerid))
												{
									          		SendClientMessage(playerid, COLOR_WHITE, "Trailer is locked.");
									          		return true;
												}

												vehicleid = trailerid;
									        }

									        new cargo_invehicle = -1;

									        if((cargo_invehicle = GetVehicleCargoLoad(vehicleid)) == -1 || StorageData[id][in_item] == cargo_invehicle)
									        {
										        if(!CoreVehicles[vehicleid][vehicleIsCargoLoad])
										        {
												    StorageData[id][in_stock] -= amount;

						                            UpdateStorage(id);

						                            TakePlayerMoney(playerid, StorageData[id][in_price] * amount);

													CoreVehicles[vehicleid][vehicleIsCargoLoad] = amount;
													CoreVehicles[vehicleid][vehicleCargoTime] = amount * 2;
													CoreVehicles[vehicleid][vehicleCargoStorage] = id;
													CoreVehicles[vehicleid][vehicleCargoPlayer] = playerid;
													CoreVehicles[vehicleid][vehicleCargoAction] = 0;

													Iter_Add(sv_activevehicles, vehicleid);

													GameTextForPlayer(playerid, "~r~Cargo is being (un)loaded,~n~~b~Please wait...", 1000, 3);
												}
												else SendClientMessage(playerid, COLOR_WHITE, "Truck is currently being loaded.");
											}
											else SendClientMessage(playerid, COLOR_WHITE, "You cannot ship different kinds of goods.");
										}
									}
									else SendClientMessage(playerid, COLOR_WHITE, "Can not ship more than this.");
	                            }
	                          	else SendClientMessage(playerid, COLOR_WHITE, "Você não tem dinheiro suficiente.");
	                        }
	                        else SendClientMessage(playerid, COLOR_WHITE, "You cannot buy anything in this storage.");
                        }
                        else SendClientMessage(playerid, COLOR_WHITE, "Your skills are not enough for shipping in this vehicle.");
					}
					else SendClientMessage(playerid, -1, "Your vehicle cannot carry this type of cargo.");
				}
				else SendClientMessage(playerid, -1, "You must be in a vehicle to buy this product.");
			}
			else
			{
				if(!IsPlayerInAnyVehicle(playerid))
				{
					if(carryCrate[playerid] == -1 && !IsPlayerAttachedObjectSlotUsed(playerid, 9))
					{
                        if(!StorageData[id][in_trading_type] && IndustryData[StorageData[id][in_industryid]][in_type] != 3)
						{
							if(StorageData[id][in_stock])
							{
	                            if(PlayerData[playerid][pCash] >= StorageData[id][in_price])
								{
		                            StorageData[id][in_stock]--;

		                            UpdateStorage(id);

	                                carryCrate[playerid] = StorageData[id][in_item];

		                            TakePlayerMoney(playerid, StorageData[id][in_price]);

		                            ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);

		                            SetTimerEx("PickupCrate", 900, false, "ii", playerid, (!strcmp(ReturnCargoUnits(StorageData[id][in_item]), "strongboxes", true) ? 1 : 0));
	                            }
	                          	else SendClientMessage(playerid, COLOR_WHITE, "Você não tem dinheiro suficiente.");
                          	}
                          	else SendClientMessage(playerid, COLOR_WHITE, "This storage is empty.");
                        }
                        else SendClientMessage(playerid, COLOR_WHITE, "You cannot buy anything in this storage.");
					}
					else SendClientMessage(playerid, COLOR_WHITE, "You are holding a crate.");
				}
				else SendClientMessage(playerid, COLOR_WHITE, "You must purchase this product on foot.");
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "There is no industry here.");
	}
	else if(!strcmp(option, "sell", true))
	{
		if((id = Business_Nearest(playerid)) != -1 && BusinessData[id][bExitX] != 0.0 && BusinessData[id][bExitY] != 0.0)
		{
			if(carryCrate[playerid] != -1 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
			{
			    if(BusinessData[id][bPriceProd] && BusinessData[id][bTill] >= BusinessData[id][bPriceProd])
				{
				    if(GetProductCargo(BusinessData[id][bType]) == carryCrate[playerid])
					{
						if(GetBusinessCargoCanBuy(id))
						{
							BusinessData[id][bProducts] += GetProductPerCargo(BusinessData[id][bType]);

							carryCrate[playerid] = -1;

							SendPlayerMoney(playerid, BusinessData[id][bPriceProd]);

							BusinessData[id][bTill] -= BusinessData[id][bPriceProd];

							ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);

							SetTimerEx("PlaceCrate", 900, false, "i", playerid);
						}
						else SendClientMessage(playerid, COLOR_WHITE, "This business is full.");
					}
					else SendClientMessage(playerid, COLOR_WHITE, "You cannot sell a product of this type.");
				}
				else SendClientMessage(playerid, COLOR_WHITE, "This business does not accept purchases of goods.");
			}
			else SendClientMessage(playerid, COLOR_WHITE, "You are not holding a crate.");
		}
		else if((id = Industry_Nearest(playerid, 5.0)) != -1 && !IndustryData[StorageData[id][in_industryid]][in_close])
		{
		    new type = -1;

			if((type = IsVehicleCargo(StorageData[id][in_item])) != -1)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
						return SendClientMessage(playerid, COLOR_GRAD1, " You are not the driver.");

				    if(type != 2)
					{
					    if(amount <= 0)
						{
							SendClientMessage(playerid, -1, "You must specify the amount of this cargo. Use {E5FF00}/cargo sell [amount]");

							switch(type)
							{
							    case 0: // Loose
							    {
									SendClientMessage(playerid, -1, "Dump trailer capacity: {E5FF00}30 tonnes");
									SendClientMessage(playerid, -1, "Flatbed capacity: {E5FF00} 16 tonnes");
							    }
							    case 1: // Liquids
							    {
									SendClientMessage(playerid, -1, "Tanker capacity: {E5FF00}40 cubic meters");
							    }
							}
					        return 1;
					    }
				    }
				    else amount = 1;

				    new vehicleid = GetPlayerVehicleID(playerid), trailerid = GetVehicleTrailer(vehicleid);

					if(trailerid)
					{
						if(GetLockStatus(trailerid))
						{
							SendClientMessage(playerid, COLOR_WHITE, "Trailer is locked.");
							return true;
						}

						vehicleid = trailerid;
					}

					if(StorageData[id][in_trading_type] && StorageData[id][in_item] == GetVehicleCargoLoad((!trailerid) ? vehicleid : trailerid))
					{
						if(CoreVehicles[vehicleid][vehicleCrate][StorageData[id][in_item]] >= amount)
						{
							if(StorageData[id][in_stock] + amount <= StorageData[id][in_maximum])
							{
								if(type == 2)
								{
									CoreVehicles[vehicleid][vehicleCrate][StorageData[id][in_item]]--;

									UpdateVehicleObject(vehicleid);

									StorageData[id][in_stock]++;
									UpdateStorage(id);

									SendPlayerMoney(playerid, StorageData[id][in_price]);
								}
								else
								{
									if(!CoreVehicles[vehicleid][vehicleIsCargoLoad])
									{
										StorageData[id][in_stock] += amount;

										UpdateStorage(id);

										CoreVehicles[vehicleid][vehicleIsCargoLoad] = amount;
										CoreVehicles[vehicleid][vehicleCargoTime] = amount * 2;
										CoreVehicles[vehicleid][vehicleCargoStorage] = id;
										CoreVehicles[vehicleid][vehicleCargoPlayer] = playerid;
										CoreVehicles[vehicleid][vehicleCargoAction] = 1;

										Iter_Add(sv_activevehicles, vehicleid);

										GameTextForPlayer(playerid, "~r~Cargo is being (un)loaded,~n~~b~Please wait...", 1000, 3);
									}
									else SendClientMessage(playerid, COLOR_WHITE, "Truck is currently being unloaded.");
								}
							}
							else SendClientMessage(playerid, COLOR_WHITE, "The industry is full.");

						}
						else SendClientMessage(playerid, COLOR_WHITE, "Invalid item count.");
                   	}
                   	else SendClientMessage(playerid, COLOR_WHITE, "You cannot sell product of this type.");
				}
				else SendClientMessage(playerid, -1, "You must be in a vehicle to sell this product.");
			}
			else
			{
				if(!IsPlayerInAnyVehicle(playerid))
				{
					if(carryCrate[playerid] != -1 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
					{
						if(StorageData[id][in_item] == carryCrate[playerid])
						{
							if(StorageData[id][in_stock] < StorageData[id][in_maximum])
							{
		                      	StorageData[id][in_stock]++;

		                       	UpdateStorage(id);

	                          	carryCrate[playerid] = -1;

		                      	SendPlayerMoney(playerid, StorageData[id][in_price]);

						     	ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);

						      	SetTimerEx("PlaceCrate", 900, false, "i", playerid);
                          	}
                          	else SendClientMessage(playerid, COLOR_WHITE, "The industry is full.");
                        }
                        else SendClientMessage(playerid, COLOR_WHITE, "You cannot sell product of this type.");
					}
					else SendClientMessage(playerid, COLOR_WHITE, "You are not holding a crate.");
				}
				else SendClientMessage(playerid, -1, "Você deve estar a pé.");
			}
		}
		else SendClientMessage(playerid, COLOR_WHITE, "No industry here.");
	}
	return true;
}

CMD:trailer(playerid, params[])
{
	new option[8], vehicleid, trailerid;

	if(sscanf(params, "s[8]", option))
	{
	    SendClientMessage(playerid, COLOR_GRAD3, "Available commands:");
	    SendClientMessage(playerid, -1, "{FFFF00}/trailer lock {FFFFFF}- Lock / unlock Trailer attached to your vehicle.");
	    SendClientMessage(playerid, -1, "{FFFF00}/trailer detach {FFFFFF}- Remove the trailer from your vehicle.");
        SendClientMessage(playerid, -1, "{FFFF00}/trailer lights {FFFFFF}- Open/Close Trailer light");
        SendClientMessage(playerid, -1, "{FFFF00}/trailer cargo {FFFFFF}- Show anything contained in the trailer.");
        return 1;
	}

	if((vehicleid = GetPlayerVehicleID(playerid)) && (trailerid = GetVehicleTrailer(vehicleid)))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GRAD1, "   You are not a driver");

		if(!strcmp(option, "lock", true))
		{
			new
				engine,
				lights,
				alarm,
				doors,
				bonnet,
				boot,
				objective,
				str[64];

			GetVehicleParamsEx(trailerid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(doors != 1)
			{
				format(str, sizeof(str), "~r~%s Locked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 2000, 4);
				SetVehicleParamsEx(trailerid, engine, lights, alarm, 1, bonnet, boot, objective);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				format(str, sizeof(str), "~g~%s Unlocked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 2000, 4);
				SetVehicleParamsEx(trailerid, engine, lights, alarm, 0, bonnet, boot, objective);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
		else if(!strcmp(option, "detach", true))
		{
		    DetachTrailerFromVehicle(vehicleid);
		}
		else if(!strcmp(option, "lights", true))
		{
			switch (GetLightStatus(vehicleid))
			{
			    case false:
			    {
			        SetLightStatus(vehicleid, true);
			        //GameTextForPlayer(playerid, "~g~Trailer Lights On", 2000, 4);
				}
				case true:
				{
				    SetLightStatus(vehicleid, false);
				    //GameTextForPlayer(playerid, "~r~Trailer Lights Off", 2000, 4);
				}
			}
		}
		else if(!strcmp(option, "cargo", true))
		{
			if(!GetLockStatus(trailerid))
			{
			    new count, str[512];

				for(new i = 0; i < MAX_TRUCKER_ITEMS; ++i) 
				{
					if(CoreVehicles[trailerid][vehicleCrate][i])
					{
						format(str, 512, "%s{000000}%02d\t{E5FF00}%s\t{FFFFFF}%d %s\n", str, i + 1, GetBusinessCargoDesc(i), CoreVehicles[trailerid][vehicleCrate][i], ReturnCargoUnit(i));
						count++;
					}
				}

				if(!count) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trailer Cargo", "{E5FF00}There are no items in this trailer.", "Close", "");
				else Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST, "Trailer Cargo", str, "Close", "");
			}
			else SendClientMessage(playerid, COLOR_WHITE, "Trailer Locked");
		}
	}
	else SendClientMessage(playerid, COLOR_WHITE, "You must be on a trailer vehicle.");

	return true;
}

CMD:db(playerid, params[])
{
	if(!IsPolice(playerid))
	    return SendErrorMessage(playerid, "You're not Police.");

    if(!IsNearFactionSpawn(playerid, PlayerData[playerid][pFaction]))
        return SendErrorMessage(playerid, "You can't /db here.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "Você não está em trabalho.");

	GivePlayerValidWeapon(playerid, 43, 200, 0, false);
	GivePlayerValidWeapon(playerid, 24, 150, 0, false);

	SetPlayerArmourEx(playerid, 100.0);
	SetPlayerHealthEx(playerid, 100.0 + PlayerData[playerid][pSHealth]);

	SendClientMessage(playerid, -1, "You got Deagle(150), Camera(200), Armour(100), Health(100)!");
	return true;
}

CMD:swat(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "You aren't in the LSPD.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "Você não está em trabalho.");

    if(!IsNearFactionSpawn(playerid, PlayerData[playerid][pFaction]))
        return SendErrorMessage(playerid, "You can't /swat here.");

	if(!PlayerData[playerid][pSwat])
	{
		PlayerData[playerid][pSwat] = true;

		SendPoliceMessage(COLOR_POLICE, "** HQ: SWAT Operative %s is now ready for orders! **", ReturnName(playerid, 0));

		SetPlayerArmourEx(playerid, 200.0);
	}
	else
	{
		PlayerData[playerid][pSwat] = false;

		SendPoliceMessage(COLOR_POLICE, "** HQ: SWAT Operative %s is now Off Duty! **", ReturnName(playerid, 0));

		SetPlayerArmourEx(playerid, 100.0);
	}
	return true;
}

CMD:seb(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_SHERIFF)
		return SendErrorMessage(playerid, "You aren't in the LSSD.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "Você não está em trabalho.");

    if(!IsNearFactionSpawn(playerid, PlayerData[playerid][pFaction]))
        return SendErrorMessage(playerid, "You can't /seb here.");

	if(!PlayerData[playerid][pSwat])
	{
		PlayerData[playerid][pSwat] = true;

		SendPoliceMessage(COLOR_POLICE, "** HQ: SWAT Operative %s is now ready for orders! **", ReturnName(playerid, 0));

		SetPlayerArmourEx(playerid, 200.0);
	}
	else
	{
		PlayerData[playerid][pSwat] = false;

		SendPoliceMessage(COLOR_POLICE, "** HQ: SWAT Operative %s is now Off Duty! **", ReturnName(playerid, 0));

		SetPlayerArmourEx(playerid, 100.0);
	}

	return true;
}

CMD:trace(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_GREY, "You aren't able to trace.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendClientMessage(playerid, COLOR_GREY, "Você não está em trabalho.");

	SendClientMessage(playerid, COLOR_GRAD2, "/trace is disabled.");	

	/*new number, id = INVALID_PLAYER_ID;

	if(sscanf(params, "d", number))
		return SendSyntaxMessage(playerid, "/trace [Phone Number]");

	foreach (new p : Player)
	{
		if(PlayerData[p][pPnumber] == number)
		{
		    id = p;
		    break;
  		}
	}

	if(id == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_GRAD1, "Invalid number.");

	if(Tracing{playerid})
		return SendClientMessage(playerid, COLOR_GRAD1, "You're already tracing a number.");

	if(ph_menuid[id] == 6 && ph_sub_menuid[id] == 1)
		return SendClientMessage(playerid, COLOR_GRAD1, "No signal returned.");

	SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s runs a trace on number %d. **", Faction_GetRank(playerid), ReturnName(playerid, 0), number);

	Tracing{playerid} = true;
	TracingProgress[playerid] = 0;

	InitializeTracingSystem(playerid, id);*/
	return true;
}

CMD:tagcolor(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_GREY, "You're not a Police Officer.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendClientMessage(playerid, COLOR_GREY, "Você não está em trabalho.");

	TagColor{playerid} = !TagColor{playerid};

	SetPlayerToTeamColor(playerid);

	SendClientMessage(playerid, COLOR_YELLOW, "Your tag color has been updated.");
	return true;
}

CMD:trabalho(playerid, params[])
{
	new type = GetFactionType(playerid);
	new id = PlayerData[playerid][pFaction];

	if(!CanFactionDuty(type))
	    return SendUnauthMessage(playerid, "Você não pode entrar em trabalho.");

   	if(!IsNearFactionSpawn(playerid, id))
		return SendErrorMessage(playerid, "Você não pode entrar em trabalho aqui.");

	if(!PlayerData[playerid][pOnDuty])
	{
	    if(!isnull(params))
	    {
			if(strlen(params) < 3 || strlen(params) >= 32)
				return SendErrorMessage(playerid, "Seu callsign deve ter mais de 3 caracteres e menos de 32.");

			format(CallSign[playerid], 32, "%s", params);
	    }

 		SavePlayerWeapons(playerid);
        ResetWeapons(playerid);

        if(PlayerData[playerid][pFavUniform] != 0)
			SetPlayerSkin(playerid, PlayerData[playerid][pFavUniform]);

		switch(type)
		{
		    case FACTION_POLICE, FACTION_SHERIFF, FACTION_CORRECTIONAL:
		    {
				SetPlayerArmourEx(playerid, 100.0);

				PlayerData[playerid][pHandCuffs] = 2;

                GivePlayerValidWeapon(playerid, 24, 150, 0, false);
		        GivePlayerValidWeapon(playerid, 3, 1, 0, false);
		        GivePlayerValidWeapon(playerid, 41, 350, 0, false);

	       		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their gun and badge from a locker.", ReturnName(playerid, 0));

	       		if(isnull(params))
	       			SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now On Duty! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
				else
				    SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now On Duty under %s! **", Faction_GetRank(playerid), ReturnName(playerid, 0), CallSign[playerid]);
	  		}
	  		case FACTION_MEDIC:
			{
				SetPlayerArmourEx(playerid, 50.0);

				if(isnull(params))
					SendMedicMessage(COLOR_POLICE, "** HQ: %s %s is now On Duty! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
				else
					SendMedicMessage(COLOR_POLICE, "** HQ: %s %s is now On Duty under %s! **", Faction_GetRank(playerid), ReturnName(playerid, 0), CallSign[playerid]);
			}
		}

		TagColor{playerid} = false;
		PlayerData[playerid][pOnDuty] = true;
		SetPlayerToTeamColor(playerid);
	}
	else
	{
		ResetWeapons(playerid);
		RestorePlayerWeapons(playerid);

		TagColor{playerid} = false;
  		CallSign[playerid][0] = EOS;
		PlayerData[playerid][pHandCuffs] = 0;
		PlayerData[playerid][pOnDuty] = false;

		if(TazerActive{playerid})
		{
			TazerActive{playerid} = false;
			DeletePVar(playerid, "WeaponSlot");
			DeletePVar(playerid, "WeaponSlot2");				
		}

		BeanbagActive{playerid} = false;
		LessLethalActive{playerid} = false;		

		SetPlayerArmourEx(playerid, 0.0);
		SetPlayerToTeamColor(playerid);
		SetPlayerSkin(playerid, PlayerData[playerid][pModel]);

	    switch(type)
		{
		    case FACTION_POLICE, FACTION_SHERIFF, FACTION_CORRECTIONAL:
		    {
		        PlayerData[playerid][pSwat] = false;

				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their gun and badge inside a locker.", ReturnName(playerid, 0));

				SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now Off Duty! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
		    }
		    case FACTION_MEDIC:
			{
                PlayerData[playerid][pFireman] = false;

				SendMedicMessage(COLOR_POLICE, "** HQ: %s %s is now Off Duty! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
			}
		}
	}
	return true;
}

CMD:distintivo(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendUnauthMessage(playerid, "You can't use this command.");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/distintivo [id/nome]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(userid == playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s olha para o seu distintivo.", ReturnName(playerid, 0));

	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s mostra para %s seu distintivo.", ReturnName(playerid, 0), ReturnName(userid, 0));

	SendClientMessage(userid, COLOR_POLICE, "______________________________________");

	SendClientMessageEx(userid, COLOR_GRAD2, "  Nome: %s", ReturnNameLetter(playerid));
	SendClientMessageEx(userid, COLOR_GRAD2, "  Cargo: %s", Faction_GetRank(playerid));
	SendClientMessageEx(userid, COLOR_GRAD2, "  Agência: %s", Faction_GetName(playerid));

	SendClientMessage(userid, COLOR_POLICE, "______________________________________");
	return true;
}

CMD:meuuniforme(playerid, params[])
{
    new
		skinid,
		type = GetFactionType(playerid)
	;

    if(sscanf(params, "d", skinid))
        return SendSyntaxMessage(playerid, "/meuuniforme [uniforme ID]");

	if(type == FACTION_POLICE)
	{
	    if(skinid < 1 || skinid > sizeof(SkinsLSPD))
	        return SendErrorMessage(playerid, "ID uniforme inválido especificado 1-%d", sizeof(SkinsLSPD));

		skinid--;

		PlayerData[playerid][pFavUniform] = SkinsLSPD[skinid][skinModel];

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Seu uniforme foi definido para %d. Ele mudará automaticamente toda vez que você /trabalho.", skinid + 1);
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Se você quiser removê-lo, basta digitar /meuuniforme 0.");

		format(gquery, sizeof(gquery), "UPDATE `characters` SET `FavUniform` = %d WHERE `ID` = %d", PlayerData[playerid][pFavUniform], PlayerData[playerid][pID]);
		mysql_pquery(dbCon, gquery);
		return true;
	}
	if(type == FACTION_MEDIC)
	{
	    if(skinid < 1 || skinid > sizeof(SkinsLSFD))
	        return SendErrorMessage(playerid, "ID uniforme inválido especificado 1-%d", sizeof(SkinsLSFD));

		skinid--;

		PlayerData[playerid][pFavUniform] = SkinsLSFD[skinid][skinModel];

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Seu uniforme foi definido para %d. Ele mudará automaticamente toda vez que você /trabalho.", skinid + 1);
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Se você quiser removê-lo, basta digitar /meuuniforme 0.");

		format(gquery, sizeof(gquery), "UPDATE `characters` SET `FavUniform` = %d WHERE `ID` = %d", PlayerData[playerid][pFavUniform], PlayerData[playerid][pID]);
		mysql_pquery(dbCon, gquery);
		return true;
	}
	else if(type == FACTION_SHERIFF)
	{
	    if(skinid < 1 || skinid > sizeof(SkinsLSSD))
	        return SendErrorMessage(playerid, "ID uniforme inválido especificado 1-%d", sizeof(SkinsLSSD));

		skinid--;

		PlayerData[playerid][pFavUniform] = SkinsLSSD[skinid][skinModel];

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Seu uniforme foi definido para %d. Ele mudará automaticamente toda vez que você /trabalho.", skinid + 1);
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Se você quiser removê-lo, basta digitar /meuuniforme 0.");

		format(gquery, sizeof(gquery), "UPDATE `characters` SET `FavUniform` = %d WHERE `ID` = %d", PlayerData[playerid][pFavUniform], PlayerData[playerid][pID]);
		mysql_pquery(dbCon, gquery);
		return true;
	}
	else SendErrorMessage(playerid, "Este comando não é compatível com sua facção.");

	return true;
}

Dialog:SkinsLSPD(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, SkinsLSPD[listitem][skinModel]);

	SendNoticeMessage(playerid, "Uniforme trocado.");
	return true;
}

Dialog:SkinsLSSD(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, SkinsLSSD[listitem][skinModel]);

	SendNoticeMessage(playerid, "Uniforme trocado.");
	return true;
}

Dialog:SkinsLSFD(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, SkinsLSFD[listitem][skinModel]);

	SendNoticeMessage(playerid, "Uniforme trocado.");
	return true;
}

Dialog:SkinsDOC(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPlayerSkin(playerid, SkinsDOC[listitem][skinModel]);

	SendNoticeMessage(playerid, "Uniforme trocado.");
	return true;
}

CMD:uniforme(playerid, params[])
{
    new type = GetFactionType(playerid), id = PlayerData[playerid][pFaction];

    if(!IsNearFactionSpawn(playerid, id))
        return SendErrorMessage(playerid, "Você só pode fazer isso no spawn da sua facção.");

	new skinid, skinList[1200];

	switch(type)
	{
	    case FACTION_POLICE:
	    {
	        if(sscanf(params, "d", skinid))
	        {
				format(skinList, sizeof(skinList), "Modelo\tEtnia\tSexo\tAccessorios\n");

				for(new i = 0; i < sizeof(SkinsLSPD); ++i)
				{
					format(skinList, sizeof(skinList), "%s%d: %s\t%s\t%s\t%s\n", skinList, i + 1, SkinsLSPD[i][skinName], SkinsLSPD[i][skinRace], SkinsLSPD[i][skinGender], (SkinsLSPD[i][skinAccessories] ? ("Sim") : ("Não")));
				}

				Dialog_Show(playerid, SkinsLSPD, DIALOG_STYLE_TABLIST_HEADERS, "Selecione uma skin", skinList, "Selecionar", "Cancelar");
				return true;
	        }

	        if(skinid < 1 || skinid > sizeof(SkinsLSPD))
	            return SendErrorMessage(playerid, "Invalid ID specified (1-%d).", sizeof(SkinsLSPD));

			SetPlayerSkin(playerid, SkinsLSPD[skinid - 1][skinModel]);

			SendNoticeMessage(playerid, "Uniforme trocado.");
			return true;
	    }
	    case FACTION_MEDIC:
	    {
	        if(sscanf(params, "d", skinid))
	        {
				format(skinList, sizeof(skinList), "Modelo\tEtnia\tSexo\tAccessorios\n");

				for(new i = 0; i < sizeof(SkinsLSFD); ++i)
				{
					format(skinList, sizeof(skinList), "%s%d: %s\t%s\t%s\t%s\n", skinList, i + 1, SkinsLSFD[i][skinName], SkinsLSFD[i][skinRace], SkinsLSFD[i][skinGender], (SkinsLSFD[i][skinAccessories] ? ("Sim") : ("Não")));
				}

				Dialog_Show(playerid, SkinsLSFD, DIALOG_STYLE_TABLIST_HEADERS, "Selecione uma skin", skinList, "Selecionar", "Cancelar");
				return true;
	        }

	        if(skinid < 1 || skinid > sizeof(SkinsLSFD))
	            return SendErrorMessage(playerid, "Invalid ID specified (1-%d).", sizeof(SkinsLSFD));

			SetPlayerSkin(playerid, SkinsLSFD[skinid - 1][skinModel]);

			SendNoticeMessage(playerid, "Uniforme trocado.");
			return true;
	    }
	    case FACTION_SHERIFF:
	    {
	        if(sscanf(params, "d", skinid))
	        {
				format(skinList, sizeof(skinList), "Modelo\tEtnia\tSexo\tAccessorios\n");

				for(new i = 0; i < sizeof(SkinsLSSD); ++i)
				{
					format(skinList, sizeof(skinList), "%s%d: %s\t%s\t%s\t%s\n", skinList, i + 1, SkinsLSSD[i][skinName], SkinsLSSD[i][skinRace], SkinsLSSD[i][skinGender], (SkinsLSSD[i][skinAccessories] ? ("Sim") : ("Não")));
				}

				Dialog_Show(playerid, SkinsLSSD, DIALOG_STYLE_TABLIST_HEADERS, "Selecione uma skin", skinList, "Selecionar", "Cancelar");
				return true;
	        }

	        if(skinid < 1 || skinid > sizeof(SkinsLSSD))
	            return SendErrorMessage(playerid, "Invalid ID specified (1-%d).", sizeof(SkinsLSSD));

			SetPlayerSkin(playerid, SkinsLSSD[skinid - 1][skinModel]);

			SendNoticeMessage(playerid, "Uniforme trocado.");
			return true;
	    }
		case FACTION_CORRECTIONAL:
		{
	        if(sscanf(params, "d", skinid))
	        {
				format(skinList, sizeof(skinList), "Modelo\tEtnia\tSexo\tAccessorios\n");

				for(new i = 0; i < sizeof(SkinsDOC); ++i)
				{
					format(skinList, sizeof(skinList), "%s%d: %s\t%s\t%s\t%s\n", skinList, i + 1, SkinsDOC[i][skinName], SkinsDOC[i][skinRace], SkinsDOC[i][skinGender], (SkinsDOC[i][skinAccessories] ? ("Sim") : ("Não")));
				}

				Dialog_Show(playerid, SkinsDOC, DIALOG_STYLE_TABLIST_HEADERS, "Selecione uma skin", skinList, "Selecionar", "Cancelar");
				return true;
	        }

	        if(skinid < 1 || skinid > sizeof(SkinsDOC))
	            return SendErrorMessage(playerid, "Invalid ID specified (1-%d).", sizeof(SkinsDOC));

			SetPlayerSkin(playerid, SkinsDOC[skinid - 1][skinModel]);

			SendNoticeMessage(playerid, "Uniforme trocado.");			
			return true;
		}
	    default: SendErrorMessage(playerid, "Não aplicável.");
	}
	return true;
}

CMD:takedrugs(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	new userid, bool:has_drugs;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/takedrugs [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 2.5))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	for(new i = 0; i < MAX_PLAYER_DRUGS; ++i)
	{
		if(Player_Drugs[userid][i][dID] != -1)
		{
			Player_Drugs[userid][i][dAmount] = 0.0;
			Player_Drugs[userid][i][dID] = -1;

			has_drugs = true;
		}
	}

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes %s's drugs.", ReturnName(playerid, 0), ReturnName(userid, 0));

	if(has_drugs)
	{
		format(gquery, sizeof(gquery), "DELETE FROM `player_drugs` WHERE `PlayerSQLID` = '%i'", PlayerData[userid][pID]);
		mysql_tquery(dbCon, gquery);
	}
	return true;
}

CMD:tie(playerid, params[])
{
    new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/tie [id/Mask/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(IsCuffed{playerid} || IsTied{playerid} || PlayerData[playerid][pInjured])
		return SendErrorMessage(playerid, "You cannot perform this action right now.");	
	
    if(userid == playerid)
	    return SendErrorMessage(playerid, "You cannot tie yourself.");	

	if(!IsPlayerNearPlayer(playerid, userid, 2.5))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(IsTied{userid} || IsCuffed{userid})
		return SendErrorMessage(playerid, "The player is tied / cuffed.");	

	if(GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "The player must be on foot.");		

	if(GetPlayerSpecialAction(userid) != SPECIAL_ACTION_HANDSUP && GetPlayerAnimationIndex(userid) != 1151 && !Blindfold{userid})
	    return SendErrorMessage(playerid, "Player must be with the handsup / fall animation or blindfolded");		

	IsTied{userid} = true;	

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
    SetPlayerAttachedObject(userid, 9, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);	

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You have tied %s", ReturnName(userid, 0));
	SendClientMessageEx(userid, COLOR_YELLOW, "-> You have been tied by %s", ReturnName(playerid, 0));
	return true;
}

CMD:untie(playerid, params[])
{
	new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/untie [id/Mask/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(IsCuffed{playerid} || IsTied{playerid} || PlayerData[playerid][pInjured])
		return SendErrorMessage(playerid, "You cannot perform this action right now.");	

    if(userid == playerid)
	    return SendErrorMessage(playerid, "You cannot untie yourself.");	

	if(!IsPlayerNearPlayer(playerid, userid, 2.5))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(!IsTied{userid})
		return SendErrorMessage(playerid, "The player is not tied.");	

	IsTied{userid} = false;		

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(userid, 9);
	return true;
}

YCMD:hc(playerid, params[], help) = handcuff;

CMD:handcuff(playerid, params[])
{
    new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/handcuff [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!PlayerData[playerid][pHandCuffs] && !AdminDuty{playerid})
	    return SendErrorMessage(playerid, "You don't have any handcuffs.");

    if(userid == playerid)
	    return SendErrorMessage(playerid, "You cannot cuff yourself.");

    if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You cannot cuff anyone while being inside of a vehicle.");

	if(!IsPlayerNearPlayer(playerid, userid, 2.5))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return SendErrorMessage(playerid, "Player must be on foot.");

    if(IsCuffed{userid})
        return SendErrorMessage(playerid, "The player is either handcuffed already, or is being restrained.");

	if(IsTied{userid})
		return SendErrorMessage(playerid, "The player is tied.");		

    IsCuffed{userid} = true;

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_CUFFED);
    SetPlayerAttachedObject(userid, 9, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);

    PlayerData[playerid][pHandCuffs] -= 1;

    SendNoticeMessage(userid, "You were handcuffed by %s.", ReturnName(playerid, 0));

	SendNoticeMessage(playerid, "You now have %d sets of handcuffs.", PlayerData[playerid][pHandCuffs]);
	SendNoticeMessage(playerid, "You handcuffed %s.", ReturnName(userid, 0));
    return true;
}

CMD:passhandcuffs(playerid, params[])
{
    new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/passhandcuffs [id/PoN]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "You are not close enough to that player.");

	if(!PlayerData[playerid][pHandCuffs])
	    return SendErrorMessage(playerid, "You don't have any handcuffs.");

	PlayerData[playerid][pHandCuffs] -= 1, PlayerData[userid][pHandCuffs] += 1;

    SendNoticeMessage(playerid, "You now have %d sets of handcuffs.", PlayerData[playerid][pHandCuffs]);
    SendNoticeMessage(userid, "You now have %d sets of handcuffs.", PlayerData[userid][pHandCuffs]);
	return true;
}

CMD:myhandcuffs(playerid, params[])
{
	SendNoticeMessage(playerid, "You have %d sets of handcuffs.", PlayerData[playerid][pHandCuffs]);
	return true;
}

YCMD:uhc(playerid, params[], help) = unhandcuff;

CMD:unhandcuff(playerid, params[])
{
    new
	    userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/unhandcuff [id/nome]");

	if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_CORRECTIONAL && !AdminDuty{playerid})
  		return SendUnauthMessage(playerid, "Unauthorized.");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

    if(IsCuffed{playerid})
        return SendErrorMessage(playerid, "You're cuffed.");

    if(!IsCuffed{userid})
        return SendErrorMessage(playerid, "This player is not cuffed.");

    IsCuffed{userid} = false;

    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(userid, 9);

    PlayerData[playerid][pHandCuffs] += 1;

    SendNoticeMessage(playerid, "You now have %d sets of handcuffs.", PlayerData[playerid][pHandCuffs]);
    return true;
}

/*CMD:tolls(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendErrorMessage(playerid, "Voc? n?o esta autorizado a utilizar este coomando.");

	gstr[0] = EOS;

	strcat(gstr, "{FFFFFF}Welcome to the toll booth management menu!\n\n");
	strcat(gstr, "{FFFFFF}From this menu you can toggle the locked status of tolls\n");
	strcat(gstr, "{FFFFFF}and view some information on a specific toll around San Andreas\n\n");
	strcat(gstr, "{FFFFFF}This front screen will also display financial and statistical data \nof all tholl booth's including visits, taxatinns and payments made\n\for the past 60 minutes\n\n");
	strcat(gstr, "{DDFF3F}Statistical Information:\n");

	format(sgstr, sizeof(sgstr), "{FFFFFF}Booths Opened: %d        Payments: $%d        Taxed: $%d       Times Locked: %d", TollsOpenCount, TollsPayed, TollsTaxed, TollsLocked);
	strcat(gstr, sgstr);

	ShowPlayerDialog(playerid, TOLLS_DIALOG, DIALOG_STYLE_MSGBOX, "{FFFFFF}Toolbooth Management", gstr, "Proceed", "Exit");
    return true;
}*/

CMD:graffiti(playerid, params[]) return ShowGraffitiDialog(playerid);

CMD:armas(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "Para jogar uma arma fora, digite /dropgun [arma ID]");

	for(new i = 0; i < 13; ++i)
	{
	    if(PlayerData[playerid][pGuns][i] != 0 && PlayerData[playerid][pAmmo][i] != 0)
		{
	    	SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d] Arma: [%s] - Munição: [%d]", PlayerData[playerid][pGuns][i], ReturnWeaponName(PlayerData[playerid][pGuns][i]), PlayerData[playerid][pAmmo][i]);
		}
	}
	return true;
}

stock CanBeHidden(weaponid)
{
	switch(weaponid)
	{
	    case 3, 4, 22, 23, 24, 28, 32: return true;

	    default: return false;
	}

	return false;
}

CMD:arma(playerid, params[])
{
	new option[16], weaponname[64];

	if(sscanf(params, "s[16]S()[64]", option, weaponname))
		return SendSyntaxMessage(playerid, "/arma [ajustar / bone / esconder / resetar]");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	    return SendErrorMessage(playerid, "Você deve estar a pé.");

	if(EditingWeapon{playerid})
	    return SendErrorMessage(playerid, "Você já está editando uma arma.");

	if(!strcmp(option, "ajustar", true))
	{
		if(!strlen(weaponname))
		    return SendSyntaxMessage(playerid, "/arma [ajustar] [weapon name]");

		new weaponid = -1;

		if((weaponid = GetWeaponByName(weaponname)) == -1)
			return SendErrorMessage(playerid, "Invalid weapon name specified.");

		new slot = g_aWeaponAttach[weaponid];

		if(slot == -1)
			return SendErrorMessage(playerid, "Esta arma não pode ser editada.");

		SetPlayerAttachedObject(playerid, 9, GetGunObjectID(weaponid), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
		EditAttachedObject(playerid, 9);

		SetPVarInt(playerid, "AttachSlot", slot);

        EditingWeapon{playerid} = true;
	}
	else if(!strcmp(option, "bone", true))
	{
		if(!strlen(weaponname))
		    return SendSyntaxMessage(playerid, "/arma [bone] [weapon name]");

		new weaponid = -1;

		if((weaponid = GetWeaponByName(weaponname)) == -1)
			return SendErrorMessage(playerid, "Invalid weapon name specified.");

		new slot = g_aWeaponAttach[weaponid];

		if(slot == -1)
			return SendErrorMessage(playerid, "Esta arma não pode ser editada.");

		SetPVarInt(playerid, "AttachSlot", weaponid);

		Dialog_Show(playerid, WeaponAdjustBone, DIALOG_STYLE_LIST, "Bone", "Coluna\nCabeça\nBraço esquerdo superior\nBraço direito superior\nMão esquerda\nMão direita\nCoxa esquerda\nCoxa direita\nPé esquerdo\nPé direito\nPanturrilha direita\nPanturrilha esquerda\nAntebraço esquerdo\nAntebraço direito\nOmbro esquerdo\nOmbro direito\nPescoço\nmandíbula", "Escolher", "Cancelar");
	}
	else if(!strcmp(option, "esconder", true))
	{
		if(!strlen(weaponname))
		    return SendSyntaxMessage(playerid, "/arma [esconder] [weapon name]");

		new weaponid = -1;

		if((weaponid = GetWeaponByName(weaponname)) == -1)
			return SendErrorMessage(playerid, "Invalid weapon name specified.");

		new slot = g_aWeaponAttach[weaponid];

		if(slot == -1)
			return SendErrorMessage(playerid, "Esta arma não pode ser editada.");

		if(!CanBeHidden(weaponid))
			return SendErrorMessage(playerid, "This weapon cannot be hidden.");

		if(WeaponSettings[playerid][slot][awHide])
		{
  			WeaponSettings[playerid][slot][awHide] = 0;

			SendClientMessageEx(playerid, COLOR_LIGHTRED, "You have set your %s to show.", ReturnWeaponName(weaponid));
		}
		else
		{
			WeaponSettings[playerid][slot][awHide] = 1;

			SendClientMessageEx(playerid, COLOR_LIGHTRED, "You have set your %s not to show.", ReturnWeaponName(weaponid));
		}

		UpdateWeaponSettings(playerid, slot);

     	cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));
	}
	else if(!strcmp(option, "resetar", true))
	{
		if(!strlen(weaponname))
		    return SendSyntaxMessage(playerid, "/arma [resetar] [weapon name]");

		new weaponid = -1;

		if((weaponid = GetWeaponByName(weaponname)) == -1)
			return SendErrorMessage(playerid, "Invalid weapon name specified.");

		new slot = g_aWeaponAttach[weaponid];

		if(slot == -1)
			return SendErrorMessage(playerid, "Esta arma não pode ser editada.");

 		SetPVarInt(playerid, "ResetWeaponid", weaponid);
		SetPVarInt(playerid, "ResetWeaponSlot", slot);

		Dialog_Show(playerid, WeaponReset, DIALOG_STYLE_MSGBOX, "Você tem certeza?", "Tem certeza de que deseja resetar o ajuste de sua arma?", "Sim", "Não");
	}
	else SendSyntaxMessage(playerid, "/arma [ajustar / bone / esconder / resetar]");

	return true;
}

Dialog:WeaponAdjustBone(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    DeletePVar(playerid, "AttachSlot");
	    return 1;
	}
	if(response)
	{
	    new
	        weaponid = GetPVarInt(playerid, "AttachSlot"),
	        slot = g_aWeaponAttach[weaponid]
		;

		WeaponSettings[playerid][slot][awBone] = listitem + 1;

		SetPlayerAttachedObject(playerid, 9, GetGunObjectID(weaponid), WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz], WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz], 1, 1, 1);
		EditAttachedObject(playerid, 9);

		SetPVarInt(playerid, "AttachSlot", slot);

        EditingWeapon{playerid} = true;

        SendClientMessageEx(playerid, -1, "You have successfully changed the bone of your %s.", ReturnWeaponName(weaponid));
	}
	return true;
}

Dialog:WeaponReset(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			slot = GetPVarInt(playerid, "ResetWeaponSlot")
		;

		WeaponSettings[playerid][slot][awHide] = 0;
		WeaponSettings[playerid][slot][awBone] = 1;
		WeaponSettings[playerid][slot][aPx] = -0.116;
		WeaponSettings[playerid][slot][aPy] = 0.189;
		WeaponSettings[playerid][slot][aPz] = 0.088;
		WeaponSettings[playerid][slot][aPrx] = 0.0;
		WeaponSettings[playerid][slot][aPry] = 44.5;
		WeaponSettings[playerid][slot][aPrz] = 0.0;

		SendNoticeMessage(playerid, "Adjustment of your %s was reset.", ReturnWeaponName(GetPVarInt(playerid, "ResetWeaponid")));

		UpdateWeaponSettings(playerid, slot);

		cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));
	}

	DeletePVar(playerid, "ResetWeaponSlot");
	DeletePVar(playerid, "ResetWeaponid");
	return true;
}

CMD:dropgun(playerid, params[])
{
	new
	    weaponid;

	if(sscanf(params, "d", weaponid))
	    return SendClientMessage(playerid, COLOR_WHITE, "/dropgun WeaponID (see /weapons for an ID)");

	if(!PlayerHasWeaponEx(playerid, weaponid))
		return SendErrorMessage(playerid, "You don't have that weapon. See /weapons for a list.");

	if(PlayerHasWeapon(playerid, weaponid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Use /dropararma instead for weapons in your /stats.");

	RemoveWeapon(playerid, weaponid);

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s throws their %s away.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));	
	return true;
}

YCMD:da(playerid, params[], help) = dropararma;

CMD:dropararma(playerid, params[])
{
    if(PlayerData[playerid][pLevel] < 2)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: Desculpa, somente nível 2 e acima.");

  	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
    	return SendClientMessage(playerid, COLOR_LIGHTRED, "Você precisa estar agachado para utilizar /dropararma.");

	if(PlayerData[playerid][pOnDuty])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode fazer isso enquanto estiver de trabalho.");

	new weaponid, Float:x, Float:y, Float:z;

	if(sscanf(params, "d", weaponid))
	{
		SendSyntaxMessage(playerid, "/dropararma [arma id]");
	 	SendNoticeMessage(playerid, "Para pegar a arma, use /pegararma.");
	 	return true;
	}

	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "Você especificou um id inválido.");

	new slot = -1, ammo;

	for(new i = 0; i < 3; ++i)
	{
	    if(PlayerData[playerid][pWeapon][i] == weaponid)
	    {
	        slot = i;

	        ammo = PlayerData[playerid][pAmmunation][slot];
	        break;
	    }
	}

	if(slot == -1)
	    return SendServerMessage(playerid, "Desculpe, apenas armas que fazem parte do seu /stats.");

	RemoveWeapon(playerid, weaponid);

  	GetPlayerPos(playerid, x, y, z);
  	DropWeapon(weaponid, ammo, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	SendClientMessage(playerid, COLOR_WHITE, "/pegararma para recuperá-lo.");
	SendNoticeMessage(playerid, "A arma desaparecerá se não for coletada em 30 minutos.");

	SQL_LogAction(playerid, "Dropou %s e %d munições", ReturnWeaponName(weaponid), ammo);
	return true;
}

YCMD:pa(playerid, params[], help) = pegararma;
//PEGAR ARMA CHÃO
CMD:pegararma(playerid, params[])
{
	if(PlayerData[playerid][pLevel] < 2)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: Desculpe, apenas nível 2 e superior.");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Desculpe, você precisa estar a pé.");

	if(PlayerData[playerid][pOnDuty])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode fazer isso enquanto estiver em trabalho.");

	new id;

	if((id = DropGun_Nearest(playerid)) == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "  ..Não há nada ao seu redor.");

	if(IsWeaponSlotTaken(playerid, DroppedWeapons[id][DropGunAmmount][0]))
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Arma: %d - %s O canal está em uso no momento.", DroppedWeapons[id][DropGunAmmount][0], ReturnWeaponName(DroppedWeapons[id][DropGunAmmount][0]));

	new weaponid = DroppedWeapons[id][DropGunAmmount][0], ammo = DroppedWeapons[id][DropGunAmmount][1];

	GivePlayerValidWeapon(playerid, weaponid, ammo);

	format(sgstr, sizeof(sgstr), "* %s pega um(a) %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000);

	ResetDropWeapon(id);

	SQL_LogAction(playerid, "Picks up %s and %d ammo", ReturnWeaponName(weaponid), ammo);
	return true;
}

CMD:entregararma(playerid, params[])
{
	new userid, weaponid;

	if(sscanf(params, "ui", userid, weaponid))
		return SendSyntaxMessage(playerid, "/entregararma [id/nome] [arma id]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if(playerid == userid)
	    return SendErrorMessage(playerid, "Você não pode passar armas para si mesmo.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

	if(PlayerData[userid][pLevel] < 2)
	    return SendErrorMessage(playerid, "O destinatário deve estar no nível 2 ou superior.");

	new slot = -1, ammo;

	for(new i = 0; i < 3; ++i)
	{
	    if(PlayerData[playerid][pWeapon][i] == weaponid)
	    {
	        slot = i;

	        ammo = PlayerData[playerid][pAmmunation][slot];
	        break;
	    }
	}

	if(slot == -1)
		return SendErrorMessage(playerid, "Você não tem essa arma.");

	if(IsWeaponSlotTaken(userid, weaponid))
		return SendErrorMessage(playerid, "Esse jogador já está carregando um(a) %s, eles devem largá-lo primeiro.", ReturnSlotName(ReturnWeaponSlot(weaponid)));

	if(PlayerData[playerid][pOnDuty])
	    return SendErrorMessage(playerid, "Você não pode fazer isso enquanto estiver de trabalho.");

    RemoveWeapon(playerid, weaponid);
    GivePlayerValidWeapon(userid, weaponid, ammo);

	format(sgstr, sizeof(sgstr), "* %s entrega %s para %s.", ReturnName(playerid, 0), ReturnName(userid, 0), ReturnWeaponName(weaponid));
	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);

    SendNoticeMessage(playerid, "Você entregou sua %s para %s.", ReturnWeaponName(weaponid), ReturnName(userid, 0));
	SendNoticeMessage(userid, "%s entregou sua %s para você.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));

	SQL_LogAction(playerid, "Deu %s para %s junto com %d munições", ReturnName(userid), ReturnWeaponName(weaponid), ammo);
    SQL_LogAction(userid, "%s deu %s e %d munições", ReturnName(playerid), ReturnWeaponName(weaponid), ammo);
	return true;
}

CMD:curar(playerid, params[])
{
	new
	    userid,
	    oneString[32],
	    type = GetFactionType(playerid),
	    id = PlayerData[playerid][pFaction],
	    Float:max_health = 100.0 + PlayerData[playerid][pSHealth]
	;

	if(sscanf(params, "dS()[32]", userid, oneString) || type != FACTION_MEDIC)
	{
	 	if(type == FACTION_POLICE || type == FACTION_SHERIFF || type == FACTION_MEDIC || type == FACTION_CORRECTIONAL)
	 	{
	        if(IsNearFactionSpawn(playerid, id))
		 	{
	  			if(PlayerData[playerid][pOnDuty])
	  			{
		  	 	    SendClientMessage(playerid, COLOR_WHITE, "Você foi curado em 100% e recebeu um novo colete.");

		 			if(type == FACTION_MEDIC)
		 			{
					 	SetPlayerArmourEx(playerid, 50.0);
					}
		 			else
		 			{
		 			    if(!PlayerData[playerid][pSwat])
		 			    {
					 		SetPlayerArmourEx(playerid, 100.0);
						}
						else
						{
						    SetPlayerArmourEx(playerid, 200.0);
						}
					}

		  			SetPlayerHealthEx(playerid, max_health);
		  			return true;
	  			}
	  			else
	  			{
				 	if(PlayerData[playerid][pHealth] >= max_health)
					    return SendClientMessage(playerid, COLOR_WHITE, "Você já está com a sua saúde máxima");

			 		SendClientMessage(playerid, COLOR_WHITE, "Você foi curado até a saúde máxima");

			  		SetPlayerHealthEx(playerid, max_health);
			  		return true;
	  			}
			}
		}

		if((id = Property_Inside(playerid)) != -1)
		{
			if(!GetHouseItem(id, 1))
			    return SendErrorMessage(playerid, "You're not near a fridge.");

			if(PlayerData[playerid][pHealth] >= max_health)
				return SendClientMessage(playerid, COLOR_WHITE, "Você já está com a sua saúde máxima");

			if(PropertyData[id][hCash] < 2500)
				return SendClientMessage(playerid, COLOR_YELLOW, "Você precisa de pelo menos $2500 no depósito.");

            SendClientMessage(playerid, COLOR_WHITE, "Você foi curado até a saúde máxima");

	        SetPlayerHealthEx(playerid, max_health);
	        return true;
	    }
		else if((id = Business_Inside(playerid)) != -1)
		{
			if(PlayerData[playerid][pHealth] >= max_health)
				return SendClientMessage(playerid, COLOR_WHITE, "Você já está com a sua saúde máxima");

            SendClientMessage(playerid, COLOR_WHITE, "Você foi curado até a saúde máxima");

	        SetPlayerHealthEx(playerid, max_health);
			return true;
		}
	    return true;
	}

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 10.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "O jogador está desconectado ou não está perto de você.");

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode fazer isso sozinho.");

	if(PlayerData[userid][pInjured] || DeathMode{userid})
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "O jogador está ferido ou morto..");

	if(PlayerData[userid][pHealth] >= 100)
 		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você só pode curar fora da ambulância se a pessoa estiver com menos de 100% de saúde..");

 	new bill;

 	if(sscanf(oneString, "d", bill)) bill = 200;

 	if(bill < 1 || bill > 200)
 	    return SendClientMessage(playerid, COLOR_LIGHTRED, "A conta não pode ser menor que 1 e maior que 200.");

    SetPlayerHealthEx(userid, 100.0);

    TakePlayerMoney(userid, bill);

    SendClientMessageEx(userid, COLOR_WHITE, "Você foi curado até 100% de saúde. -$%d.", bill);

	new string[128];
	format(string, sizeof(string), "~y~you curado~n~~w~%s~n~~g~$200", ReturnName(userid, 0));
	GameTextForPlayer(playerid, string, 9000, 1);
	return true;
}

CMD:equip(playerid, params[])
{
	if(SwitchingWeapon{playerid})
	{
	    KillTimer(EquipTimer[playerid]);

	    SwitchingWeapon{playerid} = false;

	    return SendNoticeMessage(playerid, "Action was canceled.");
	}

	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "You aren't in a vehicle.");

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You can't use this as the driver.");

	new option[32], weaponid;

	if(sscanf(params, "s[32]", option))
	{
	    SendNoticeMessage(playerid, "This will arm and disarm small guns to and from your hand.");
		SendSyntaxMessage(playerid, "/equip [weapon ID] OR 'hand'");
		return true;
	}

	if(IsNumeric(option))
	{
	    weaponid = strval(option);

	    if(weaponid == 24)
	        return SendErrorMessage(playerid, "No, Desert Eagles aren't allowed.");

	    if(!PlayerHasWeapon(playerid, weaponid))
	        return SendErrorMessage(playerid, "Sorry, only the guns that are part of your /stats.");

	    SwitchingWeapon{playerid} = true;

		if(GetPlayerWeapon(playerid) == weaponid)
		{
			SendNoticeMessage(playerid, "Putting away your %s. This will take 5 seconds.", ReturnWeaponName(weaponid));
		}
		else
		{
			SendNoticeMessage(playerid, "Grabbing your %s. This will take 5 seconds.", ReturnWeaponName(weaponid));
		}

		SendNoticeMessage(playerid, "To cancel, use /equip again.");

		EquipTimer[playerid] = SetTimerEx("SwitchArmedWeapon", 5000, false, "dd", playerid, weaponid);
	}
	else
	{
	    if(strcmp(option, "hand", false) == 0)
	    {
	        SetPlayerArmedWeapon(playerid, 0);

	        SendNoticeMessage(playerid, "Your %s has been un-equipped.", ReturnWeaponName(GetPlayerWeapon(playerid)));
	    }
	    else
	    {
		    SendNoticeMessage(playerid, "This will arm and disarm small guns to and from your hand.");
			SendSyntaxMessage(playerid, "/equip [weapon ID] OR 'hand'");
	    }
	}

	return true;
}

FUNX::SwitchArmedWeapon(playerid, weaponid)
{
    SwitchingWeapon{playerid} = false;

	if(!IsPlayerInAnyVehicle(playerid) || !PlayerHasWeapon(playerid, weaponid))
	    return true;

	if(GetPlayerWeapon(playerid) != weaponid)
	{
		SetPlayerArmedWeapon(playerid, weaponid);

		SendNoticeMessage(playerid, "Your %s has been equipped.", ReturnWeaponName(weaponid));
	}
	else
	{
		SetPlayerArmedWeapon(playerid, 0);

		SendNoticeMessage(playerid, "Your %s has been un-equipped.", ReturnWeaponName(weaponid));
	}
	return true;
}

CMD:pullincar(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "You aren't in a vehicle.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não é o motorista.");

	new userid, seat[16], vehicleid = GetPlayerVehicleID(playerid);

	if(sscanf(params, "us[16]", userid, seat))
	    return SendSyntaxMessage(playerid, "/pullincar [playerid / PoN ] [fr (frontright) / bl (backleft) / br (backright)]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Invalid player specified.");
		}
	}

	if(IsABicycle(vehicleid) || IsABike(vehicleid))
	    return SendErrorMessage(playerid, "You can't use this while in a bike.");

	if(!IsPlayerNearPlayer(playerid, userid, 7.0))
	    return SendErrorMessage(playerid, "You are too far away from that player.");

    if(GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "Player is not on foot.");

    if(!IsBrutallyWounded(userid))
        return SendErrorMessage(playerid, "That player is not in the brutally wounded mode.");

	if(userid == playerid)
	    return SendErrorMessage(playerid, "You can't use this on yourself.");

	if(IsBrutallyWounded(playerid))
	    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

    new seatid = -1;

	if(!strcmp(seat, "fr", true)) seatid = 1;
	else if(!strcmp(seat, "bl", true)) seatid = 2;
	else if(!strcmp(seat, "br", true)) seatid = 3;

	if(seatid == -1)
		return SendErrorMessage(playerid, "Invalid seat specified.");

	if(IsVehicleSeatUsed(vehicleid, seatid))
	    return SendErrorMessage(playerid, "This seat is already in use.");

	death_Pause[userid] = 2;

	ClearAnimations(userid);
	PutPlayerInVehicle(userid, vehicleid, seatid);
	TogglePlayerControllable(userid, false);
	ApplyAnimation(userid, "ped", "CAR_dead_LHS", 4.1, 0, 0, 0, 1, 0, 1);

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s pulls wounded %s into the %s.", ReturnName(playerid, 0), ReturnName(userid, 0), ReturnVehicleName(vehicleid));
	return true;
}

CMD:eject(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "You aren't in a vehicle.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não é o motorista.");

	new userid, vehicleid = GetPlayerVehicleID(playerid);

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/eject [id/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Invalid player specified.");
		}
	}

	if(userid == playerid)
	    return SendErrorMessage(playerid, "You can't eject yourself.");

	if(GetPlayerVehicleID(userid) != vehicleid)
	    return SendErrorMessage(playerid, "Player is not in your vehicle.");

    RemovePlayerFromVehicle(userid);

	SendNoticeMessage(playerid, "The passenger has been ejected!");
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s throws %s out of the car.", ReturnName(playerid, 0), ReturnName(userid, 0));
	return true;
}

CMD:pegar(playerid, params[])
{
	if(IsBrutallyWounded(playerid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "  ..You are unconscious, you can't do this now.");

    if(PlayerData[playerid][pLevel] < 2)
	    return SendClientMessage(playerid, COLOR_GRAD1, "   You must have level 2 or above.");

	new slot, id = -1, string[256];

	if(sscanf(params, "d", slot))
		return SendClientMessage(playerid, COLOR_WHITE, "/pegar slot_id (ID List in /check.)");

	if((id = Property_Inside(playerid)) != -1)
	{
   		if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropertyData[id][hCheckPosX], PropertyData[id][hCheckPosY], PropertyData[id][hCheckPosZ]))
            return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in the right position to do this command.");

		if(PlayerData[playerid][pOnDuty])
			return SendErrorMessage(playerid, "You can't do this while on duty.");

	    slot--;

		if(slot < 0 || slot >= MAX_HOUSE_WEAPONS)
			return SendServerMessage(playerid, "There is nothing there..Invalid Slot ID.");

		if(!PropertyData[id][hWeapon][slot])
		    return SendErrorMessage(playerid, "There's nothing there.");

		new slot_taken = IsWeaponSlotTaken(playerid, PropertyData[id][hWeapon][slot]);

		if(slot_taken)
		    return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Gun ID: %d - %s. Is currently occupying your %s slot.", PlayerData[playerid][pWeapon][slot_taken - 1], ReturnWeaponName(PlayerData[playerid][pWeapon][slot_taken - 1]), ReturnSlotName(slot_taken - 1));

		GivePlayerValidWeapon(playerid, PropertyData[id][hWeapon][slot], PropertyData[id][hAmmo][slot], PropertyData[id][hWeaponLicense][slot]);

		PropertyData[id][hWeapon][slot] = 0;
		PropertyData[id][hAmmo][slot] = 0;
		PropertyData[id][hWeaponLicense][slot] = 0;

		Property_Save(id);
		return true;
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid), bool:faction_car, bool:gunrack;

		if(IsPolice(playerid))
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				foreach (new i : sv_servercar)
				{
				    if(vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction])
						continue;

					if(IsPlayerNearBoot(playerid, vehicleVariables[i][vVehicleScriptID]) && (GetTrunkStatus(vehicleVariables[i][vVehicleScriptID]) || IsVehicleTrunkBroken(vehicleVariables[i][vVehicleScriptID])))
					{
						vehicleid = vehicleVariables[i][vVehicleScriptID], faction_car = true;
						break;
					}
				}
			}
			else
			{
			    if(IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]) != -1)
				{
					faction_car = true, gunrack = true;
				}
			}
		}

		if(faction_car)
		{
			if(!PlayerData[playerid][pOnDuty])
			    return SendErrorMessage(playerid, "Você não está em trabalho.");

		    if(IsABike(vehicleid) || IsABicycle(vehicleid))
		        return SendErrorMessage(playerid, "This vehicle doesn't support storage.");

			new bool:is_non_lethal, weaponid, ammo;

			if(slot < 1 || slot > 13)
			    return SendServerMessage(playerid, "There is nothing there..Invalid Slot ID.");

			if((slot == 4 || slot == 5) && !PlayerData[playerid][pSwat])
				return SendErrorMessage(playerid, "This weapon is for SWAT only.");

			if(slot == 12 && GetFactionType(playerid) != FACTION_CORRECTIONAL)
			    return SendErrorMessage(playerid, "This weapon is for DCR only.");

			switch(slot)
			{
				case 1:
				{
					weaponid = 25, ammo = 30;

					is_non_lethal = false;
				}
    			case 2: weaponid = 29, ammo = 200;
			    case 3: weaponid = 31, ammo = 150;
			    case 4: weaponid = 27, ammo = 100;
			    case 5: weaponid = 34, ammo = 50;
			    case 6: weaponid = 43, ammo = 9999;
			    case 7: weaponid = 41, ammo = 9999;
			    case 8: weaponid = 3, ammo = 1;
			    case 9: weaponid = 42, ammo = 9999;
			    case 10:
				{
					weaponid = 25, ammo = 30;

					is_non_lethal = true;
				}
				case 11: weaponid = 24, ammo = 100;
				case 12: weaponid = 33, ammo = 20;
				case 13:
				{
					weaponid = 33, ammo = 20;

					is_non_lethal = true;
				}
			}

			if(PlayerHasWeapon(playerid, weaponid))
			    return SendClientMessageEx(playerid, COLOR_YELLOW, "You're already holding a %s, place that before grabbing another.", ReturnWeaponName(weaponid));

  			new slot_taken = IsWeaponSlotTaken(playerid, weaponid);

		    if(slot_taken)
		    	return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Gun ID: %d - %s. Is currently occupying your %s slot.", PlayerData[playerid][pWeapon][slot_taken - 1], ReturnWeaponName(PlayerData[playerid][pWeapon][slot_taken - 1]), ReturnSlotName(slot_taken - 1));

			if(weaponid == 25)
			{
				BeanbagActive{playerid} = is_non_lethal;
			}

			if(weaponid == 33)
			{
				LessLethalActive{playerid} = is_non_lethal;
			}

			GivePlayerValidWeapon(playerid, weaponid, ammo, 0, false);

			if(!gunrack)
				format(string, sizeof(string), "* %s grabs a %s from the %s's trunk.", ReturnName(playerid, 0), ReturnWeaponName(weaponid, playerid), ReturnVehicleName(vehicleid));
			else
				format(string, sizeof(string), "* %s grabs a %s from the %s's gun rack.", ReturnName(playerid, 0), ReturnWeaponName(weaponid, playerid), ReturnVehicleName(vehicleid));

			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 8000); SendClientMessage(playerid, COLOR_PURPLE, string);
			return true;
		}
		else
		{
		    new
		        bool:on_foot
			;

			vehicleid = -1;

		    if(IsPlayerInAnyVehicle(playerid))
		    {
				vehicleid = Car_GetID(GetPlayerVehicleID(playerid));
			}

		    if(vehicleid == -1)
		    {
		    	foreach (new i : sv_playercar)
		    	{
		    		if(IsPlayerNearBoot(playerid, CarData[i][carVehicle]))
		    		{
		    			if(GetTrunkStatus(CarData[i][carVehicle]) || IsVehicleTrunkBroken(CarData[i][carVehicle]))
		    			{
		    			    vehicleid = i, on_foot = true;
		    			    break;
		    			}
		    		}
		    	}
		    }

		    if(vehicleid != -1)
		    {
				if(PlayerData[playerid][pOnDuty])
				    return SendErrorMessage(playerid, "You can't do this while on duty.");

			    if(IsABike(CarData[vehicleid][carVehicle]) || IsABicycle(CarData[vehicleid][carVehicle]))
			        return SendErrorMessage(playerid, "This vehicle doesn't support storage.");

				slot--;

		    	if(slot < 0 || slot >= MAX_CAR_WEAPONS)
		    	    return SendServerMessage(playerid, "There is nothing there..Invalid Slot ID.");

		    	if(!CarData[vehicleid][carWeapon][slot])
		    	    return SendErrorMessage(playerid, "There's nothing there.");

		    	if(CarPlace[vehicleid][slot][cPType] && !GetEngineStatus(CarData[vehicleid][carVehicle]))
		    		return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Start the engine");

				if((CarPlace[vehicleid][slot][cPType] && on_foot || !CarPlace[vehicleid][slot][cPType] && !on_foot) && IsDoorVehicle(CarData[vehicleid][carVehicle]))
				    return SendErrorMessage(playerid, "You must be closer to the weapon.");

		    	new slot_taken = IsWeaponSlotTaken(playerid, CarData[vehicleid][carWeapon][slot]);

		    	if(slot_taken)
		    		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Gun ID: %d - %s. Is currently occupying your %s slot.", PlayerData[playerid][pWeapon][slot_taken - 1], ReturnWeaponName(PlayerData[playerid][pWeapon][slot_taken - 1]), ReturnSlotName(slot_taken - 1));

				new weaponid = CarData[vehicleid][carWeapon][slot], ammo = CarData[vehicleid][carAmmo][slot], license = CarData[vehicleid][carWeaponLicense][slot];

		    	DestroyDynamicObject(CarPlace[vehicleid][slot][cPobj]);

		    	CarData[vehicleid][carWeapon][slot] = 0;
		    	CarData[vehicleid][carAmmo][slot] = 0;
		    	CarData[vehicleid][carWeaponLicense][slot] = 0;

		    	GivePlayerValidWeapon(playerid, weaponid, ammo, license);

		    	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && CarPlace[vehicleid][slot][cPType] || weaponid == 24) SetPlayerArmedWeapon(playerid, 0);

		    	format(string, sizeof(string), "* %s grabs a %s from the %s's trunk.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(CarData[vehicleid][carVehicle]));
		        SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);

                SQL_LogAction(playerid, "Took a %s (%d bullets) from vehicle id %d (dbid: %d)", ReturnWeaponName(weaponid), ammo, CarData[vehicleid][carVehicle], CarData[vehicleid][carID]);
		    	return true;
		    }
		}
	}

	SendServerMessage(playerid, "Sorry, you need to be by an open storage spot of a vehicle or in a house.");
	return true;
}

CMD:colocar(playerid, params[])
{
	if(IsBrutallyWounded(playerid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "  ..You are unconscious, you can't do this now.");

    if(PlayerData[playerid][pLevel] < 2)
	    return SendClientMessage(playerid, COLOR_GRAD1, "   You must have level 2 or above.");

	new weaponid, ammo, id = -1, slot, string[256];

	if(sscanf(params, "d", weaponid))
		return SendClientMessage(playerid, COLOR_WHITE, "/colocar weapon_id (ID List in /weapons.)");

	if(!PlayerHasWeapon(playerid, weaponid))
	   return SendServerMessage(playerid, "Sorry, only the guns that are part of your /stats.");

	slot = ReturnWeaponSlot(weaponid), ammo = PlayerData[playerid][pAmmunation][slot];

	if((id = Property_Inside(playerid)) != -1)
	{
   		if(!IsPlayerInRangeOfPoint(playerid, 2.0, PropertyData[id][hCheckPosX], PropertyData[id][hCheckPosY], PropertyData[id][hCheckPosZ]))
            return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in the right position to do this command.");

		if(PlayerData[playerid][pOnDuty])
			return SendErrorMessage(playerid, "You can't do this while on duty.");

		new idx = -1;

		for(new x = 0; x < MAX_HOUSE_WEAPONS; ++x)
		{
			if(!PropertyData[id][hWeapon][x])
			{
				idx = x;
				break;
			}
		}

		if(idx == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "There is no space left in the house.");

		PropertyData[id][hWeapon][idx] = weaponid;
		PropertyData[id][hAmmo][idx] = ammo;

		RemoveWeapon(playerid, weaponid);

		SendClientMessage(playerid, COLOR_LIGHTRED, "/pegar to take a gun from the car / house.");

		Property_Save(id);
		return true;
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid), bool:faction_car, bool:gunrack;

		if(IsPolice(playerid))
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				foreach (new i : sv_servercar)
				{
				    if(vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction])
						continue;

					if(IsPlayerNearBoot(playerid, vehicleVariables[i][vVehicleScriptID]) && (GetTrunkStatus(vehicleVariables[i][vVehicleScriptID]) || IsVehicleTrunkBroken(vehicleVariables[i][vVehicleScriptID])))
					{
						vehicleid = vehicleVariables[i][vVehicleScriptID], faction_car = true;
						break;
					}
				}
			}
			else
			{
			    if(IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]) != -1)
				{
					faction_car = true, gunrack = true;
				}
			}
		}

		if(faction_car)
		{
			if(!PlayerData[playerid][pOnDuty])
			    return SendErrorMessage(playerid, "Você não está em trabalho.");

		 	if(IsABike(vehicleid) || IsABicycle(vehicleid))
				return SendErrorMessage(playerid, "This vehicle doesn't support storage.");

			if(!IsGunrackWeapon(weaponid))
			    return SendClientMessageEx(playerid, COLOR_YELLOW, "Cannot place %s in the car.", ReturnWeaponName(weaponid));

			if(!gunrack)
				format(string, sizeof(string), "* %s stores a %s in the %s's trunk.", ReturnName(playerid, 0), ReturnWeaponName(weaponid, playerid), ReturnVehicleName(vehicleid));
			else
				format(string, sizeof(string), "* %s stores a %s in the %s's gun rack.", ReturnName(playerid, 0), ReturnWeaponName(weaponid, playerid), ReturnVehicleName(vehicleid));

			SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 8000); SendClientMessage(playerid, COLOR_PURPLE, string);

			if(weaponid == 25)
			{
				BeanbagActive{playerid} = false;
			}

			if(weaponid == 33)
			{
				LessLethalActive{playerid} = false;
			}

			RemoveWeapon(playerid, weaponid);
			SetPlayerArmedWeapon(playerid, 0);
			return true;
		}
		else
		{
		    new
				bool:on_foot
			;

			vehicleid = -1;

		    if(IsPlayerInAnyVehicle(playerid))
		    {
				vehicleid = Car_GetID(GetPlayerVehicleID(playerid));
			}

		    if(vehicleid == -1)
		    {
		    	foreach (new i : sv_playercar)
		    	{
		    		if(IsPlayerNearBoot(playerid, CarData[i][carVehicle]))
		    		{
		    			if(GetTrunkStatus(CarData[i][carVehicle]) || IsVehicleTrunkBroken(CarData[i][carVehicle]))
		    			{
		    			    vehicleid = i, on_foot = true;
		    			    break;
		    			}
		    		}
		    	}
		    }

		    if(vehicleid != -1)
		    {
				if(PlayerData[playerid][pOnDuty])
				    return SendErrorMessage(playerid, "You can't do this while on duty.");

			    if(IsABike(CarData[vehicleid][carVehicle]) || IsABicycle(CarData[vehicleid][carVehicle]))
			        return SendErrorMessage(playerid, "This vehicle doesn't support storage.");

				new idx = -1;

				for(new x = 0; x < MAX_CAR_WEAPONS; ++x)
				{
				    if(!CarData[vehicleid][carWeapon][x])
				    {
						idx = x;
						break;
				    }
				}

				if(idx == -1)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "There is no space left in this car.");

				CarData[vehicleid][carWeapon][idx] = weaponid;
				CarData[vehicleid][carAmmo][idx] = ammo;

				RemoveWeapon(playerid, weaponid);
				SetPlayerArmedWeapon(playerid, 0);

				new
					Float:fX,
					Float:fY,
					Float:fZ,
					Float:vA,
					Float:finalx,
					Float:finaly,
					Float:finalz,
					Float:finalrz
				;

				if(on_foot)
				{
					GetVehicleBootInside(CarData[vehicleid][carVehicle], fX, fY, fZ);
					GetVehicleZAngle(CarData[vehicleid][carVehicle], vA);

					CarPlace[vehicleid][idx][cPobj] = CreateDynamicObject(GetGunObjectID(weaponid), fX, fY, fZ + 0.1, 90.0, 270, vA + 135);

					GetVehicleAttachCroods(CarData[vehicleid][carVehicle], fX, fY, fZ + 0.1, vA + 135, finalx, finaly, finalz, finalrz);

					CarPlace[vehicleid][idx][cPx] = finalx;
					CarPlace[vehicleid][idx][cPy] = finaly;
					CarPlace[vehicleid][idx][cPz] = finalz;
					CarPlace[vehicleid][idx][cPrx] = 90.0;
					CarPlace[vehicleid][idx][cPry] = 270.0;
					CarPlace[vehicleid][idx][cPrz] = finalrz;
					CarPlace[vehicleid][idx][cPType] = 0;

					PlayerPlaceSlot[playerid] = idx;
					PlayerPlaceCar[playerid] = vehicleid;

					EditDynamicObject(playerid, CarPlace[vehicleid][idx][cPobj]);
				}
				else
				{
					GetVehicleInside(CarData[vehicleid][carVehicle], fX, fY, fZ);
					GetVehicleZAngle(CarData[vehicleid][carVehicle], vA);

					CarPlace[vehicleid][idx][cPobj] = CreateDynamicObject(GetGunObjectID(weaponid), fX, fY, fZ, -100.0, -45, vA + 135);

					GetVehicleAttachCroods(CarData[vehicleid][carVehicle], fX, fY, fZ, vA + 135, finalx, finaly, finalz, finalrz);

					CarPlace[vehicleid][idx][cPx] = finalx;
					CarPlace[vehicleid][idx][cPy] = finaly;
					CarPlace[vehicleid][idx][cPz] = finalz;
					CarPlace[vehicleid][idx][cPrx] = -100.0;
					CarPlace[vehicleid][idx][cPry] = -45.0;
					CarPlace[vehicleid][idx][cPrz] = finalrz;
					CarPlace[vehicleid][idx][cPType] = 1;

					PlayerPlaceSlot[playerid] = idx;
					PlayerPlaceCar[playerid] = vehicleid;

					EditDynamicObject(playerid, CarPlace[vehicleid][idx][cPobj]);
				}

				format(string, sizeof(string), "* %s stores a %s in the %s's trunk.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(CarData[vehicleid][carVehicle]));
				SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);

                SendNoticeMessage(playerid, "You can press {FF6347}W{FFFFFF} and move your camera around.");
				SendClientMessageEx(playerid, COLOR_YELLOW, "You have stored a %s in the %s.", ReturnWeaponName(weaponid), g_arrVehicleNames[CarData[vehicleid][carModel] - 400]);
                SendClientMessage(playerid, COLOR_LIGHTRED, "/pegar to take a gun from the car / house.");

                SQL_LogAction(playerid, "Placed %s (%d bullets) in vehicle %d (dbid: %d)", ReturnWeaponName(weaponid), ammo, CarData[vehicleid][carVehicle], CarData[vehicleid][carID]);
		    	return true;
		    }
		}
	}

	SendServerMessage(playerid, "Sorry, you need to be by an open storage spot of a vehicle or in a house.");
	return true;
}

CMD:check(playerid, params[])
{
	new id = -1;

	if((id = Property_Inside(playerid)) != -1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][hCheckPosX], PropertyData[id][hCheckPosY], PropertyData[id][hCheckPosZ]))
		{
			gstr[0] = EOS;

			for(new x = 0; x < MAX_HOUSE_WEAPONS; ++x)
			{
				if(PropertyData[id][hWeapon][x] > 0)
				{
					if(IsMelee(PropertyData[id][hWeapon][x]))
					{
						format(gstr, sizeof(gstr), "%s(%d)%s\n", gstr, x + 1, ReturnWeaponName(PropertyData[id][hWeapon][x]));
					}
					else format(gstr, sizeof(gstr), "%s(%d)%s[Ammo:%d]\n", gstr, x + 1, ReturnWeaponName(PropertyData[id][hWeapon][x]), PropertyData[id][hAmmo][x]);
				}
				else format(gstr, sizeof(gstr), "%s[EMPTY]\n", gstr);
			}

			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, "Weapon Storage", gstr, ">>", "");
			return true;
		}
	}
	else
	{
	    new vehicleid = GetPlayerVehicleID(playerid), string[128];

		foreach (new i : sv_playercar)
		{
			if(vehicleid == CarData[i][carVehicle] || (IsPlayerNearBoot(playerid, CarData[i][carVehicle]) && (GetTrunkStatus(CarData[i][carVehicle]) || IsVehicleTrunkBroken(CarData[i][carVehicle]))))
		    {
				for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
				{
				   	if(CarData[i][carWeapon][x] != 0)
					{
				 		if(IsMelee(CarData[i][carWeapon][x]))
						 	format(string, sizeof(string), "%s(%d)%s\n", string, x + 1, ReturnWeaponName(CarData[i][carWeapon][x]));
						else
							format(string, sizeof(string), "%s(%d)%s[Ammo:%d]\n", string, x + 1, ReturnWeaponName(CarData[i][carWeapon][x]), CarData[i][carAmmo][x]);
					}
					else format(string, sizeof(string), "%s[EMPTY]\n", string);
				}

		        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, "Weapon Storage", string, ">>", "");
				return true;
			}
		}

        if(IsPolice(playerid))
        {
			foreach (new i : sv_servercar)
			{
			    if(vehicleVariables[i][vVehicleFaction] == -1 || vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction]) continue;

				if(IsPlayerInAnyVehicle(playerid) && vehicleid == vehicleVariables[i][vVehicleScriptID] || IsPlayerNearBoot(playerid, vehicleVariables[i][vVehicleScriptID]) && (GetTrunkStatus(vehicleVariables[i][vVehicleScriptID]) || IsVehicleTrunkBroken(vehicleVariables[i][vVehicleScriptID])))
				{
					return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST,
						"Trunk",
						"1. Shotgun[Ammo: 30]\n2. MP5[Ammo:200]\n3. M4[Ammo: 150]\n4. SPAZ[Ammo: 100]\n5. Sniper[Ammo: 50]\n6. Camera\n7. Pepperspray\n8. Nitestick\n9. Fire Extinguisher\n10. Beanbag Shotgun\n11. Desert Eagle\n12. Country Rifle (DCR only)\n13. 40mm Less-Lethal Launcher",
						"Ok", ""
					);
				}
			}
		}
	}

	SendServerMessage(playerid, "Sorry, you need to be by an open storage spot of a vehicle or in a house.");
	return true;
}

CMD:vpacote(playerid, params[])
{
	new input, carid = -1;

	if(sscanf(params, "d", input) || PlayerData[playerid][pAdmin] < 1)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		    return SendErrorMessage(playerid, "Você não pode fazer isso agora.");

        new vehicleid = GetPlayerVehicleID(playerid);

		if((carid = Car_GetID(vehicleid)) == -1)
		    return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

		ShowVehicleWeapons(playerid, carid);
		return true;
	}

	if(!IsValidVehicle(input))
	    return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	if((carid = Car_GetID(input)) == -1)
		return SendServerMessage(playerid, "This command is only available for private vehicles, you are in a public vehicle (Static)");

	ShowVehicleWeapons(playerid, carid);
	return true;
}

CMD:setstation(playerid, params[])
{
	new id = -1;

	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid), carid = -1;

		if((carid = Car_GetID(vehicleid)) != -1)
		{
			if(!GetEngineStatus(vehicleid))
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Start the engine.");

			if(CarData[carid][carXM] == 0)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Your vehicle doesn't have a XM Radio installed.");

			ShowBoomBoxStations(playerid);
			return true;
		}
		else
		{
			foreach (new i : sv_servercar)
			{
				if(vehicleVariables[i][vVehicleFaction] == -1) continue;

				if(vehicleVariables[i][vVehicleScriptID] == vehicleid && FactionData[vehicleVariables[i][vVehicleFaction]][factionType] == GetFactionType(playerid))
				{
					ShowBoomBoxStations(playerid);
				}
			}
		}
		return true;
	}
	else if((id = Boombox_Nearest(playerid, 5.0)) != INVALID_PLAYER_ID)
	{
		if(grantboombox[playerid] != id && id != playerid)
			SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have permission to change the channel for this Boombox.");

		ShowBoomBoxStations(playerid);
		return true;
	}
	else if((id = Property_Inside(playerid)) != -1)
	{
		if(!GetHouseItem(id, 2))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "The house does not have a radio.");

        ShowBoomBoxStations(playerid);
		return true;
	}
	else if((id = Business_Inside(playerid)) != -1)
	{
		if(!Business_IsOwner(playerid, id))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not the owner.");

        ShowBoomBoxStations(playerid);
		return true;			
	}
	return true;
}

CMD:bizinfo(playerid, params[])
{
	if(PlayerData[playerid][pPbiskey] == -1)
	    return SendClientMessage(playerid, COLOR_WHITE, "You must be in your business.");

	Business_PrintInfo(playerid, PlayerData[playerid][pPbiskey]);
	return true;
}

CMD:compprice(playerid, params[])
{
	new bouse = PlayerData[playerid][pPbiskey], price;

	if(bouse == -1)
		return SendClientMessage(playerid, COLOR_GRAD2, "You are not the owner of the business.");

	if(sscanf(params, "d", price))
		return SendSyntaxMessage(playerid, "/compprice [amount]");

	if(price < 0 || price > 20000)
		return SendClientMessage(playerid, COLOR_WHITE, "The minimum is $0 and the greatest number is $20000.");

	if(price > BusinessData[bouse][bTill])
		return SendClientMessage(playerid, COLOR_WHITE, "Você não tem dinheiro suficiente in the cashbox.");

	BusinessData[bouse][bPriceProd] = price;

	SendClientMessageEx(playerid, COLOR_WHITE, "Component price set to: $%d", BusinessData[bouse][bPriceProd]);

	Business_Save(bouse);
	return true;
}

CMD:bizfee(playerid, params[])
{
	new bouse = PlayerData[playerid][pPbiskey], fee;

	if(bouse == -1)
		return SendClientMessage(playerid, COLOR_GRAD2, "You are not the owner of the business.");

    if(sscanf(params, "d", fee))
		return SendSyntaxMessage(playerid, "/bizfee [EntranceFee]");

	if(fee < 0 || fee > 1000)
		return SendErrorMessage(playerid, "The maximum fee for your business is $1,000.");

	BusinessData[bouse][bEntranceCost] = fee;

	SendNoticeMessage(playerid, "Entrance fee has been set to %s.", FormatNumber(BusinessData[bouse][bEntranceCost]));

	Business_Save(bouse);
	return true;
}

CMD:ctrancar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return true;

	new id = -1;

	if((id = (Property_Inside(playerid) == -1) ? (nearProperty_var[playerid]) : (Property_Inside(playerid))) != -1)
	{
		if(Property_IsOwner(playerid, id) || PlayerData[playerid][pHouseKey] == id)
		{
			if(!PropertyData[id][hLocked])
			{
				PropertyData[id][hLocked] = 1;
				GameTextForPlayer(playerid, "~w~Casa ~r~Trancada", 5000, 6);
				PlaySound(playerid, 1145);
				return true;
			}
			else
			{
				PropertyData[id][hLocked] = 0;
				GameTextForPlayer(playerid, "~w~Casa ~g~Destrancada", 5000, 6);
				PlaySound(playerid, 1145);
				return true;
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~r~Você não possui a chave", 5000, 6);
			return true;
		}
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está perto de uma casa.");
	return true;
}

CMD:ftrancar(playerid, params[])
{	
	new id = -1;

	if((id = InProperty[playerid]) != -1) 
	{
		if(!Property_IsOwner(playerid, id) && PlayerData[playerid][pHouseKey] != id) return true;

		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		for(new x = 0; x != MAX_FURNITURE; ++x)
		{
			if(HouseFurniture[id][x][fOn])
			{
				if(isHouseDoor(HouseFurniture[id][x][fModel]))
				{
					fDistance[1] = GetPlayerDistanceFromPoint(playerid, HouseFurniture[id][x][fPosX], HouseFurniture[id][x][fPosY], HouseFurniture[id][x][fPosZ]);

					if(fDistance[1] < fDistance[0])
					{
						fDistance[0] = fDistance[1];
						i = x;
					}
				}
			}
		}

		if(i != -1 && fDistance[1] < 3)
		{
			if(HouseFurniture[id][i][fOpened] == true)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode trancar uma porta aberta.");

			if(!HouseFurniture[id][i][fLocked])
			{
				SendClientMessage(playerid, COLOR_WHITE, "Porta {FFFF00}fechada.");

				HouseFurniture[id][i][fLocked] = 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_WHITE, "Porta {FFFF00}aberta.");

				HouseFurniture[id][i][fLocked] = 0;
			}
		}		
		return true;
	}
	else if((id = InBusiness[playerid]) != -1) 
	{
		if(!Business_IsOwner(playerid, id)) return true;

		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		for(new x = 0; x != MAX_FURNITURE; ++x)
		{
			if(BizFurniture[id][x][fOn])
			{
				if(isHouseDoor(BizFurniture[id][x][fModel]))
				{
					fDistance[1] = GetPlayerDistanceFromPoint(playerid, BizFurniture[id][x][fPosX], BizFurniture[id][x][fPosY], BizFurniture[id][x][fPosZ]);

					if(fDistance[1] < fDistance[0])
					{
						fDistance[0] = fDistance[1];
						i = x;
					}
				}
			}
		}

		if(i != -1 && fDistance[1] < 3)
		{
			if(BizFurniture[id][i][fOpened] == true)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode trancar uma porta aberta.");

			if(!BizFurniture[id][i][fLocked])
			{
				SendClientMessage(playerid, COLOR_WHITE, "Porta {FFFF00}fechada.");

				BizFurniture[id][i][fLocked] = 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_WHITE, "Porta {FFFF00}aberta.");

				BizFurniture[id][i][fLocked] = 0;
			}
		}
		return true;
	}
	return true;
}

CMD:trancar(playerid, params[])
{
	new id = -1, vehicleid, canlock;

	if(!IsPlayerInAnyVehicle(playerid) && (id = (Property_Inside(playerid) == -1) ? (nearProperty_var[playerid]) : (Property_Inside(playerid))) != -1)
	{
		if(Property_IsOwner(playerid, id) || PlayerData[playerid][pHouseKey] == id)
		{
			new
			    Float:fDistance[2] = {99999.0, 0.0},
			    i = -1
			;

			for(new x = 0; x != MAX_FURNITURE; ++x)
			{
				if(HouseFurniture[id][x][fOn])
				{
					if(isHouseDoor(HouseFurniture[id][x][fModel]))
					{
						fDistance[1] = GetPlayerDistanceFromPoint(playerid, HouseFurniture[id][x][fPosX], HouseFurniture[id][x][fPosY], HouseFurniture[id][x][fPosZ]);

						if(fDistance[1] < fDistance[0])
						{
							fDistance[0] = fDistance[1];
							i = x;
						}
					}
				}
			}

			if(i != -1 && fDistance[1] < 3)
			{
				if(HouseFurniture[id][i][fOpened] == true)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode trancar uma porta aberta.");

				if(!HouseFurniture[id][i][fLocked])
				{
					SendClientMessage(playerid, COLOR_WHITE, "A porta está {FFFF00}trancada.");

					HouseFurniture[id][i][fLocked] = 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "A porta está {FFFF00}destrancada.");

					HouseFurniture[id][i][fLocked] = 0;
				}
				return true;
			}

			if(!PropertyData[id][hLocked])
			{
				PropertyData[id][hLocked] = 1;
				GameTextForPlayer(playerid, "~w~Casa ~r~Fechada", 5000, 6);
				PlaySound(playerid, 1145);
				return true;
			}
			else
			{
				PropertyData[id][hLocked] = 0;
				GameTextForPlayer(playerid, "~w~Casa ~g~Aberta", 5000, 6);
				PlaySound(playerid, 1145);
				return true;
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~r~Você não possui uma chave", 5000, 6);
			return true;
		}
	}
	else if(!IsPlayerInAnyVehicle(playerid) && (id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	{
		if(Business_IsOwner(playerid, id))
		{
			new
			    Float:fDistance[2] = {99999.0, 0.0},
			    i = -1
			;

			for(new x = 0; x != MAX_FURNITURE; ++x)
			{
				if(BizFurniture[id][x][fOn])
				{
					if(isHouseDoor(BizFurniture[id][x][fModel]))
					{
						fDistance[1] = GetPlayerDistanceFromPoint(playerid, BizFurniture[id][x][fPosX], BizFurniture[id][x][fPosY], BizFurniture[id][x][fPosZ]);

						if(fDistance[1] < fDistance[0])
						{
							fDistance[0] = fDistance[1];
							i = x;
						}
					}
				}
			}

			if(i != -1 && fDistance[1] < 3)
			{
				if(BizFurniture[id][i][fOpened] == true)
					return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode trancar uma porta aberta.");

				if(!BizFurniture[id][i][fLocked])
				{
					SendClientMessage(playerid, COLOR_WHITE, "A porta está {FFFF00}trancada.");

					BizFurniture[id][i][fLocked] = 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "A porta está {FFFF00}destrancada.");

					BizFurniture[id][i][fLocked] = 0;
				}
				return true;
			}

			if(!BusinessData[id][bLocked])
			{
				BusinessData[id][bLocked] = true;

                GameTextForPlayer(playerid, "~w~Você ~r~trancou~w~ a empresa!", 5000, 4);
                return true;
			}
  			else
			{
				BusinessData[id][bLocked] = false;

                GameTextForPlayer(playerid, "~w~Você ~g~destrancou~w~ a empresa!", 5000, 4);
				return true;
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~r~Você não possui uma chave", 5000, 6);
			return true;
		}
	}
	else if(!IsPlayerInAnyVehicle(playerid) && (id = (Apartment_Inside(playerid) == -1) ? (nearApartment_var[playerid]) : (Apartment_Inside(playerid))) != -1)
	{
		if(Complex_IsOwner(playerid, id) || ComplexData[id][aFaction] != -1 && ComplexData[id][aFaction] == PlayerData[playerid][pFaction])
		{
			if(!ComplexData[id][aLocked])
			{
				ComplexData[id][aLocked] = 1;
				SendNoticeMessage(playerid, "%s trancada.", ComplexData[id][aInfo]);
				Complex_Save(id);
				return true;
			}
			else
			{
				ComplexData[id][aLocked] = 0;
				SendNoticeMessage(playerid, "%s destrancada.", ComplexData[id][aInfo]);
				Complex_Save(id);
				return true;
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~r~Você não possui uma chave", 5000, 6);
			return true;
		}
	}
	else if((IsPlayerInAnyVehicle(playerid) ? ((vehicleid = GetPlayerVehicleID(playerid)) != 0) : ((vehicleid = Car_Nearest(playerid)) != -1)))
	{
		new
			engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective,
			str[128]
		;

		if((id = Car_GetID(vehicleid)) != -1) // player vehicle
		{
			if(HasVehicleKey(playerid, id, true) || (PlayerData[playerid][pAdmin] >= 3 && AdminDuty{playerid}))
			{
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

				if(!CarData[id][carLocked])
				{
					CarData[id][carLocked] = true;

					format(str, sizeof(str), "~r~%s Trancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				}
				else
				{
					CarData[id][carLocked] = false;

					format(str, sizeof(str), "~g~%s Destrancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, bonnet, boot, objective);
				}
			}
			else
			{
                SendServerMessage(playerid, "Você não pode acessar este veículo.");

				if(CarData[id][carLocked])
				{
					if(!isnull(params) && !strcmp(params, "breakin", true))
					{
						if(CoreVehicles[vehicleid][vbreaktime] > 0) return true;

						SendClientMessage(playerid, COLOR_WHITE, "Agora você pode começar a bater na porta do motorista! Métodos de arrombamento:");
	                    SendClientMessageEx(playerid, COLOR_WHITE, "-%s", ReturnWeaponName(GetPlayerWeapon(playerid)));
	                    SendClientMessageEx(playerid, COLOR_WHITE, "-%s", ReturnWeaponType(GetPlayerWeapon(playerid)));

	                    if(IsABike(vehicleid) || IsABicycle(vehicleid))
	                    {
	                        CoreVehicles[vehicleid][vbreakin] = 1;
							CoreVehicles[vehicleid][vbreakeffect] = BLOCK_NONE;
	                    }
	                    else
	                    {
		                    switch(CarData[id][carLock])
		                    {
								case 0: CoreVehicles[vehicleid][vbreakin] = 25, CoreVehicles[vehicleid][vbreakeffect] = BLOCK_NONE;
								case 1: CoreVehicles[vehicleid][vbreakin] = 50, CoreVehicles[vehicleid][vbreakeffect] = LESS_DAMAGE_FIST;
								case 2: CoreVehicles[vehicleid][vbreakin] = 75, CoreVehicles[vehicleid][vbreakeffect] = BLOCK_FIST;
								case 3: CoreVehicles[vehicleid][vbreakin] = 150, CoreVehicles[vehicleid][vbreakeffect] = LESS_DAMAGE_MELEE;
								case 4: CoreVehicles[vehicleid][vbreakin] = 200, CoreVehicles[vehicleid][vbreakeffect] = BLOCK_PHYSICAL;
		                    }
						}

						if(!Iter_Contains(sv_activevehicles, vehicleid))
						{
							Iter_Add(sv_activevehicles, vehicleid);
						}

                        BreakingIn[playerid] = vehicleid;
                        CoreVehicles[vehicleid][vbreaktime] = 20;

                        TriggerVehicleAlarm(playerid, vehicleid);
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: Se você tentar arrombar{FFFF00}{FFFFFF}: \"/lock br{FFFF00}eakin\"");
						return true;
					}
				}
			}
			return true;
		}
		else if((id = Vehicle_GetID(vehicleid)) != -1) // server vehicle
		{
		    if(vehicleVariables[id][vVehicleFaction] == PlayerData[playerid][pFaction] || AdminDuty{playerid})
		    {
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

				if(doors != 1)
				{
					format(str, sizeof(str), "~r~%s Trancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				else
				{
					format(str, sizeof(str), "~g~%s Destrancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
		    }
		    return true;
		}
		else if(IsVehicleRental(vehicleid)) // rental vehicle
		{
			if(RentCarKey[playerid] == vehicleid || AdminDuty{playerid})
			{
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

				if(doors != 1)
				{
					format(str, sizeof(str), "~r~%s Trancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
				else
				{
					format(str, sizeof(str), "~g~%s Destrancado", ReturnVehicleName(vehicleid));
					GameTextForPlayer(playerid, str, 1000, 4);
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				}
			}
			return true;
		}
	}

	if(!canlock)
	{
		new
			Float:fDistance[2] = {99999.0, 0.0},
			i = -1
		;

		foreach (new x: Movedoors)
		{
			fDistance[1] = GetPlayerDistanceFromPoint(playerid, Doors[x][doorPosX], Doors[x][doorPosY], Doors[x][doorPosZ]);

			if(fDistance[1] < fDistance[0])
			{
				fDistance[0] = fDistance[1];
				i = x;
			}
		}

		if(i != -1 && fDistance[0] < 3)
		{
			if(Doors[i][doorFaction] == -1 || (Doors[i][doorFaction] != -1 && GetFactionType(playerid) == Doors[i][doorFaction]) || (Doors[i][doorFaction] == FACTION_CORRECTIONAL && IsPolice(playerid)))
			{
				if(Doors[i][doorLocked] == 1)
				{
					Doors[i][doorLocked] = 0;

					if(Doors[i][doorFaction] == FACTION_CORRECTIONAL)
					{
					    SendClientMessageEx(playerid, COLOR_WHITE, "* {33AA33}Opened {FFFFFF}door '%s'. (Digital Signature: %s %s)", Doors[i][doorName], Faction_GetRank(playerid), ReturnName(playerid, 0));
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE, "Door is {FFFF00}unlocked.");
					}
				}
				else
				{
				    if(Doors[i][doorOpened] == 1)
				        return SendClientMessage(playerid, COLOR_LIGHTRED, "You can not lock an opened door.");

					Doors[i][doorLocked] = 1;

                    if(Doors[i][doorFaction] == FACTION_CORRECTIONAL)
                    {
                    	SendClientMessageEx(playerid, COLOR_WHITE, "* {AA3333}Closed {FFFFFF}door '%s'. (Digital Signature: %s %s)", Doors[i][doorName], Doors[i][doorName], Faction_GetRank(playerid), ReturnName(playerid, 0));
					}
					else
					{
						SendClientMessage(playerid, COLOR_WHITE, "Door is {FFFF00}locked.");
					}
				}
				return true;
			}
		}

		// Dynamic Points
		foreach	(new x : Entrance)
		{
			if(InApartment[playerid] == EntranceData[x][outsideApartmentID])
			{
				if(IsPlayerInRangeOfPoint(playerid, EntranceData[x][pointRange], EntranceData[x][outsidePos][0], EntranceData[x][outsidePos][1], EntranceData[x][outsidePos][2]))
				{
					if(EntranceData[x][pointFaction] == -1 || PlayerData[playerid][pAdmin] >= 4 && AdminDuty{playerid} || EntranceData[x][pointFaction] == GetFactionType(playerid))
					{
						if(EntranceData[x][pointLocked])
						{
							EntranceData[x][pointLocked] = 0;
							SendNoticeMessage(playerid, "%s has been unlocked.", EntranceData[x][pointName]);
						}
						else
						{
							EntranceData[x][pointLocked] = 1;
							SendNoticeMessage(playerid, "%s has been locked.", EntranceData[x][pointName]);
						}

						mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `pointLocked` = '%d' WHERE `ID` = '%d' LIMIT 1", EntranceData[x][pointLocked], EntranceData[x][pointID]);
						mysql_pquery(dbCon, gquery);						
					}
					return true;
				}
			}

			if(InApartment[playerid] == EntranceData[x][insideApartmentID])
			{
				if(IsPlayerInRangeOfPoint(playerid, EntranceData[x][pointRange], EntranceData[x][insidePos][0], EntranceData[x][insidePos][1], EntranceData[x][insidePos][2]))
				{
					if(EntranceData[x][pointFaction] == -1 || PlayerData[playerid][pAdmin] >= 4 && AdminDuty{playerid} || EntranceData[x][pointFaction] == GetFactionType(playerid))
					{
						if(EntranceData[x][pointLocked])
						{
							EntranceData[x][pointLocked] = 0;
							SendNoticeMessage(playerid, "%s has been unlocked.", EntranceData[x][pointName]);
						}
						else
						{
							EntranceData[x][pointLocked] = 1;
							SendNoticeMessage(playerid, "%s has been locked.", EntranceData[x][pointName]);
						}	

						mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `pointLocked` = '%d' WHERE `ID` = '%d' LIMIT 1", EntranceData[x][pointLocked], EntranceData[x][pointID]);
						mysql_pquery(dbCon, gquery);												
					}
					return true;
				}
			}			
		}		
	}

	if(!canlock) SendServerMessage(playerid, "Either there are no vehicles around to lock/unlock, or the vehicle is unsynced, try /v tow.");

	return true;
}

/*CMD:newspaper(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1663.4677, -2332.1433, -2.6797))
	{
	  	TogglePlayerControllable(playerid, false);

  		ShowMenuForPlayer(Guide, playerid);
		return true;
	}
	else SendClientMessage(playerid, COLOR_GREY, "** You are not near the newspaper.");

	return true;
}*/

CMD:buycomp(playerid, params[])
{
	new compid = 60;

	if(PlayerData[playerid][pJob] != JOB_MECHANIC && PlayerData[playerid][pSideJob] != JOB_MECHANIC)
	    return SendClientMessage(playerid, COLOR_GRAD2, "You are not a Car Mechanic");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, StorageData[compid][in_posx], StorageData[compid][in_posy], StorageData[compid][in_posz]))
	{
		SetPlayerCheckpoint(playerid, StorageData[compid][in_posx], StorageData[compid][in_posy], StorageData[compid][in_posz], 4.0);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_COMP;

		SendClientMessage(playerid, COLOR_LIGHTRED, "You're not inside a warehouse, one has been marked for you on the map.");
		return true;
	}
	else
	{
		new vehicleid = GetPlayerVehicleID(playerid), amount, tmp2[16];

		if(GetVehicleModel(vehicleid) != 525)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a Towtruck.");

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o motorista.");

		if(sscanf(params, "dS()[16]", amount, tmp2))
		{
		    SendClientMessage(playerid, COLOR_LIGHTRED, "You are limited to 1-2000 components.");
		    SendClientMessage(playerid, COLOR_WHITE, "!! Each piece has its own product 25 piece!!");
		    return 1;
		}

		new string[16], price = amount*StorageData[compid][in_price], slot = -1;

		if(!sscanf(tmp2, "s[16]", string))
		{
	        if(strcmp(string, "yes", true) == 0)
			{
				if(PlayerData[playerid][pCash] <  price)
				    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro suficiente.");

				if(StorageData[compid][in_stock] <  amount)
				    return SendClientMessage(playerid, COLOR_WHITE, "There no components left in stock.");

                if((slot = Car_GetID(vehicleid)) != -1)
				{
                    if(CarData[slot][carComps] + (amount * 25) < 50000)
                    {
						TakePlayerMoney(playerid, price);

						//CoreVehicles[vehicleid][vehComponent] += amount * 25;
	                    CarData[slot][carComps] += amount * 25;

						StorageData[compid][in_stock] -= amount;

						if(StorageData[compid][in_stock] < 0) StorageData[compid][in_stock] = 0;

			   			UpdateStorage(compid);

						SendClientMessageEx(playerid, COLOR_WHITE, "You bought %d (%d Products) components for your truck.", amount, amount * 25);
					}
					else SendClientMessage(playerid, COLOR_WHITE, "Component limit is 1-2000, you can't get more.");
				}
				else SendServerMessage(playerid, "This order is only available for private vehicles. But you are in a public vehicle (Static)");

				return true;
			}
		}

		SendClientMessageEx(playerid, COLOR_WHITE, "Cost: {E85050}%s", FormatNumber(price));
		SendClientMessageEx(playerid, COLOR_WHITE, "USE: /buycomp %d yes", amount);
	}
	return true;
}

CMD:paintcar(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_MECHANIC && PlayerData[playerid][pSideJob] != JOB_MECHANIC)
	    return SendClientMessage(playerid, COLOR_GRAD2, "You are not a Car Mechanic");

	new carid = -1, pcarid = -1;

    if((carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	{
        if(CarData[carid][carModel] != 525)
			return SendClientMessage(playerid, COLOR_GRAD1, "You are not in a Towtruck.");

        new color1, color2, userid, confirm[16];

		if(sscanf(params, "uddS()[16]", userid, color1, color2, confirm))
			return SendSyntaxMessage(playerid, "/paintcar [id/nome] [color 1] [color 2]");

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "s[24]{ddS()[16]}", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
			}
		}

		if(color1 > 255 || color2 > 255 || color1 < 0 || color2 < 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid color specified (0-255).");

		if(userid == playerid)
			return SendClientMessage(playerid, COLOR_GRAD1, "You cannot offer services to yourself.");

		if(tToAccept[userid] != OFFER_TYPE_NONE)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "The player already has another offer.");

		if(!IsPlayerNearPlayer(playerid, userid, 10.0))
		   return SendClientMessage(playerid, COLOR_GRAD1, "That player is not near you.");

		if((pcarid = Car_GetID(GetPlayerVehicleID(userid))) == -1)
		    return SendClientMessage(playerid, COLOR_GRAD1, "Player is not inside a vehicle.");

      	if(!strcmp(confirm, "yes", true) && strlen(confirm))
		{
			if(CarData[carid][carComps] < 10) return SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have enough components.");

			SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Offer Sent");

			pToAccept[userid] = playerid;
			tToAccept[userid] = OFFER_TYPE_SERVICE;

			SetPVarInt(playerid, "color1", color1);
			SetPVarInt(playerid, "color2", color2);

			serviceComp[playerid] = 10;
			serviceTowtruck[playerid] = carid;
			serviceCustomer[playerid] = pcarid;
			serviceFocus[playerid] = 0;
			serviced[playerid] = 5;

			format(sgstr, sizeof(sgstr), "%s has offered to ~y~repaint the bodywork ~w~of your %s~n~~p~press ~g~Y~p~ to accept or ~r~N ~p~to deny.", ReturnName(pToAccept[userid], 0), g_arrVehicleNames[CarData[pcarid][carModel] - 400]);
			ShowPlayerFooter(userid, sgstr, -1);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "This service requires 10 components, you must have all.");
			SendSyntaxMessage(playerid, "/paintcar %d %d yes", color1, color2);
		}
    }
    else SendServerMessage(playerid, "This command is only available for private vehicles, but you are in a public vehicle (Static)");

	return true;
}

CMD:service(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_MECHANIC && PlayerData[playerid][pSideJob] != JOB_MECHANIC)
	    return SendClientMessage(playerid, COLOR_GRAD2, "You're not a Car Mechanic");

	new
		userid, type, confirm[16], carid, pcarid;

    if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "You are not in a Towtruck.");

    if((carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	{
        if(CarData[carid][carModel] != 525)
			return SendClientMessage(playerid, COLOR_GRAD1, "You are not in a Towtruck.");

		if(sscanf(params, "udS()[16]", userid, type, confirm))
		{
			SendClientMessage(playerid, COLOR_GRAD1, "/service [id/nome] [service]");
			SendClientMessage(playerid, COLOR_GRAD1, "Service 1:{FFFFFF} Service the vehicle health.");
			SendClientMessage(playerid, COLOR_GRAD1, "Type 2:{FFFFFF} Service the bodywork(( Visual damage ))");
			SendClientMessage(playerid, COLOR_GRAD1, "Type 3:{FFFFFF} Jump the battery.");
			SendClientMessage(playerid, COLOR_GRAD1, "Type 4:{FFFFFF} Tune-up the engine.");
			return true;
		}

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "s[24]{dS()[16]}", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
			}
		}

		if(userid == playerid)
			return SendClientMessage(playerid, COLOR_GRAD1, "You cannot offer services to yourself.");

		if(tToAccept[userid] != OFFER_TYPE_NONE)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "The player already has another offer.");

		if(!IsPlayerNearPlayer(playerid, userid, 10.0))
		   return SendClientMessage(playerid, COLOR_GRAD1, "That player is not near you.");

		if((pcarid = Car_GetID(GetPlayerVehicleID(userid))) == -1)
		    return SendClientMessage(playerid, COLOR_GRAD1, "Player is not inside a vehicle.");

		if(type >= 1 && type <= 4)
		{
			new comp = 0, service_name[64], model = CarData[pcarid][carModel];

			switch(type)
			{
			 	case 1:
				{
			 	    new Float:maxhealth = GetVehicleDataHealth(model);
			 		comp = floatround(((maxhealth - CoreVehicles[CarData[pcarid][carVehicle]][vehCrash]) / 50.0 ) * 2, floatround_round);
					format(service_name, sizeof(service_name), "replenish the health");
				}
				case 2:
				{
				    comp = 0;
                    GetVehicleDamageStatus(CarData[pcarid][carVehicle],CarData[pcarid][carDamage][0],CarData[pcarid][carDamage][1],CarData[pcarid][carDamage][2],CarData[pcarid][carDamage][3]);
					for(new i = 0; i != 4; ++i) if(CarData[pcarid][carDamage][i] != 0) comp += 10;
					format(service_name, sizeof(service_name), "repaint the bodywork");
				}
				case 3:
				{
					new Float:max_battery = VehicleData[model - 400][c_battery]; // 341200 use Component 24371

					comp = floatround(VehicleData[model - 400][c_price] / 2.50) + floatround(max_battery * 12.0);

					format(service_name, sizeof(service_name), "replace the battery");
				}
				case 4:
				{
				    new Float:max_engine = VehicleData[model - 400][c_engine]; //486914

					comp = floatround(VehicleData[model - 400][c_price] / 1.75) + floatround(max_engine * 12.0);

					format(service_name, sizeof(service_name), "replace the engine");
				}
			}

			if(!comp) return SendClientMessage(playerid, COLOR_LIGHTRED, "Service is not available for this vehicle.");

      		if(!strcmp(confirm, "yes", true) && strlen(confirm))
		    {
		        if(CarData[carid][carComps] < comp) return SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have enough components.");

				SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Offer Sent");

				pToAccept[userid] = playerid;
				tToAccept[userid] = OFFER_TYPE_SERVICE;

				serviceComp[playerid] = comp;
				serviceTowtruck[playerid] = carid;
				serviceCustomer[playerid] = pcarid;
				serviceFocus[playerid] = 0;
				serviced[playerid] = type;

				format(sgstr, sizeof(sgstr), "~w~%s has offered to %s of your %s.~n~~p~press ~g~Y~p~ to accept or ~r~N ~p~to deny.", ReturnName(pToAccept[userid], 0), service_name, g_arrVehicleNames[CarData[pcarid][carModel] - 400]);
			 	ShowPlayerFooter(userid, sgstr, -1);
		    }
			else
			{
				SendClientMessageEx(playerid, COLOR_YELLOW, "This service requires %d components, you need to have all.", comp);
				SendSyntaxMessage(playerid, "/service [id/nome] %d yes", type);
			}
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Available services are 1-4 only.");
    }
    else SendServerMessage(playerid, "This order is only available for private vehicles, you are in a public vehicle. (Static)");


	return true;
}

CMD:checkcomponents(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_MECHANIC && PlayerData[playerid][pSideJob] != JOB_MECHANIC)
	    return SendClientMessage(playerid, COLOR_GRAD2, "You are not a Car Mechanic");

	new slot = -1, vehicleid = GetPlayerVehicleID(playerid);

	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a Towtruck.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o motorista.");

    if((slot = Car_GetID(vehicleid)) != -1)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Components: %d", CarData[slot][carComps]);
	}
	else SendServerMessage(playerid, "This order is only available for private vehicles, you are in a public vehicle. (Static)");

	return true;
}

CMD:colorlist(playerid, params[])
{
	new id = -1;

	if((PlayerData[playerid][pJob] == JOB_MECHANIC || PlayerData[playerid][pSideJob] == JOB_MECHANIC) || ((id = Business_Nearest(playerid)) != -1 && BusinessData[id][bType] == 4))
	{
	    new
			string[3344];

	    string = "";

		for(new i = 0; i < 256; ++i)
		{
		    if(i > 0 && (i % 16) == 0)
		    {
		        format(string, sizeof(string), "%s\n{%06x}#%03d ", string, g_arrSelectColors[i] >>> 8, i);
			}
		    else
			{
				format(string, sizeof(string), "%s{%06x}#%03d ", string, g_arrSelectColors[i] >>> 8, i);
			}
		}
		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "List of Color ID's:", string, "Close", "");
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "Você não está em uma concessionária.");


	return true;
}

CMD:attach(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleModel(vehicleid) != 525)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a Towtruck.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o motorista.");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/attach [playerID]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_GRAD1, "You cannot use it on yourself.");

	if(GetPlayerState(userid) != PLAYER_STATE_PASSENGER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "Player is not in the passenger seat.");

	new attachvid = GetPlayerVehicleID(userid);

	if(attachvid == vehicleid || !IsDoorVehicle(attachvid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't attach this vehicle.");

	AttachTrailerToVehicle(attachvid, vehicleid);
	return true;
}

CMD:detach(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsPlayerInAnyVehicle(playerid) || GetVehicleModel(vehicleid) != 525)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a Towtruck.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o motorista.");

	new trailerid = GetVehicleTrailer(vehicleid);

    if(!trailerid) return SendClientMessage(playerid, COLOR_GRAD1, "There's nothing to detach.");

	DetachTrailerFromVehicle(vehicleid);
	return true;
}

CMD:leavesidejob(playerid, params[])
{
	if(PlayerData[playerid][pSideJob] != 0)
	{
		if(PlayerData[playerid][pSideJob] == JOB_TAXI)
		{
			if(TaxiDuty{playerid})
			{
				TaxiDuty{playerid} = false;
				TaxiMade[playerid] = 0;

				SetPlayerToTeamColor(playerid);
			}
		}

	    PlayerData[playerid][pSideJob] = 0;

	    return SendClientMessage(playerid, COLOR_GRAD1, "You have left your sidejob.");
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have a sidejob.");
}

CMD:leavejob(playerid, params[])
{
	if(PlayerData[playerid][pJob])
	{
		if(PlayerData[playerid][pJob] != JOB_MECHANIC && PlayerData[playerid][pJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_GUIDE)
		{
			if(PlayerData[playerid][pDonateRank])
			{
				if(PlayerData[playerid][pContractTime])
				{
					PlayerData[playerid][pJob] = 0;
					PlayerData[playerid][pContractTime] = 0;

					return SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You have fulfilled the contract for one hour and left the job.");
				}
				else return SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You still have 1 hour left to fulfill and terminate your contract.");
			}
			else
			{
				if(PlayerData[playerid][pContractTime] >= 5)
				{
					PlayerData[playerid][pJob] = 0;
					PlayerData[playerid][pContractTime] = 0;

					return SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You have fulfilled the contract for 5 hours and left the job.");
				}
				else
				{
					return SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You still have %d hours left to fulfill and terminate your contract.", 5 - PlayerData[playerid][pContractTime]);
				}
			}
		}
		else
		{
		    if(PlayerData[playerid][pJob] == JOB_TAXI)
		    {
				if(TaxiDuty{playerid})
				{
					TaxiDuty{playerid} = false;
					TaxiMade[playerid] = 0;

					SetPlayerToTeamColor(playerid);
				}
		    }

			PlayerData[playerid][pJob] = 0;

			return SendClientMessage(playerid, COLOR_LIGHTBLUE, "You have left your job.");
		}
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have a job.");
}

CMD:jobswitch(playerid, params[])
{
    if(IsJobSide(PlayerData[playerid][pJob]))
	{
        if(PlayerData[playerid][pJob] != JOB_NONE || PlayerData[playerid][pSideJob] != JOB_NONE)
        {
            new sidejob = PlayerData[playerid][pSideJob];

            PlayerData[playerid][pSideJob] = PlayerData[playerid][pJob];
            PlayerData[playerid][pJob] = sidejob;

            if(PlayerData[playerid][pSideJob] == JOB_NONE)
				SendClientMessage(playerid, COLOR_LIGHTRED, "Your side job was set as your main job.");
			else if(PlayerData[playerid][pJob] == JOB_NONE)
				SendClientMessage(playerid, COLOR_LIGHTRED, "Your main job was set as your side job.");
		}
        else
        {
            SendClientMessage(playerid, COLOR_LIGHTRED, "You have to leave the job first (/leavejob or /leavesidejob)");
        }
    }
    else SendClientMessage(playerid, COLOR_LIGHTRED, "You can only switch jobs as Taxi Driver or Car Mechanic.");

	return true;
}

CMD:mechanicjob(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 88.4620,-165.0116,2.5938))
	{
		if(PlayerData[playerid][pJob] == JOB_NONE)
		{
	        PlayerData[playerid][pJob] = JOB_MECHANIC;

	        ShowPlayerFooter(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Car Mechanic.~n~~w~/jobhelp.", 8000);

			if(PlayerData[playerid][pSideJob] == JOB_NONE) SendClientMessage(playerid, COLOR_GRAD6, "/jobswitch to make it a sidejob.");
		}
		else
		{
		    if(PlayerData[playerid][pSideJob] == JOB_NONE)
		    {
		        PlayerData[playerid][pSideJob] = JOB_MECHANIC;

		        ShowPlayerFooter(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Car Mechanic.~n~~w~/jobhelp.", 8000);
		    }
		    else
		    {
		        SendClientMessage(playerid, COLOR_LIGHTRED, "    You already have a job and a side-job. Type /leavejob and or /leavesidejob to leave them.");
		    }
		}
		return true;
	}
	else return SendClientMessage(playerid, COLOR_GRAD1, "You are not at the job site.");
}

CMD:farmerjob(playerid, params[])
{
	if(PlayerData[playerid][pLevel] > 3)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "This job is for level 3+ only.");

	if(GetFactionType(playerid) != 0)
	    return SendClientMessage(playerid, COLOR_WHITE, "Only civilians can have this job");

	if(IsPlayerInRangeOfPoint(playerid, 3.0, -382.5893,-1426.3422,26.2217))
	{
	    if(PlayerData[playerid][pJob] != 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "   You already have a job. Type /leavejob to leave.");

        PlayerData[playerid][pJob] = JOB_FARMER;

        ShowPlayerFooter(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Farmer.~n~~w~/jobhelp.", 8000);

        SendClientMessage(playerid, COLOR_WHITE, "You're now a Farmer.");
		return true;
	}
	else return SendClientMessage(playerid, COLOR_GRAD1, "You are not at the job site.");
}

/*CMD:dealerjob(playerid, params[])
{
	if(PlayerData[playerid][pJob] != 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "   You already have a job. Type /leavejob to leave.");

	if(GetFactionType(playerid) != 0)
	    return SendClientMessage(playerid, COLOR_WHITE, "Only civilians can have this job");

	if(IsAtBlackMarket(playerid))
	{
        PlayerData[playerid][pJob] = JOB_WPDEALER;

        ShowPlayerFooter(playerid, "~r~Congratulations,~n~~w~You are now a ~y~WEAPONS DEALER.~n~~w~/jobhelp.", 8000);
		return true;
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD1, "You are not on the dark side.");
	}
	return true;
}

CMD:supplierjob(playerid, params[])
{
	if(PlayerData[playerid][pJob] != 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "   You already have a job. Type /leavejob to leave.");

	if(GetFactionType(playerid) != 0 && GetFactionType(playerid) == FACTION_GANG)
	{
		if(IsAtBlackMarket(playerid))
		{
	        PlayerData[playerid][pJob] = JOB_SUPPLIER;

	        ShowPlayerFooter(playerid, "~r~Congratulations,~n~~w~You are now a ~y~WEAPONS SUPPLIER.~n~~w~/jobhelp.", 8000);
			return true;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD1, "You are not on the dark side.");
		}
	}
	else SendClientMessage(playerid, COLOR_WHITE, "This job is for gang members or official organizations only.");
	return true;
}*/

CMD:truckerjob(playerid, params[])
{
	if(PlayerData[playerid][pJob] != 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "   You already have a job. Type /leavejob to leave.");

	if(GetFactionType(playerid) != 0)
	    return SendClientMessage(playerid, COLOR_WHITE, "Only civilians can have this job");

	if(IsPlayerInRangeOfPoint(playerid, 3.0, -78.0338,-1136.1221,1.0781))
	{
        PlayerData[playerid][pJob] = JOB_TRUCKER;

        SendClientMessageEx(playerid, COLOR_WHITE, "You're now a %s.", ReturnJobName(playerid, JOB_TRUCKER));
		return true;
	}
	else
	{
	    SetPlayerRaceCheckpointEx(playerid, 2, RCHECKPOINT_TRUCKERJOB, -78.0338,-1136.1221,1.0781);

		SendClientMessage(playerid, COLOR_GREEN, "Trucker job location has been marked on map");
	}
	return true;
}

CMD:harvest(playerid, params[])
{
	if(PlayerData[playerid][pJob] != JOB_FARMER)
	    return SendClientMessage(playerid, COLOR_GRAD2, "City boys can not do that!");

	if(PlayerData[playerid][pLevel] > 3)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "This is for Level 1-3 only!!");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(GetVehicleModel(vehicleid) != 532)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not sitting on Combine Harvester");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	 	return SendClientMessage(playerid, COLOR_LIGHTRED, "You do not sit at the driver's seat of the vehicle.");

	if(IsPlayerInRangeOfPoint(playerid, 100.0, -377.8374,-1433.8853,25.7266))
	{
		if(far_start[playerid])
			return SendClientMessage(playerid, COLOR_GRAD1, "   You have already begun to harvest.");

		far_place[playerid] = 0;
		far_start[playerid] = 1;
		far_veh[playerid] = vehicleid;

		SendClientMessage(playerid, COLOR_WHITE, "You have started to harvest the farmer.");

		StartHarvesting(playerid);
        return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 100.0, -53.5525,70.3079,4.0933))
	{
		if(far_start[playerid])
			return SendClientMessage(playerid, COLOR_GRAD1, "   You have already begun to harvest.");

		far_place[playerid] = 1;
		far_start[playerid] = 1;
		far_veh[playerid] = vehicleid;

		SendClientMessage(playerid, COLOR_WHITE, "You have started to harvest the farmer.");

		StartHarvesting(playerid);
        return 1;
	}
	else return SendClientMessage(playerid, COLOR_GRAD1, "You are not at the farm");
}

CMD:stopharvest(playerid, params[])
{
	if(far_start[playerid])
	{
		gPlayerCheckpointX[playerid] = 0.0;
		gPlayerCheckpointY[playerid] = 0.0;
		gPlayerCheckpointZ[playerid] = 0.0;

		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;

		far_start[playerid] = 0; far_veh[playerid]=INVALID_VEHICLE_ID;

		return SendClientMessage(playerid, COLOR_WHITE, "You have stopped harvesting farm produce.");
	}
	else return SendClientMessage(playerid, COLOR_GRAD1, "   You have not started harvesting yet.");
}
// Libery Harvest
stock StartHarvesting(playerid)
{
    new rand;
	if(far_place[playerid])
	{
		rand = random(sizeof(BlueFarm));
		SetPlayerCheckpointEx(playerid, BlueFarm[rand][0],BlueFarm[rand][1],BlueFarm[rand][2], 5.0, CHECKPOINT_FARMER, rand);
	}
	else
	{
		rand = random(sizeof(FlintFarm));
		SetPlayerCheckpointEx(playerid, FlintFarm[rand][0],FlintFarm[rand][1],FlintFarm[rand][2], 5.0, CHECKPOINT_FARMER, rand);
	}
	return true;
}

YCMD:rw(playerid, params[], help) = rollwindow;

CMD:rollwindow(playerid,params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GRAD2, "You must be in a vehicle to use this.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsDoorVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_GRAD2, "This vehicle has no windows.");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "You cannot perform this action right now.");	

	new item[32];

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

	  	if(sscanf(params, "s[32]", item))
 		{
	  	    SendNoticeMessage(playerid, "TIP: As a driver, you can specify which window to open:");
			SendSyntaxMessage(playerid, "/rollwindow [all/frontleft(fl)/frontright(fr)/rearleft(rl)/rearright(rr)]");

   			if(wdriver == VEHICLE_PARAMS_OFF)
		    {
				format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, 1, wpassenger, wbackleft, wbackright);
			}
			else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, 0, wpassenger, wbackleft, wbackright);
			}
		}
		else
		{
			if(strcmp(item, "all", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
					format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, 0, 0, 0, 0);
				}
			}
			if(strcmp(item, "frontleft", true) == 0 || strcmp(item, "fl", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, 1, wpassenger, wbackleft, wbackright);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
					format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, 0, wpassenger, wbackleft, wbackright);
				}
			}
			if(strcmp(item, "frontright", true) == 0 || strcmp(item, "fr", true) == 0)
			{
			    if(wpassenger == VEHICLE_PARAMS_OFF)
			    {
					format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
				}
				else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
				{
					format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
				}
			}
			if(strcmp(item, "rearleft", true) == 0 || strcmp(item, "rl", true) == 0)
			{
	      		if(wbackleft == VEHICLE_PARAMS_OFF)
			    {
					format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
				}
				else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
				{
					format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
				}
			}
			if(strcmp(item, "rearright", true) == 0 || strcmp(item, "rr", true) == 0)
			{
			    if(wbackright == VEHICLE_PARAMS_OFF)
			    {
					format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
				}
				else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
				{
					format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
				}
			}
		}
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		new iSeat = GetPlayerVehicleSeat(playerid);

		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

		if(iSeat == 128)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid seat number.");

		if(iSeat == 1)
		{
			if(wpassenger == VEHICLE_PARAMS_OFF)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
			}
			else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
			}
		}
		else if(iSeat == 2)
		{
			if(wbackleft == VEHICLE_PARAMS_OFF)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
			}
			else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
			}
		}
		else if(iSeat == 3)
		{
			if(wbackright == VEHICLE_PARAMS_OFF)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window up.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
				format(sgstr, sizeof(sgstr), "> %s rolls their window down.", ReturnName(playerid, 0));
				SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 3000), SendClientMessage(playerid, COLOR_PURPLE, sgstr);

				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
			}
		}
	}
	return true;
}

//Fishing Job

CMD:irpescar(playerid, params[])
{
	new fishplace = strval(params);

	if(isnull(params) && (fishplace != 1 && fishplace != 2))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: {FFFFFF}/irpescar [1(no alto mato)/2(em terra)]");

	if(PlayerData[playerid][pFishes])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode pescar se tiver peixe com você.");

	if(FishingPlace[playerid] != -1 || gPlayerCheckpointStatus[playerid] != CHECKPOINT_NONE)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você já tem um checkpoint/missão");

	if(fishplace == 1)
	{
		if(!CanFishOnBoat(playerid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você tem que estar perto/dentro do seu barco.");

		if(PlayerData[playerid][pFishes] > 1000)
		{
			SendClientMessage(playerid, COLOR_GREEN, "Você já tem peixes o suficiente.");
			SendClientMessage(playerid, COLOR_GREEN, "/descarregarpeixe se você quer vender seus peixes");
		}

		new rand = random(sizeof(GoFishingPlace));
		SetPlayerCheckpointEx(playerid, GoFishingPlace[rand][0], GoFishingPlace[rand][1], GoFishingPlace[rand][2], 30.0, CHECKPOINT_GOFISHING, rand);

	    SendClientMessage(playerid, COLOR_GREEN, "Vá até o local de pesca no oceano e comece a pescar (/pescar)");
	}
	else
	{
	    if(PlayerData[playerid][pFishes] > 1000)
		{
	        SendClientMessage(playerid, COLOR_GREEN, "Você já tem peixes o suficiente.");
	        SendClientMessage(playerid, COLOR_GREEN, "/descarregarpeixe se você quer vender seus peixes");
	    }

		if(!IsPlayerInRangeOfPoint(playerid, 30.0, 383.6021, -2061.7881, 7.6140))
		{
			SetPlayerCheckpointEx(playerid, 383.6021,-2061.7881,7.6140, 30.0, CHECKPOINT_GOFISHING, 3);

            SendClientMessage(playerid, COLOR_GREEN, "Vá até o local de pesca e comece a pescar (/pescar)");
		}
		else
		{
			FishingPlace[playerid] = 3;

			SendClientMessage(playerid, COLOR_WHITE, "Comece a pescar aqui (/pescar), quando você terminar /pararpesca e /descarregarpeixe");
		}
	}

	return true;
}

CanFishOnBoat(playerid)
{
	new carid = -1, vehicleid = GetPlayerVehicleID(playerid);

	if((carid = Car_GetID(vehicleid)) != -1)
	{
		if(IsABoatModel(CarData[carid][carModel]) && CarData[carid][carOwner] == PlayerData[playerid][pID])
		{
			return true;
		}
	}
	else if((carid = Car_GetID(IsNearBoatID(playerid))) != -1)
	{
		if(CarData[carid][carOwner] == PlayerData[playerid][pID])
		{
			return true;
		}
	}	

	return false;
}

CMD:pescar(playerid, params[])
{
	if(FishingPlace[playerid] == -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está pescando (/irpescar).");

	if(FishingPlace[playerid] == 3)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 30.0, 383.6021, -2061.7881, 7.6140))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode pescar aqui.");
	}	
	else
	{
		new fishplace = FishingPlace[playerid];

		if(!IsPlayerInRangeOfPoint(playerid, 30.0, GoFishingPlace[fishplace][0], GoFishingPlace[fishplace][1], GoFishingPlace[fishplace][2]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode pescar aqui.");

		if(!CanFishOnBoat(playerid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você tem que estar perto/dentro do seu barco.");
	}

	if((gettime() - FishCooldown[playerid]) < 6)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Nenhum peixe por perto ainda");
		SendClientMessage(playerid, COLOR_WHITE, "((Por favor, aguarde 6 segundos entre cada /pescar))");
		return true;		
	}

	new Fishcaught, Fishlbs;

	if(random(7) < 5)
	{
		Fishcaught = random(5);

		if(FishingPlace[playerid] == 3)
		{
			Fishlbs = ((Fishcaught + 1) * 10) + (1 + random(10));
		}
		else
		{
			Fishlbs = ((Fishcaught + 1) * 20) + (1 + random(10));
		}

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "%s puxa a linha da vara para trás e vê que consegue pegar um %s.", ReturnName(playerid, 0), FishNames[Fishcaught]);

		SendClientMessageEx(playerid, COLOR_GREEN, "Pescou um %s Lbs: %d", FishNames[Fishcaught], Fishlbs);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "Você não pegou nada.");
		return true;
	}

	PlayerData[playerid][pFishes] += Fishlbs;

	if(PlayerData[playerid][pFishes] > 1000 && FishingPlace[playerid] == 3) // on-foot
	{
		FishingPlace[playerid] = -1;

		SendClientMessage(playerid, COLOR_GREEN, "Você já tem peixes o suficiente.");
		SendClientMessage(playerid, COLOR_GREEN, "/descarregarpeixe se você quer vender seus peixes");
		return true;
	}
	else if(PlayerData[playerid][pFishes] > 5000 && FishingPlace[playerid] < 3) // on-boat
	{
		FishingPlace[playerid] = -1;

		SendClientMessage(playerid, COLOR_GREEN, "Você já tem peixes o suficiente.");
		SendClientMessage(playerid, COLOR_GREEN, "/descarregarpeixe se você quer vender seus peixes");
		return true;
	}

	if(FishingPlace[playerid] < 3)
	{
		FishingBoat[playerid] += Fishlbs;

		if(FishingBoat[playerid] > 1000)
		{
			new rand = random(sizeof(GoFishingPlace));
			SetPlayerCheckpointEx(playerid, GoFishingPlace[rand][0], GoFishingPlace[rand][1], GoFishingPlace[rand][2], 30.0, CHECKPOINT_GOFISHING, rand);

	        FishingBoat[playerid] = 0;
	        FishingPlace[playerid] = -1;

	        SendClientMessage(playerid, COLOR_GREEN, "Vá pescar em outro lugar");
		}
	}

   	FishCooldown[playerid] = gettime();
	return true;
}

CMD:pararpesca(playerid, params[])
{
	if(FishingPlace[playerid] != -1)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "Você parou de pescar.");

	    if(PlayerData[playerid][pFishes]) SendClientMessage(playerid, COLOR_GREEN, "/descarregarpeixe se você quer vender seus peixes");

	    FishingPlace[playerid] = -1;
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Você não está pescando.");

	return true;
}

CMD:descarregarpeixes(playerid, params[])
{
    if(FishingPlace[playerid] != -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Pare de pescar primeiro /pararpesca");

	if(!PlayerData[playerid][pFishes])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem nenhum peixe.");

 	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2475.2932, -2710.7759, 3.1963))
	{
		new str[128], earn = PlayerData[playerid][pFishes], rand = PlayerData[playerid][pFishes] / 2;

		if(rand)
		{
			earn += random(rand);
		}

		SendPlayerMoney(playerid, earn);

		format(str, sizeof(str), "~p~PESO DOS PEIXES VENDIDOS~n~~w~%d POR %d", PlayerData[playerid][pFishes], earn);
		GameTextForPlayer(playerid, str, 8000, 4);

		PlayerData[playerid][pFishes] = 0;

		SendClientMessage(playerid, COLOR_GREEN, "Você descarregou os peixes e parou de pescar");
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREEN, "Um local para descarregar peixes e obter dinheiro por eles está marcado no mapa");

	    SetPlayerCheckpointEx(playerid, 2475.2932, -2710.7759, 3.1963, 2.0, CHECKPOINT_UNLOADFISHING);
	}
	return true;
}

CMD:meuspeixes(playerid, params[])
{
	if(PlayerData[playerid][pFishes])
	{
	    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	    SendClientMessageEx(playerid, COLOR_GREEN, "Peso dos peixes [%d] Lbs", PlayerData[playerid][pFishes]);
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem nenhum peixe.");

	return true;
}

CMD:alugarveiculo(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você precisa estar no banco do motorista de um veículo.");

	new vehicleid = GetPlayerVehicleID(playerid);

    if(!IsVehicleRental(vehicleid))
        return SendServerMessage(playerid, "Este comando só pode ser usado para os seus veículos. Você está em um veículo público (estático)..");

	if(RentCarKey[playerid] != 0)
	    return SendErrorMessage(playerid, "Você já está alugando um veículo. Use /desalugarveiculo para parar.");

	if(IsVehicleRented(vehicleid))
	    return SendErrorMessage(playerid, "Este veículo já foi alugado por outra pessoa.");

	new cost = GetVehicleRentalPrice(GetVehicleModel(vehicleid)), str[256];

	format(str, sizeof(str), "{A9C4E4}Tem certeza de que deseja alugar este(a) {7e98b6}%s{A9C4E4}?\n\n{A9C4E4}Vai custar {7e98b6}%s.", ReturnVehicleName(vehicleid), FormatNumber(cost));
	ConfirmDialog(playerid, "Confirmation", str, "OnPlayerRentVehicle");
	return true;
}

FUNX::OnPlayerRentVehicle(playerid, response)
{
	if(!response) return true;

	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você precisa estar no banco do motorista de um veículo.");

	new vehicleid = GetPlayerVehicleID(playerid);

    if(!IsVehicleRental(vehicleid))
        return SendServerMessage(playerid, "Este comando só pode ser usado para os seus veículos. Você está em um veículo público (estático)..");

	if(RentCarKey[playerid] != 0)
	    return SendErrorMessage(playerid, "Você já está alugando um veículo. Use /desalugarveiculo parar.");

	if(IsVehicleRented(vehicleid))
	    return SendErrorMessage(playerid, "Este veículo já foi alugado por outra pessoa.");

	new cost = GetVehicleRentalPrice(GetVehicleModel(vehicleid));

	if(PlayerData[playerid][pCash] < cost)
		return SendErrorMessage(playerid, "Você não tem dinheiro suficiente para alugar este veículo.");

    TakePlayerMoney(playerid, cost);

	RentCarKey[playerid] = vehicleid;

	SendClientMessage(playerid, COLOR_GRAD1, "Empresa de Aluguel");
	SendClientMessage(playerid, COLOR_GRAD2, "-------------------");
	SendClientMessageEx(playerid, COLOR_GREY, " Agora você está alugando este(a) %s por %s.", ReturnVehicleName(vehicleid), FormatNumber(cost));
	SendClientMessage(playerid, COLOR_GREY, " Para devolvê-lo, você pode usar o comando \"/desalugarveiculo\".");
	SendClientMessage(playerid, COLOR_GREY, " Você pode trancar o veículo usando /trancar e ligar o motor com /motor.");
	SendClientMessage(playerid, COLOR_GRAD2, "-------------------");
	SendClientMessage(playerid, COLOR_GRAD3, "Se você sair do servidor, você manterá o acesso por apenas 5 minutos.");
	return true;
}

CMD:desalugarveiculo(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if(!RentCarKey[playerid] || vehicleid != RentCarKey[playerid])
	    return SendErrorMessage(playerid, "Você não está alugando um veículo.");

    SendClientMessageEx(playerid, COLOR_RADIO, "Você parou de alugar o(a) %s.", ReturnVehicleName(vehicleid));

    RentCarKey[playerid] = 0;
 	SetVehicleToRespawn(vehicleid);
    return true;
}

CMD:bizwithdraw(playerid, params[])
{
	new
		bouse = PlayerData[playerid][pPbiskey],
		cashdeposit;

	if(bouse == -1)
		return SendClientMessage(playerid, COLOR_GRAD2, "You are not the owner of the business.");

	if(sscanf(params, "d", cashdeposit))
	{
		SendSyntaxMessage(playerid, "/bizwithdraw [amount]");
		SendClientMessageEx(playerid, COLOR_GRAD3, "  You have $%d in you Cashbox", BusinessData[bouse][bTill]);
		return true;
	}

	if(cashdeposit > BusinessData[bouse][bTill] || cashdeposit < 1)
		return SendClientMessage(playerid, COLOR_GRAD2, "   You don't have that much money.");

	if(bouse == InBusiness[playerid])
	{
		TakePlayerMoney(playerid, cashdeposit);

		BusinessData[bouse][bTill] -= cashdeposit;

		SendClientMessageEx(playerid, COLOR_YELLOW, "  You withdrawed $%d from the cashbox, now you have: $%d", cashdeposit,BusinessData[bouse][bTill]);

		Business_Save(bouse);
	}
	else SendClientMessage(playerid, COLOR_GRAD2, "You must be in your business.");

	return true;
}

CMD:bizbank(playerid, params[])
{
	new bouse = PlayerData[playerid][pPbiskey], cashdeposit;

	if(bouse == -1)
		return SendClientMessage(playerid, COLOR_GRAD2, "You are not the owner of the business.");

	if(sscanf(params, "d", cashdeposit))
	{
	    SendClientMessageEx(playerid, COLOR_GRAD3, " You Have $40,500 in your till.", BusinessData[bouse][bTill]);
		SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /bizbank [amount]");
		return true;
	}

	if(cashdeposit > PlayerData[playerid][pCash] || cashdeposit < 1)
		return SendClientMessage(playerid, COLOR_GRAD2, "   You don't have that much money.");

	if(bouse == InBusiness[playerid])
	{
		TakePlayerMoney(playerid, cashdeposit);

		BusinessData[bouse][bTill] += cashdeposit;

		SendClientMessageEx(playerid, COLOR_YELLOW, "  You deposited $%d into your cashbox. Remaining: $%d", cashdeposit, BusinessData[bouse][bTill]);

		Business_Save(bouse);
	}
	else SendClientMessage(playerid, COLOR_GRAD2, "You must be in your business.");

	return true;
}

CMD:buybiz(playerid, params[])
{
	if(OwnBusiness(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "You already own a business, /sellbiz to sell your business.");

	new h = -1;

	if((h = Business_Nearest(playerid)) != -1)
	{
		if(BusinessData[h][bOwned])
		    return SendErrorMessage(playerid, "This business isn't for sale.");

		if(PlayerData[playerid][pLevel] < BusinessData[h][bLevelNeeded])
			return SendErrorMessage(playerid, "You need to be at least Level %d to buy this.", BusinessData[h][bLevelNeeded]);

		if(PlayerData[playerid][pCash] < BusinessData[h][bBuyPrice])
			return SendErrorMessage(playerid, "You cannot purchase this business.");

        TakePlayerMoney(playerid, BusinessData[h][bBuyPrice]);

		PlayerData[playerid][pPbiskey] = h;

		BusinessData[h][bOwned] = 1;
		BusinessData[h][bLocked] = 1;
		BusinessData[h][bTill] = 0;

		format(BusinessData[h][bOwner], MAX_PLAYER_NAME, ReturnName(playerid));

		SendClientMessageEx(playerid, COLOR_GREEN, "Congratulations! You paid %s and now own the business!", FormatNumber(BusinessData[h][bBuyPrice]));
		SendClientMessageEx(playerid, COLOR_WHITE, "Address: %s, San Andreas", ReturnLocationEx(playerid));

		Business_Refresh(h);

		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d', `PlayerBusinessKey` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], h, PlayerData[playerid][pID]);
		mysql_pquery(dbCon, gquery);

		Business_Save(h);
		return true;
 	}
	return true;
}

CMD:sellbiz(playerid, params[])
{
	new confirm[8], house = PlayerData[playerid][pPbiskey];

	if(house != -1 && strcmp(ReturnName(playerid), BusinessData[house][bOwner], true) == 0)
	{
		new houseprice = BusinessData[house][bBuyPrice];
		new housetax = ((houseprice*1)/100);

	    if(!sscanf(params, "s[8]", confirm) && !strcmp(confirm, "yes", true))
		{
			if(BusinessData[house][bTill] > 0)
			{
			    SendPlayerMoney(playerid, BusinessData[house][bTill]);

				SendClientMessageEx(playerid, COLOR_GRAD2, "You received $%d from selling your business.", BusinessData[house][bTill]);
			}

			BusinessData[house][bLocked] = 1;
			BusinessData[house][bTill] = 0;
			BusinessData[house][bOwned] = 0;

			strmid(BusinessData[house][bOwner], "The State", 0, strlen("The State"), 24);

			Business_Refresh(house);

			SendPlayerMoney(playerid, houseprice - housetax);

			PlayerPlaySoundEx(playerid, 1052);

			format(sgstr, sizeof(sgstr), "~w~Congratulations~n~ You have sold your property for ~n~~g~$%d", houseprice-housetax);
			GameTextForPlayer(playerid, sgstr, 10000, 3);

			SendClientMessageEx(playerid, COLOR_GRAD3, "State tax: $%d", housetax);

			Business_Save(house);

			if(InBusiness[playerid] == house)
			{
				SetCameraBehindPlayer(playerid);

				SetPlayerDynamicPos(playerid, BusinessData[house][bEntranceX], BusinessData[house][bEntranceY], BusinessData[house][bEntranceZ]);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);

				DesyncPlayerInterior(playerid);
				return true;
			}

			PlayerData[playerid][pPbiskey] = -1;

			format(gquery, sizeof(gquery), "UPDATE `characters` SET `PlayerBusinessKey` = '-1' WHERE `PlayerBusinessKey` = %d", house);
			mysql_pquery(dbCon, gquery);

			format(gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = %d WHERE `ID` = %d", PlayerData[playerid][pCash], PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);
			return true;
		}
	 	else
	 	{
	 	    SendSyntaxMessage(playerid, "/sellbiz yes");

			SendClientMessageEx(playerid, COLOR_GREY, "Are you sure you want to sell your business for $%d and $%d tax?", houseprice, housetax);
	 	}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "You must be in your business.");

	return true;
}

CMD:sacar(playerid, params[])
{
	new cashdeposit, tax, bool:nearatm = false;

	for(new i = 0; i < MAX_ATM_LIMIT; ++i)
	{
	    if(ATMS[i][aID] == -1) continue;

	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ATMS[i][aPos][0], ATMS[i][aPos][1], ATMS[i][aPos][2]))
	    {
	        nearatm = true;
			break;
	    }
	}

	if(!nearatm)
	{
		new id = Business_Inside(playerid);

		if(id != -1)
		{
			if(BusinessData[id][bType] == 3 || BusinessData[id][bType] == 12)
			{
			    nearatm = true;
			}
		}
	}

	if(nearatm)
	{
		if(sscanf(params, "d", cashdeposit))
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /sacar [valor]");
			SendClientMessageEx(playerid, COLOR_GRAD3, " Você tem $%d em sua conta.", PlayerData[playerid][pAccount]);
			return true;
		}

		if(cashdeposit < 250)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você só pode sacar $250 ou mais");

	    if(PlayerData[playerid][pSavingsCollect])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar este comando ao abrir uma conta de savings.");

		if(cashdeposit > PlayerData[playerid][pAccount] || cashdeposit < 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, " Você não tem tanto assim");

		tax = floatround(cashdeposit * 0.002, floatround_round);

	    cashdeposit = cashdeposit - tax;

		SendPlayerMoney(playerid, cashdeposit);

		PlayerData[playerid][pAccount] -= cashdeposit + tax;

	 	SendClientMessageEx(playerid, COLOR_YELLOW, "  Você retirou $%d da sua conta: $%d taxa $%d", cashdeposit + tax, PlayerData[playerid][pAccount], tax);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Você não esta em um banco ou 24/7");

	return true;
}

CMD:depositar(playerid, params[])
{
    new cashdeposit, bool:nearatm = false;

	/*for(new i = 0; i < MAX_ATM_LIMIT; ++i)
	{
	    if(ATMS[i][aID] == -1) continue;

	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ATMS[i][aPos][0], ATMS[i][aPos][1], ATMS[i][aPos][2]))
	    {
	        nearatm = true;
			break;
	    }
	}

	if(!nearatm)
	{
		new id = Business_Inside(playerid);

		if(id != -1)
		{
			if(BusinessData[id][bType] == 3 || BusinessData[id][bType] == 12)
			{
			    nearatm = true;
			}
		}
	}*/

	new id = Business_Inside(playerid);

	if(id != -1)
	{
		if(BusinessData[id][bType] == 3 || BusinessData[id][bType] == 12)
		{
			nearatm = true;
		}
	}	

	if(nearatm)
	{
		if(sscanf(params, "d", cashdeposit))
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /depositar [valor]");
			SendClientMessageEx(playerid, COLOR_GRAD3, " Você tem $%d na sua conta.", PlayerData[playerid][pAccount]);
			return true;
		}

	    if(PlayerData[playerid][pSavingsCollect])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode usar este comando ao abrir uma conta de savings.");

		if(cashdeposit > PlayerData[playerid][pCash] || cashdeposit < 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, " Você não tem tanto assim");

		TakePlayerMoney(playerid, cashdeposit);

		new curfunds = PlayerData[playerid][pAccount];

		PlayerData[playerid][pAccount] = cashdeposit + PlayerData[playerid][pAccount];

		SendClientMessage(playerid, COLOR_WHITE, "|___ EXTRATO BANCÁRIO ___|");
		SendClientMessageEx(playerid, COLOR_GRAD2, " Saldo Antigo: $%d", curfunds);
		SendClientMessageEx(playerid, COLOR_GRAD4, " Depósito: $%d",cashdeposit);
		SendClientMessage(playerid, COLOR_GRAD6, "|-----------------------------------------|");
		SendClientMessageEx(playerid, COLOR_WHITE, " Novo Saldo: $%d", PlayerData[playerid][pAccount]);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "Você não está no banco!");

	return true;
}

CMD:saldo(playerid, params[])
{
	new bool:nearatm = false;

	for(new i = 0; i < MAX_ATM_LIMIT; ++i)
	{
	    if(ATMS[i][aID] == -1) continue;

	    if(IsPlayerInRangeOfPoint(playerid, 3.0, ATMS[i][aPos][0], ATMS[i][aPos][1], ATMS[i][aPos][2]))
	    {
	        nearatm = true;
			break;
	    }
	}

	if(!nearatm)
	{
		new id = Business_Inside(playerid);

		if(id != -1)
		{
			if(BusinessData[id][bType] == 3 || BusinessData[id][bType] == 12)
			{
			    nearatm = true;
			}
		}
	}

	if(nearatm)
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, " You Have $%d in your account.", PlayerData[playerid][pAccount]);
		SendClientMessageEx(playerid, COLOR_YELLOW, " Savings: $%d", PlayerData[playerid][pSavingsCollect]);
	}
	else SendClientMessage(playerid, COLOR_WHITE, "You are not in a bank or 24/7");

	return true;
}

CMD:savings(playerid, params[])
{
	new id = Business_Inside(playerid), bool:insidebank = false;

	if(id != -1)
	{
		if(BusinessData[id][bType] == 12)
		{
	 		insidebank = true;
		}
	}

	if(!insidebank)
	    return SendClientMessage(playerid, COLOR_GREY, "You are not in a bank.");

	if(!strcmp(params, "withdraw", true))
	{
		Dialog_Show(playerid, WithdrawSavings, DIALOG_STYLE_MSGBOX, "Confirmation", "Are you sure you want to withdraw money from your savings account?\nIt can not be reversed and you have to start over!", "Yes", "No");
	}
	else
	{
	    if(PlayerData[playerid][pSavings])
	    {
			new paycheck = 0, maximum = 20000000;
			new i = PlayerData[playerid][pSavings], currently;

			while(i < maximum)
			{
				i += floatround((i / 100.0) * (0.5), floatround_round);

				paycheck++;

				if(PlayerData[playerid][pSavingsCollect] > i) currently = 2 + paycheck;
			}

            SendNoticeMessage(playerid, "You have{FF6347} %s{FFFFFF} in your savings account", FormatNumber(PlayerData[playerid][pSavingsCollect]));
			SendNoticeMessage(playerid, "Your savings are active for %d/%d paydays (%d%s)", currently, paycheck, floatround(float(currently) / float(paycheck) * 100), "%%");
			SendSyntaxMessage(playerid, "To withdraw your savings, use{FF6347} /savings withdraw");
	    }
	    else
	    {
	        new savings = strval(params);

    		if(!savings)
		    	return SendClientMessage(playerid, COLOR_LIGHTRED, "USE:{FFFFFF} To create a savings account /savings [amount]");

			if(savings == 50000 || savings == 100000)
			{
				if(PlayerData[playerid][pCash] > savings)
				{
					PlayerData[playerid][pSavings] = savings;
					PlayerData[playerid][pSavingsCollect] = savings;

					TakePlayerMoney(playerid, savings);

					SendClientMessage(playerid, COLOR_WHITE, "|_______ BANK STATEMENT _______|");
					SendClientMessageEx(playerid, COLOR_GRAD1, "Savings account balance: %s", FormatNumber(savings));

					/*SendNoticeMessage(playerid, "You have %s in the savings account", FormatNumber(savings));

					new paycheck = 0, maximum = 20000000, i = PlayerData[playerid][pSavings], currently;

					while(i < maximum)
					{
						i += floatround((i / float(100)) * (0.5), floatround_round);

						paycheck++;

						if(PlayerData[playerid][pSavingsCollect] > i) currently = 2 + paycheck;
					}

					SendNoticeMessage(playerid, "Your savings are left. %d/%d paydays (%d%s)", currently, paycheck, floatround(currently / float(paycheck) * 100), "%%");
					SendClientMessage(playerid, COLOR_LIGHTRED, "USE: {FFFFFF} To withdraw your savings{FF6347}use /savings withdraw");*/
				}
				else SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente.");
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "Savings must be between $50,000 and $100,000.");
	    }
	}
	return true;
}

CMD:fuel(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não está em um veículo.");

	new str[64], vehicleid = GetPlayerVehicleID(playerid);

	if(!IsDoorVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "This vehicle has no oil.");

	format(str, sizeof(str), "~w~Fuel: ~p~%.2f gallon", CoreVehicles[vehicleid][vehFuel]);
	GameTextForPlayer(playerid, str, 5000, 1);
	return true;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach (new i : Player)
	{
		if(!IsPlayerInAnyVehicle(i)) continue;

		if(GetPlayerVehicleID(i) == vehicleid)
		{
		    return i;
		}
	}

	return INVALID_PLAYER_ID;
}

CMD:park(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

 	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "Você não é o motorista.");

	new vehicleid = GetPlayerVehicleID(playerid);

    if(!HasFactionRank(playerid, 1))
  		return SendErrorMessage(playerid, "No permission.");

	new id = -1;

	if((id = IsAFactionCar(vehicleid, factionid)) != -1)
	{
		GetVehiclePos(vehicleVariables[id][vVehicleScriptID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2]);
		GetVehicleZAngle(vehicleVariables[id][vVehicleScriptID], vehicleVariables[id][vVehicleRotation]);

		Vehicle_Save(id);

		DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);
		Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

		vehicleVariables[id][vVehicleScriptID] = CreateVehicle(vehicleVariables[id][vVehicleModelID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], 60000, vehicleVariables[id][vVehicleSiren]);

		Iter_Add(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

        PutPlayerInVehicle(playerid, vehicleVariables[id][vVehicleScriptID], 0);

		SendClientMessage(playerid, COLOR_GREEN, "Vehicle parked.");

        //SendFactionMessage(factionid, COLOR_FACTION, "", PlayerData[playerid][pFactionRank], ReturnName(playerid), vehicleid);
	}
	else SendErrorMessage(playerid, "You can only park vehicles belonging to your faction.");

	return true;
}

CMD:towcars(playerid, params[])
{
	new
	    id
	;

	if(sscanf(params, "d", id) || PlayerData[playerid][pAdmin] < 1)
	{
		new factionid = PlayerData[playerid][pFaction];

	 	if(factionid == -1)
		    return SendErrorMessage(playerid, "Você não está em uma facção.");

	    if(!HasFactionRank(playerid, 2))
	  		return SendErrorMessage(playerid, "Voc? n?o esta autorizado a utilizar este coomando.");

		foreach (new i : sv_servercar)
		{
		    if(!IsValidVehicle(vehicleVariables[i][vVehicleScriptID])) continue;

			if(vehicleVariables[i][vVehicleFaction] != -1 && vehicleVariables[i][vVehicleFaction] == factionid && GetVehicleDriver(vehicleVariables[i][vVehicleScriptID]) == INVALID_PLAYER_ID)
			{
		        SetVehicleToRespawn(vehicleVariables[i][vVehicleScriptID]);
			}
		}

		SendFactionMessage(factionid, COLOR_LIGHTRED, "<< %s has returned all faction vehicles to their parking places >>", ReturnName(playerid));
		return true;
	}

	if(id < 0 || id >= MAX_FACTIONS)
	    return SendErrorMessage(playerid, "Invalid faction ID specified.");

	if(!FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "This faction doesn't exist.");

	foreach (new i : sv_servercar)
	{
		if(!IsValidVehicle(vehicleVariables[i][vVehicleScriptID])) continue;

		if(vehicleVariables[i][vVehicleFaction] != -1 && vehicleVariables[i][vVehicleFaction] == id && GetVehicleDriver(vehicleVariables[i][vVehicleScriptID]) == INVALID_PLAYER_ID)
		{
			SetVehicleToRespawn(vehicleVariables[i][vVehicleScriptID]);
		}
	}

	if(PlayerData[playerid][pFaction] != id)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "<< Administrator %s has returned all faction vehicles to their parking places >>", ReturnName(playerid));
	}

	SendFactionMessage(id, COLOR_LIGHTRED, "<< Administrator %s has returned all faction vehicles to their parking places >>", ReturnName(playerid));
	return true;
}

CMD:towcar(playerid, params[])
{
	new factionid = PlayerData[playerid][pFaction];

 	if(factionid == -1)
	    return SendErrorMessage(playerid, "Você não está em uma facção.");

    if(!HasFactionRank(playerid, 2))
  		return SendErrorMessage(playerid, "Voc? n?o esta autorizado a utilizar este coomando.");

	new
	    vehicleid
	;

	if(sscanf(params, "d", vehicleid))
		return SendNoticeMessage(playerid, "USE: /towcar [vehicleid]");

	if(!IsValidVehicle(vehicleid))
	{
		SendErrorMessage(playerid, "Please provide a valid vehicle id.");
		return SendNoticeMessage(playerid, "HINT: Use /dl to view the vehicle ids.");
	}

	foreach (new i : sv_servercar)
	{
		if(vehicleVariables[i][vVehicleScriptID] == vehicleid && vehicleVariables[i][vVehicleFaction] == factionid)
		{
			if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID)
			    return SendErrorMessage(playerid, "This vehicle is occupied.");

	        SetVehicleToRespawn(vehicleVariables[i][vVehicleScriptID]);

            return SendClientMessageEx(playerid, COLOR_GREY, "Vehicle %d respawned.", vehicleid);
		}
	}

	SendErrorMessage(playerid, "You can only tow vehicles belonging to your faction.");
	return true;
}

CMD:respawncar(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "You aren't in any vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid);

	foreach (new i : sv_servercar)
	{
		if(vehicleVariables[i][vVehicleScriptID] == vehicleid)
		{
		    if(vehicleVariables[i][vVehicleFaction] == -1) break;

			if(vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction] && PlayerData[playerid][pAdmin] < 1)
			    return SendErrorMessage(playerid, "You're not part of this vehicle faction.");

			if(!IsPlayerInRangeOfPoint(playerid, 4.0, vehicleVariables[i][vVehiclePosition][0], vehicleVariables[i][vVehiclePosition][1], vehicleVariables[i][vVehiclePosition][2]))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You have to be at vehicle's parking place.");
				SendClientMessage(playerid, 0xFF00FFFF, "Follow the marker.");

				SetPlayerCheckpoint(playerid, vehicleVariables[i][vVehiclePosition][0], vehicleVariables[i][vVehiclePosition][1], vehicleVariables[i][vVehiclePosition][2], 4.0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_VEH;
				return true;
			}

			SetVehicleToRespawn(vehicleVariables[i][vVehicleScriptID]);

			SendClientMessage(playerid, COLOR_GREY, "Vehicle Respawned.");
			return true;
		}
	}

	SendErrorMessage(playerid, "Este não é um veículo de facção.");
	return true;
}
//changespawn para alterarspawn
CMD:alterarspawn(playerid, params[])
{
    new house =  Property_Nearest(playerid);

    if(house == -1)
        return SendErrorMessage(playerid, "Para mudar seu spawn para uma propriedade sua, vá até a entrada a pé.");

	if(!Property_IsOwner(playerid, house) && PlayerData[playerid][pHouseKey] != house)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own this property.");

	PlayerData[playerid][pSpawnPoint] = 2;
  	PlayerData[playerid][pHouseKey] = house;

	SendClientMessage(playerid, COLOR_GREEN, "Você irá spawnar agora na sua propriedade.");

	mysql_format(dbCon, sgstr, sizeof(sgstr), "UPDATE `characters` SET `SpawnPoint` = '2', `playerHouseKey` = '%d' WHERE `ID` = '%d' LIMIT 1", house, PlayerData[playerid][pID]);
	mysql_pquery(dbCon, sgstr);
	return true;
}

Dialog:SetFactionSpawn(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new factionid = PlayerData[playerid][pFaction], idx = strval(inputtext) - 1;

	if(!FactionSpawns[factionid][idx][spawnID]) return true;

	PlayerData[playerid][pSpawnPoint] = 1;
	PlayerData[playerid][pFactionSpawn] = FactionSpawns[factionid][idx][spawnID];

	SendClientMessageEx(playerid, COLOR_YELLOW, "Agora você irá spawnar em %s (Faction).", FactionSpawns[factionid][idx][spawnName]);

	mysql_format(dbCon, sgstr, sizeof(sgstr), "UPDATE `characters` SET `SpawnPoint` = '1', `FactionSpawn` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pFactionSpawn], PlayerData[playerid][pID]);
	mysql_pquery(dbCon, sgstr);
	return true;
}
//setspawn
CMD:mudarspawn(playerid, params[])
{
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/mudarspawn [tipo (0-Normal, 1-Facção, 2-Casa)]");

	new type = strval(params);

	switch(type)
	{
	    case 0:
	    {
	 	    PlayerData[playerid][pSpawnPoint] = 0;

	 		SendClientMessage(playerid, COLOR_YELLOW, "Você definiu o spawn no aeroporto.");

			mysql_format(dbCon, sgstr, sizeof(sgstr), "UPDATE `characters` SET `SpawnPoint` = '0' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pID]);
			mysql_tquery(dbCon, sgstr);
	    }
	    case 1:
	    {
			if(PlayerData[playerid][pFactionID] == -1)
				return SendErrorMessage(playerid, "Você não está em uma facção.");

			new factionid = PlayerData[playerid][pFaction];

			gstr[0] = EOS;

			for(new i = 0; i < 5; ++i)
			{
			    if(FactionSpawns[factionid][i][spawnID] != 0)
			    {
			        format(gstr, sizeof(gstr), "%s{7e98b6}%d\t{a9c4e4}%s\n", gstr, i + 1, FactionSpawns[factionid][i][spawnName]);
			    }
			}

			Dialog_Show(playerid, SetFactionSpawn, DIALOG_STYLE_LIST, "Faction Spawns", gstr, "Select", "<< Exit");
	    }
	    case 2: // House
	    {
	        SendErrorMessage(playerid, "Para mudar seu spawn para uma propriedade sua, vá até a entrada a pé e digite /alterarspawn.");
	    }
	    default:
		{
	        SendSyntaxMessage(playerid, "/alterarspawn [type (0-Normal, 1-Facção, 2-Casa)/)]");
	    }
	}
	return true;
}

// HOTWIRE
YCMD:unscramble(playerid, params[], help) = uns;

CMD:uns(playerid, params[])
{
	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /(uns)cramble <unscrambled word>");

	if(IsPlayerInAnyVehicle(playerid) && h_vid[playerid] != -1)
	{
		new string[128], vehicleid = CarData[ h_vid[playerid] ][carVehicle], Float:vhealth;

		if(GetPlayerVehicleID(playerid) == vehicleid)
		{
			format(sgstr, sizeof(sgstr), "* %s is hotwiring the vehicle.", ReturnName(playerid, 0));
			SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);

		    if(!strcmp(params, ScrambleWord[h_wid[playerid]], true))
		    {
		        h_score[playerid]++;

		        if(h_score[playerid] >= 10)
		        {
		            vehicleid = CarData[h_vid[playerid]][carVehicle];
			    	GetVehicleHealth(vehicleid, vhealth);
	                PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);

	                h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
	                h_word[playerid][0]='\0';

				    if(vhealth > 650)
				    {
						SetEngineStatus(vehicleid, true);
					 	GameTextForPlayer(playerid, "~g~Engine On", 2000, 4);
					  	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ligou o motor do %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
					else
					{
				 	    new delay = floatround(900 / vhealth);
					    if(delay > 3) { delay = 3; }

						if(delay == 0)
						{
							SetEngineStatus(vehicleid, true);
						}
						else
						{
		    	 			CoreVehicles[vehicleid][startup_delay] = delay;
							CoreVehicles[vehicleid][startup_delay_sender] = playerid;
							CoreVehicles[vehicleid][startup_delay_random] = delay;
						}

						GameTextForPlayer(playerid, "~g~Engine On", 2000, 4);
						SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ligou o motor do %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
					}
					return true;
			 	}
				else 
				{
					PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);

					h_wid[playerid] = random(sizeof(ScrambleWord));
					h_word[playerid] = CreateScramble(ScrambleWord[h_wid[playerid]]);

					format(string, sizeof(string), "~y~/(uns)cramble ~w~<unscrambled word> ~r~to unscramble the word.~n~'~w~%s~r~'.", h_word[playerid]);
					ShowPlayerFooter(playerid, string, 8000);
					return true;					
				}
		    }

		    PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);

            h_failed[playerid]++;

            if(h_failed[playerid] >= 6)
            {
                // TAZER

				new Float:x, Float:y, Float:z;

				GetPlayerPos(playerid, x, y, z);
				SetPlayerDynamicPos(playerid, x, y, z+2);
				ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, false, true, true, true, false, true);

				IsTazed{playerid} = true;

				SetTimerEx("SetUnTazed", 10000, false, "i", playerid);

	         	h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
	          	h_word[playerid][0]='\0';

                GameTextForPlayer(playerid, "YOU ARE TAZED", 5000, 5);
                ShowPlayerFooter(playerid, "~r~You've failed too many words.");
                return 1;
            }

			h_wid[playerid] = random(sizeof(ScrambleWord));
			h_word[playerid] = CreateScramble(ScrambleWord[h_wid[playerid]]);

			format(string, sizeof(string), "~y~/(uns)cramble ~w~<unscrambled word> ~r~to unscramble the word.~n~'~w~%s~r~'.", h_word[playerid]);
		 	ShowPlayerFooter(playerid, string, 8000);
		}
	}
	return true;
}

ResetScrambleVariables(playerid)
{
	HidePlayerFooter(playerid);

	h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
	h_word[playerid][0]='\0';	
}

FailUnscramble(playerid)
{
	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerDynamicPos(playerid, x, y, z + 2);
	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, false, true, true, true, false, true);

	IsTazed{playerid} = true;

	SetTimerEx("SetUnTazed", 10000, false, "i", playerid);

	h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
	h_word[playerid][0]='\0';

    GameTextForPlayer(playerid, "YOU ARE TAZED", 5000, 5);
    ShowPlayerFooter(playerid, "~r~You've failed too many words.");	
}

CMD:motor(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendServerMessage(playerid, "Você precisa estar no banco do motorista de um veículo.");

	new vehicleid = GetPlayerVehicleID(playerid), id = -1, Float:vhealth, bool:canstart;

	if(!IsEngineVehicle(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Este veículo não tem motor.");

	if(!CoreVehicles[vehicleid][vehFuel])
  		return SendClientMessage(playerid, COLOR_LIGHTRED, "Este veículo não tem óleo.");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "YVocê não pode executar esta ação agora.");

    if((id = Car_GetID(vehicleid)) != -1)
    {
        if(!HasVehicleKey(playerid, id, true) && !AdminDuty{playerid})
		{
		    if(!GetEngineStatus(vehicleid))
		    {
	            if(h_vid[playerid] == -1)
	            {
		            new string[128];
					
		            // Hotwire
				 	h_vid[playerid] = id;
					h_times[playerid] = 25 * (6 - CarData[id][carImmob]);
	                h_failed[playerid] = 0;
					h_wid[playerid] = random(sizeof(ScrambleWord));
					h_word[playerid] = CreateScramble(ScrambleWord[ h_wid[playerid] ]);

					CreateScramble(h_word[playerid]);

					format(string, sizeof(string), "~y~/(uns)cramble ~w~<unscrambled word> ~r~to unscramble the word.~n~'~w~%s~r~'.~n~You have ~w~%d ~r~seconds left to finish.", h_word[playerid], h_times[playerid]);
		            ShowPlayerFooter(playerid, string, 8000);

					format(string, sizeof(string), "* %s starts hotwiring the vehicle.", ReturnName(playerid, 0));
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 20.0, 6000);						
				}
			}
			else
			{
			    GameTextForPlayer(playerid, "~g~O motor esta ligado", 2000, 4);
			}
            return true;
        }
        else canstart = true;
    }

	if(id == -1)
	{
		if((id = Vehicle_GetID(vehicleid)) != -1)
		{
			if(vehicleVariables[id][vVehicleFaction] == PlayerData[playerid][pFaction])
			{
				canstart = true;
			}
			else
			{
				return SendServerMessage(playerid, "Você não tem acesso a este veículo.");
			}
		}
	}

	if(canstart || RentCarKey[playerid] == vehicleid || (IsAdminSpawned(vehicleid) && PlayerData[playerid][pAdmin]))
	{
	    GetVehicleHealth(vehicleid, vhealth);

		switch(GetEngineStatus(vehicleid))
		{
			case false:
			{
				GetVehicleHealth(vehicleid, vhealth);

				if(vhealth > 650)
				{
					SetEngineStatus(vehicleid, true);
					GameTextForPlayer(playerid, "~g~Motor ligado", 2000, 4);
					SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s liga o motor do %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				}
				else if(vhealth < 390)
				{
					if(!CoreVehicles[vehicleid][vehicleBadlyDamage])
					{
					 	GameTextForPlayer(playerid, "~r~O MOTOR NÃO PODE LIGAR DEVIDO AOS DANOS", 5000, 4);

						SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: O motor está muito danificado.");
						SendClientMessage(playerid, COLOR_YELLOW, "DICA: Segure seu {FFFFFF}W {FFFF00}no teclado para acelerar o motor");
						SendClientMessage(playerid, COLOR_YELLOW, "DICA: Vocês tem{FFFFFF} 10 segundos {FFFF00}para acelerar o motor.");

						CoreVehicles[vehicleid][vehicleBadlyDamage] = 10;
					}
					else
					{
					    GameTextForPlayer(playerid, "~r~O MOTOR NÃO PODE LIGAR DEVIDO AOS DANOS", 5000, 4);
					}
					return true;
				}
				else
				{
				    new owner_delay;

				    if(id != -1) owner_delay = floatround((VehicleData[CarData[id][carModel] - 400][c_engine] - CarData[id][carEngineL]) / 25);

					new delay = floatround(1300 / vhealth) + owner_delay;

					if(delay > 5)
					{
						delay = 5;
					}

					if(delay == 0)
					{
						SetEngineStatus(vehicleid, true);
					}
					else
					{
						CoreVehicles[vehicleid][startup_delay] = delay;
						CoreVehicles[vehicleid][startup_delay_sender] = playerid;
						CoreVehicles[vehicleid][startup_delay_random] = delay;
					}

					GameTextForPlayer(playerid, "~g~Motor ligado", 2000, 4);
					SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s liga o motor do %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
				}
			}
			case true:
			{
				SetEngineStatus(vehicleid, false);
				SetLightStatus(vehicleid, false);
				GameTextForPlayer(playerid, "~r~Motor desligado", 2000, 4);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s desliga o motor do %s.", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                StopCarBoomBox(vehicleid);
			}
		}
	}
	else SendServerMessage(playerid, "Esta ordem só está disponível para os seus veículos. Mas você está em um veículo público (Estático)");

	return true;
}

// Radio System

CMD:m(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "Você está procurando por /meg (megafone), /me or /pm");
	return true;
}

CMD:meg(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SHERIFF && GetFactionType(playerid) != FACTION_CORRECTIONAL)
	    return SendUnauthMessage(playerid, "Você não tem acesso a isso.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/m [megafone texto]");

    if(PlayerData[playerid][pInjured])
        return SendErrorMessage(playerid, "Você não pode executar esta ação agora.");

	new bool:can_use;

	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

	    if(IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]))
		{
			can_use = true;
		}
	}
	else
	{
		foreach (new i : sv_vehicles)
		{
			if(vehicleVariables[i][vVehicleFaction] == PlayerData[playerid][pFaction] && IsPlayerNearDriverDoor(playerid, vehicleVariables[i][vVehicleScriptID]))
			{
				can_use = true;
			}
		}
	}

	if(!can_use)
	    return SendErrorMessage(playerid, "Você não está ao lado de um megafone.");

	if(strlen(params) > 80)
	{
		SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "[ %s:o< %.80s ]", ReturnName(playerid, 0), params);
		SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "[ %s:o< ... %s ]", ReturnName(playerid, 0), params[80]);
	}
	else SendNearbyMessage(playerid, 40.0, COLOR_YELLOW, "[ %s:o< %s ]", ReturnName(playerid, 0), params);

    return true;
}

CMD:d(playerid, params[])
	return SendClientMessage(playerid, COLOR_WHITE, "You are looking for /dep. Enough ''accidents''.");

YCMD:departments(playerid, params[], help) = dep;

CMD:dep(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1 || GetFactionType(playerid) == FACTION_GANG || GetFactionType(playerid) == FACTION_NEWS)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a legal faction.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "(/dep)epartments [department chat]");

	if(!PlayerData[playerid][pDepartment])
	{
		foreach (new i : Player)
		{
			if(PlayerData[i][pFaction] == -1) continue;

		    if(GetFactionType(i) != FACTION_GANG)
		    {
      			if(strlen(params) > 66)
				{
				    SendClientMessageEx(i, COLOR_MEDIC, "** [%s>ALL] %s %s: %.66s", Faction_GetAbbreviation(playerid), Faction_GetRank(playerid), ReturnName(playerid, 0), params);
				    SendClientMessageEx(i, COLOR_MEDIC, "%s **", params[66]);
				}
				else SendClientMessageEx(i, COLOR_MEDIC, "** [%s>ALL] %s %s: %s **", Faction_GetAbbreviation(playerid), Faction_GetRank(playerid), ReturnName(playerid, 0), params);
		    }
		}
	}
	else
	{
		foreach (new i : Player)
		{
		    if(PlayerData[i][pFaction] == -1) continue;

		    if(GetFactionType(i) == GetFactionType(playerid) || GetFactionType(i) == PlayerData[playerid][pDepartment])
		    {
		        if(strlen(params) > 66)
		        {
		            SendClientMessageEx(i, COLOR_MEDIC, "** [%s>%s] %s %s: %.66s **", Faction_GetAbbreviation(playerid), Faction_GetAbbreviation(playerid, PlayerData[playerid][pDepartment]), Faction_GetRank(playerid), ReturnName(playerid, 0), params);
		            SendClientMessageEx(i, COLOR_MEDIC, "%s **", params[66]);
		        }
		        else SendClientMessageEx(i, COLOR_MEDIC, "** [%s>%s] %s %s: %s **", Faction_GetAbbreviation(playerid), Faction_GetAbbreviation(playerid, PlayerData[playerid][pDepartment]), Faction_GetRank(playerid), ReturnName(playerid, 0), params);
		    }
		}
	}
	return true;
}

CMD:setdep(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1 || GetFactionType(playerid) == FACTION_GANG || GetFactionType(playerid) == FACTION_NEWS)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You're not in a legal faction.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/setdep [ALL / LS(SD) / LS(PD) / LS(FD) / SA(DCR) / SA(GOV) / COURTS / SERVICES]");

	if(!strcmp(params, "ALL", true))
	{
	    PlayerData[playerid][pDepartment] = 0;

	    SendNoticeMessage(playerid, "You're now transmitting to all the depratments available.");
	}
    else if(!strcmp(params, "LSSD", true) || !strcmp(params, "SD", true))
    {
        PlayerData[playerid][pDepartment] = FACTION_SHERIFF;

        SendNoticeMessage(playerid, "You're now transmitting to the Los Santos County Sheriff's Department.");
    }
    else if(!strcmp(params, "LSPD", true) || !strcmp(params, "PD", true))
    {
        PlayerData[playerid][pDepartment] = FACTION_POLICE;

        SendNoticeMessage(playerid, "You're now transmitting to the Los Santos Police Department.");
    }
    else if(!strcmp(params, "LSFD", true) || !strcmp(params, "FD", true))
    {
        PlayerData[playerid][pDepartment] = FACTION_MEDIC;

		SendNoticeMessage(playerid, "You're now transmitting to the Los Santos Fire Department.");
	}
    else if(!strcmp(params, "SADCR", true) || !strcmp(params, "DCR", true))
    {
        PlayerData[playerid][pDepartment] = FACTION_CORRECTIONAL;

		SendNoticeMessage(playerid, "You're now transmitting to the Department of Corrections and Rehabilitation.");
    }
    else SendSyntaxMessage(playerid, "/setdep [ALL / SA(SD) / LS(PD) / LS(FD) / SA(DOC)]");

    return true;
}

CMD:setslot(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    slot
	;

	if(sscanf(params, "d", slot))
		return SendClientMessage(playerid, COLOR_WHITE, "USE: /setslot [radio slot]");

	if(slot < 1 || slot > PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_WHITE, "Your radio doesn't support that slot.");

	PlayerData[playerid][pMainSlot] = slot;

	SendClientMessageEx(playerid, COLOR_YELLOW, "Local channel on the radio set to %i!", slot);
	return true;
}

CMD:part(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    local = PlayerData[playerid][pMainSlot]
	;

	if(PlayerData[playerid][pRadioChan][local] < 1)
		return SendErrorMessage(playerid, "You aren't in a frequency in your current slot.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "Parted from radio channel %d, from your slot %d.", PlayerData[playerid][pRadioChan][local], local);

	PlayerData[playerid][pRadioChan][local] = 0;

	format(gquery, sizeof(gquery), "UPDATE `radio` SET `channel` = 0 WHERE `slot` = '%d' AND `owner` = '%d'", local, PlayerData[playerid][pID]);
	mysql_tquery(dbCon, gquery);
	return true;
}

CMD:setchannel(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new slot, ch;

	if(sscanf(params, "dd", slot, ch))
		return SendClientMessage(playerid, COLOR_WHITE, "USE: /setchannel [radio slot] [channel number]");

	if(slot < 1 || slot > PlayerData[playerid][pRadio])
        return SendClientMessage(playerid, COLOR_WHITE, "Your radio doesn't support that slot.");

	if(ch < 1 || ch > 1000000)
		return SendClientMessage(playerid, COLOR_WHITE, "Only channels 1 - 1000000 supported");

    if(!CanJoinChannel(playerid, ch))
        return SendErrorMessage(playerid, "Government issued radio frequency.");

    for(new r = 1; r < 9; ++r)
    {
        if(PlayerData[playerid][pRadioChan][r] == ch)
        {
            return SendClientMessage(playerid, COLOR_LIGHTRED, "You're already in this channel on one of your slots, /part first!");
        }
    }

	new old_slot = PlayerData[playerid][pRadioChan][slot];

	PlayerData[playerid][pRadioChan][slot] = ch;

	SendClientMessageEx(playerid, COLOR_GREEN, "Radio Channel Set. [CH: %i, Slot: %i].", ch, slot);
	SendClientMessage(playerid, COLOR_CYAN, "Use /r to talk in this channel");

	if(old_slot <= 0)
	{
		format(gquery, sizeof(gquery), "INSERT INTO radio (channel, slot, owner) VALUES (%d, %d, %d)", ch, slot, PlayerData[playerid][pID]);
		mysql_tquery(dbCon, gquery);
	}
	else
	{
		format(gquery, sizeof(gquery), "UPDATE `radio` SET `channel` = %d WHERE `slot` = '%d' AND `owner` = '%d'", ch, slot, PlayerData[playerid][pID]);
		mysql_tquery(dbCon, gquery);
	}
	return true;
}

stock GetChannelSlot(playerid, chan)
{
    for(new r = 1; r < 9; ++r)
	{
		if(PlayerData[playerid][pRadioChan][r] == chan)
		{
			return r;
		}
	}
	return 0;
}

YCMD:r(playerid, params[], help) = radio;

CMD:radio(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
		local = PlayerData[playerid][pMainSlot],
		channel = PlayerData[playerid][pRadioChan][local]
	;

	if(PlayerData[playerid][pRadioChan][local] < 1)
		return SendErrorMessage(playerid, "Set the channel first, with /setchannel. (Current slot: %d)", local);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:rlow(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
		local = PlayerData[playerid][pMainSlot],
		channel = PlayerData[playerid][pRadioChan][local]
	;

	if(PlayerData[playerid][pRadioChan][local] < 1)
		return SendErrorMessage(playerid, "Set the channel first, with /setchannel. (Current slot: %d)", local);

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 5.0);
	return true;
}

stock ReturnChannelName(channel)
{
	new channelName[24];

	switch(channel)
	{
	    case 911:
			channelName = "BASE"; // LSPD
	    case 931:
			channelName = "SPLX 1"; // LSPD
	    case 932:
			channelName = "SPLX 2"; // LSPD
		case 933:
		    channelName = "SPLX 3"; // LSPD
	    case 977:
			channelName = "SWAT"; // LSPD
	    case 741337:
			channelName = "METRO"; // LSPD
		case 98750:
		    channelName = "LSC DISP"; // LSSD
		case 91250:
		    channelName = "L-TAC 1"; // LSSD
		case 991119:
			channelName = "Dispatch"; // LSFD
		default:
			format(channelName, 24, "%d", channel);
	}

	return channelName;
}

stock CanJoinChannel(playerid, channel)
{
	if(PlayerData[playerid][pFaction] == -1) return true;

	switch(channel)
	{
	    case 911, 931, 932, 933, 977, 741337:
	    {
	        if(GetFactionType(playerid) != FACTION_POLICE)
				return false;
	    }
	    case 98750, 91250:
	    {
	        if(GetFactionType(playerid) != FACTION_SHERIFF)
				return false;
	    }
	    case 991119:
	    {
	        if(GetFactionType(playerid) != FACTION_MEDIC)
				return false;
	    }
	    default: return true;
	}

	return true;
}

stock SendRadioMessage(playerid, channel, text[], Float:range = 20.0)
{
	foreach (new i : Player)
	{
		for(new r = 1; r < 9; ++r)
		{
			if(PlayerData[i][pRadioChan][r] == channel)
			{
				if(strlen(text) > 66)
				{
					if(r != PlayerData[i][pMainSlot])
					{
						SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %s, S: %d] %s says: %.66s", ReturnChannelName(PlayerData[i][pRadioChan][r]), GetChannelSlot(i, channel), ReturnName(playerid, 0), text);
						SendClientMessageEx(i, COLOR_RADIOEX, "%s", text[66]);
					}
					else
					{
						SendClientMessageEx(i, COLOR_RADIO, "**[CH: %s, S: %d] %s says: %.66s", ReturnChannelName(PlayerData[i][pRadioChan][r]), GetChannelSlot(i, channel), ReturnName(playerid, 0), text);
						SendClientMessageEx(i, COLOR_RADIO, "%s", text[66]);
					}
				}
				else
				{
					if(r != PlayerData[i][pMainSlot])
					{
						SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %s, S: %d] %s says: %s", ReturnChannelName(PlayerData[i][pRadioChan][r]), GetChannelSlot(i, channel), ReturnName(playerid, 0), text);
					}
					else
					{
						SendClientMessageEx(i, COLOR_RADIO, "**[CH: %s, S: %d] %s says: %s", ReturnChannelName(PlayerData[i][pRadioChan][r]), GetChannelSlot(i, channel), ReturnName(playerid, 0), text);
					}
				}
			}
		}
	}

	new
	    string[128]
	;

	if(strlen(text) > 90)
	{
		if(range >= 15.0)
		{
			format(string, sizeof(string), "(Radio) %s says: %.90s", ReturnName(playerid, 0), text);
			ProxDetectorRadio(playerid, range, string);

			format(string, sizeof(string), "%s", text[90]);
			ProxDetectorRadio(playerid, range, string);
		}
		else
		{
			format(string, sizeof(string), "(Radio) %s says [low]: %.90s", ReturnName(playerid, 0), text);
			ProxDetectorRadio(playerid, range, string);

			format(string, sizeof(string), "%s", text[90]);
			ProxDetectorRadio(playerid, range, string);
		}
	}
	else
	{
		if(range >= 15.0)
		{
			format(string, sizeof(string), "(Radio) %s says: %s", ReturnName(playerid, 0), text);
			ProxDetectorRadio(playerid, range, string);
		}
		else
		{
			format(string, sizeof(string), "(Radio) %s says [low]: %s", ReturnName(playerid, 0), text);
			ProxDetectorRadio(playerid, range, string);
		}
	}
}

CMD:r1(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][1]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r1low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][1]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r2(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][2]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r2low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][2]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r3(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][3]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r3low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][3]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r4(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][4]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

	SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r4low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][4]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

	SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r5(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][5]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r5low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][5]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r6(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][6]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r6low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][6]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r7(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][7]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r7low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][7]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

CMD:r8(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][8]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params);
	return true;
}

CMD:r8low(playerid, params[])
{
	if(!PlayerData[playerid][pRadio])
		return SendClientMessage(playerid, COLOR_GREY, "You don't have radio, buy one in 24/7");

	new
	    channel = PlayerData[playerid][pRadioChan][8]
	;

	if(channel < 1)
		return SendClientMessage(playerid, COLOR_GREY, "Your local radio slot isn't set to a channel.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/r [text] {FF6347},{FFFFFF} /rlow [text] {FF6347},{FFFFFF} /r[ch] [text] {FF6347}or{FFFFFF} /r[ch]low");

    SendRadioMessage(playerid, channel, params, 6.0);
	return true;
}

// Private Vehicle System

CMD:vehiclename(playerid, parmas[])
{
	new vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a vehicle.");

	new carid = PlayerData[playerid][pCarKeys][carkey], vehiclename[64], found = -1;

	if(sscanf(parmas, "s[64]", vehiclename))
	{
		SendClientMessage(playerid, COLOR_YELLOW3, "USE: /vehiclename [Enter Custom Name]");
		SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Do not include any periods at the end of your request.");
		SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Your custom model name should include the model's year.");
		SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Want to remove an existing custom name? /remove_vehiclename.");
		SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Don't despawn your vehicle or the request will be trashed.");
		return true;
	}

	if(strlen(vehiclename) < 3 || strlen(vehiclename) > 64)
	    return SendErrorMessage(playerid, "Must be at least 3 characters and can't be longer than 64.");

	for(new i = 0; i < 100; ++i)
	{
 		if(!VehicleRequests[i][requestActive])
		{
			VehicleRequests[i][requestActive] = true;
			format(VehicleRequests[i][requestStamp], 60, ReturnSiteDate());
			VehicleRequests[i][requestPlayer] = playerid;
			VehicleRequests[i][requestCar] = carid;
			format(VehicleRequests[i][requestName], 64, vehiclename);

			found = i;
			break;
		}
	}

	if(found == -1) return SendErrorMessage(playerid, "Something went wrong, contact an admin.");

	SendNoticeMessage(playerid, "Your request has been submitted as request #%d.", found + 1);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s [%d] has submited a vehiclename request for their %s.", ReturnName(playerid), playerid, ReturnVehicleName(vehicleid));
	return true;
}

YCMD:veiculo(playerid, params[], help) = v;

CMD:v(playerid, params[])
{
    if(IsBrutallyWounded(playerid))
        return SendClientMessage(playerid, COLOR_LIGHTRED, "Você está brutalmente ferido ou morto.");
        //return SendClientMessage(playerid, COLOR_LIGHTRED, "Você está brutalmente ferido ou morto. No /vehicle right now.");

	new
	    type[24],
		vehicleid,
		carkey,
		carid,
		query[128],
		cf[16],
		cf2[16],
		cf3[16];

	if(sscanf(params, "s[24]S()[16]S()[16]S()[16]", type, cf, cf2, cf3))
 	{
		SendClientMessage(playerid, COLOR_YELLOW3, "____________________________________________________");
		SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo [acção]");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Ações] lista, estacionar, vender, registrar, removerplaca, comprar, upgrade, luzes, opendoor, prices");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Ações] status, rebocar, duplicarchave, takekey, droparchave, faction, encontrar, comprarvaga, trancar, localizacao");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Ações] company, chaves, vTag");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Deletar] sucatear (aviso: deleta o seu carro completamente)");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Outros] /portamalas /capo /rollwindow");
		//SendClientMessage(playerid, COLOR_YELLOW3, "[Dica] There is a guide how to use all these actions at forum.ls-rp.com.br");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Dica] Você pode mostrar aos outros jogadores os status do seu veículo com /v status [playerid]");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Dica] Quer um nome de veículo personalizado? Solicite um usando /vehiclename");
		SendClientMessage(playerid, COLOR_YELLOW3, "[Dica] Você pode usar /v luzes auto para alternar o uso automático das luzes durante a noite.");
		SendClientMessage(playerid, COLOR_YELLOW3, "____________________________________________________");
		return true;
	}

	if(!strcmp(type, "lista", true) || !strcmp(type, "spawn", true))
	{
	    if(UsingMDC{playerid})
	        return SendServerMessage(playerid, "Você não pode fazer isso agora.");

		if(!CountPlayerVehicles(playerid))
		    return SendServerMessage(playerid, "Você não possui nenhum veículo.");

		PCarPage[playerid] = 1;

		ShowPlayerCarMenu(playerid);
	}
	else if(!strcmp(type, "vender", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar no seu veículo.");

	    carid = PlayerData[playerid][pCarKeys][carkey];

		if(IsDonateCar(CarData[carid][carModel]))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode vender este veículo de doador..");

		new userid = INVALID_PLAYER_ID, price;

		if(sscanf(params, "{s[24]}ud", userid, price))
			return SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo vender [id/nome] [preço]");

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "{s[24]}s[24]{d}", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse jogador não está conectado.");
			}
		}

		if(userid == playerid)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não pode vender para si mesmo.");

		if(tToAccept[userid] != OFFER_TYPE_NONE)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "Este jogador já tem uma oferta.");

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Não está perto o suficiente!");

		if(CountVehicleKeys(userid) >= MaxVehiclesSpawned(userid))
            return SendServerMessage(playerid, "Este jogador já tem um veículo spawnado.");

		if(CountPlayerVehicles(userid) >= 12)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Este jogador tem a quantidade máxima de veículos.");

		if(price < 0)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Preço inválido!");

		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Oferta enviada.");

		pToAccept[userid] = playerid;
		vToAccept[userid] = carid;
		prToAccept[userid] = price;
		tToAccept[userid] = OFFER_TYPE_VSELL;

		format(query, sizeof(query), "%s ofereceu a você um(a) ~y~%s~n~~w~por ~g~$%d~n~~p~pressione ~g~Y~p~ para aceitar ou ~r~N ~p~para recusar.", ReturnName(pToAccept[userid], 0), g_arrVehicleNames[CarData[carid][carModel] - 400], FormatNumber(prToAccept[userid]));
	 	ShowPlayerFooter(userid, query, -1);
	}
	else if(!strcmp(type, "vTag", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar no seu veículo.");

	    carid = PlayerData[playerid][pCarKeys][carkey];

	    if(strlen(CarData[carid][carUItag]) >= 3)
    	{
	        SendClientMessageEx(playerid, COLOR_YELLOW3, "SERVER: Você removeu a tag '%s' do seu %s.", CarData[carid][carUItag], ReturnVehicleName(vehicleid));

	        CarData[carid][carUItag][0] = EOS;

			Car_SaveID(carid);
			return true;
	    }

	    new
	        text[16]
		;

		strmid(text, params, 6, strlen(params));

		if(isnull(text))
		    return SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo vTag [nome]");

	    if(strlen(text) < 3 || strlen(text) > 15)
	        return SendErrorMessage(playerid, "Deve ter pelo menos 3 caracteres e não pode ter mais de 15.");

	    SendClientMessageEx(playerid, COLOR_YELLOW3, "SERVER: Você adicionou a tag '%s' ao seu %s. Ela aparecerá na interface /v lista.", text, ReturnVehicleName(vehicleid));

	    format(CarData[carid][carUItag], 15, text);
	    Car_SaveID(carid);
	}
	else if(!strcmp(type, "dup", true) || !strcmp(type, "duplicarchave", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

	    carid = PlayerData[playerid][pCarKeys][carkey];

		if(PlayerData[playerid][pCash] < 2000)
			return SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente para realizar esta ação.");

		new
			userid
		;

		if(sscanf(cf, "u", userid))
			return SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo duplicarchave [id/nome]");

		if(userid == playerid)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Não pode ser você.");

		if(userid == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(cf, "s[24]", maskid);
			if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Jogador especificado não está conectado.");
			}
		}

		if(!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Não está perto o suficiente!");

		if(CountVehicleDupKeys(userid) >= 10)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Este jogador não pode segurar mais nenhuma chave.");

	    TakePlayerMoney(playerid, 2000);

	    GiveVehicleDupKey(userid, CarData[carid][carID]);

        SendClientMessageEx(playerid, COLOR_GREEN, "** %s dá um conjunto de chaves reservas do seu %s para %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid), ReturnName(userid, 0));

		SendNoticeMessage(userid, "Você recebeu um conjunto de chaves reservas de %s's %s", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
		SendNoticeMessage(userid, "Essas chaves agora persistem quando você deslogar, você pode removê-las usando '/v droparchave'");
	}
	else if(!strcmp(type, "chaves", true))
	{
	    new count, rows, model, plate[30];

	    for(new i = 0; i < 10; ++i)
	    {
	        if(PlayerData[playerid][pDupKeys][i] != 9999)
	        {
				mysql_format(dbCon, query, sizeof(query), "SELECT `carModel`, `carPlate` FROM `cars` WHERE `carID` = '%d' LIMIT 1", PlayerData[playerid][pDupKeys][i]);
				new Cache:cache = mysql_query(dbCon, query);

				cache_get_row_count(rows);

				if(rows)
				{
					cache_get_value_name_int(0, "carModel", model);
					cache_get_value_name(0, "carPlate", plate, 30);

					SendClientMessageEx(playerid, COLOR_YELLOW3, "CHAVE:%d VEÍCULO: %s PLACA: %s", i + 1, ReturnVehicleModelNameEx(model), plate);

					count++;
				}

				cache_delete(cache);
	        }
	    }

	    if(!count) SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem nenhuma chave.");
	}
	else if(!strcmp(type, "droparchave", true))
	{
		new
			keyid
		;

		if(sscanf(cf, "d", keyid))
		{
		    SendClientMessage(playerid, COLOR_YELLOW3, "DICA: Use /(v)eiculo chaves para obter uma lista das chaves que você tem.");
		    SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo droparchave [Chave Slot]");
		    return true;
		}

		if(keyid < 1 || keyid > 10)
		    return SendErrorMessage(playerid, "Chave inválida.");

		keyid--;

		if(PlayerData[playerid][pDupKeys][keyid] == 9999)
		    return SendErrorMessage(playerid, "Você não tem nenhuma chave neste slot.");

	    new rows, model, plate[30];

		mysql_format(dbCon, query, sizeof(query), "SELECT `carModel`, `carPlate` FROM `cars` WHERE `carID` = '%d' LIMIT 1", PlayerData[playerid][pDupKeys][keyid]);
		new Cache:cache = mysql_query(dbCon, query);

		cache_get_row_count(rows);

		if(!rows)
		{
		    cache_delete(cache);
		    
			return SendClientMessage(playerid, COLOR_YELLOW, "Erro fatal ao dropar sua chave reserva.");
		}

		cache_get_value_name_int(0, "carModel", model);
		cache_get_value_name(0, "carPlate", plate, 30);
		
		cache_delete(cache);

		RemoveVehicleDupKey(playerid, PlayerData[playerid][pDupKeys][keyid]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Você jogou fora a chave reserva de um %s com a placa %s.", ReturnVehicleModelNameEx(model), plate);
	}
	else if(!strcmp(type, "upgrade", true))
	{
		new id = -1;

		if((id = Business_Nearest(playerid, 10.0)) != -1 && BusinessData[id][bType] == 4)
		{
		    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

		    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && carkey != -1)
		    {
		        new uplevel = strval(cf2);

				carid = PlayerData[playerid][pCarKeys][carkey];

		        if(!strlen(cf))
		        {
	             	SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level]");
	                SendClientMessage(playerid, COLOR_YELLOW3, "[UPGRADES] trava, alarme, imobilizador, seguro, armour");
	                SendClientMessage(playerid, COLOR_YELLOW3, "[UPGRADES] bateria, motor (( Esta opção substitui o original. ))");
	         	}
				else if(!strcmp(cf, "trava", true))
				{
					if(uplevel > 0 && uplevel < 5)
					{
						if(!strcmp(cf3,"sim", true) && strlen(cf3))
					    {
							if(!VehicleLabel[vehicleid][vLabelTime])
							{
							 	SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADELOCK, 10);
								CoreVehicles[vehicleid][vOwnerID] = playerid;
								CoreVehicles[vehicleid][vUpgradeID] = uplevel;
							}
							else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					    }
					    else
					    {
					        SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[uplevel-1][u_rate]) + VehicleUpgradeLock[uplevel-1][u_price]));
					        SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level] {FFFF00}sim");
					    }
					}
					else
					{
		                SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade trava [trava-level]");
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Lock Level 1 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[0][u_rate]) + VehicleUpgradeLock[0][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Lock Level 2 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[1][u_rate]) + VehicleUpgradeLock[1][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Lock Level 3 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[2][u_rate]) + VehicleUpgradeLock[2][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Lock Level 4 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeLock[3][u_rate]) + VehicleUpgradeLock[3][u_price]));
					}
				}
				else if(!strcmp(cf, "alarme", true))
				{
					if(uplevel > 0 && uplevel < 5)
					{
						if(!strcmp(cf3,"sim", true) && strlen(cf3))
					    {
							if(!VehicleLabel[vehicleid][vLabelTime])
							{
							 	SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADEALARM, 10);
								CoreVehicles[vehicleid][vOwnerID] = playerid;
								CoreVehicles[vehicleid][vUpgradeID] = uplevel;
							}
							else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					    }
					    else
					    {
					        SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[uplevel-1][u_rate]) + VehicleUpgradeAlarm[uplevel-1][u_price]));
					        SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level] {FFFF00}sim");
					    }
					}
					else
					{
		                SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade alarme [alarm-level]");
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Alarme Level 1 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[0][u_rate]) + VehicleUpgradeAlarm[0][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Alarme Level 2 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[1][u_rate]) + VehicleUpgradeAlarm[1][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Alarme Level 3 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[2][u_rate]) + VehicleUpgradeAlarm[2][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "Alarme Level 4 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeAlarm[3][u_rate]) + VehicleUpgradeAlarm[3][u_price]));
					}
				}
				else if(!strcmp(cf, "imobilizador", true))
				{
					if(uplevel > 0 && uplevel < 5)
					{
						if(!strcmp(cf3,"sim", true) && strlen(cf3))
					    {
							if(!VehicleLabel[vehicleid][vLabelTime])
							{
							 	SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADEIMMOB, 10);
								CoreVehicles[vehicleid][vOwnerID] = playerid;
								CoreVehicles[vehicleid][vUpgradeID] = uplevel;
							}
							else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					    }
					    else
					    {
					        SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[uplevel-1][u_rate]) + VehicleUpgradeImmob[uplevel-1][u_price]));
					        SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level] {FFFF00}sim");
					    }
					}
					else
					{
		                SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade imobilizador [immob-level]");
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "imobilizador Level 1 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[0][u_rate]) + VehicleUpgradeImmob[0][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "imobilizador Level 2 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[1][u_rate]) + VehicleUpgradeImmob[1][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "imobilizador Level 3 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[2][u_rate]) + VehicleUpgradeImmob[2][u_price]));
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "imobilizador Level 4 - {33AA33}%s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / VehicleUpgradeImmob[3][u_rate]) + VehicleUpgradeImmob[3][u_price]));
					}
				}
				else if(!strcmp(cf, "seguro", true))
				{
					if(uplevel > 0 && uplevel < 4 && !IsABike(vehicleid) && !IsABicycle(vehicleid))
					{
						if(!strcmp(cf3,"sim", true) && strlen(cf3))
					    {
							if(!VehicleLabel[vehicleid][vLabelTime])
							{
							 	SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADEINSURANCE, 10);
								CoreVehicles[vehicleid][vOwnerID] = playerid;
								CoreVehicles[vehicleid][vUpgradeID] = uplevel;
							}
							else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					    }
					    else
					    {
					        SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer a %s", FormatNumber(((IsABike(vehicleid)) ? 1000 : 2500) *uplevel));
							SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level] {FFFF00}sim");
					    }
					}
					else
					{
		                SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade seguro [seguro-level]");
		                SendClientMessage(playerid, COLOR_YELLOW3, "Seguro 1st Level: O veículo sempre irá reaparecer com sua saúde máxima.");
						SendClientMessage(playerid, COLOR_YELLOW3, "Seguro 2nd Level: Proteção contra danos ao veículo. O veículo irá renascer com a lataria nova.");
                        SendClientMessage(playerid, COLOR_YELLOW3, "Seguro 3rd Level: Cobertura de modificação de veículo. Temos seu layout sofisticado e suas músicas XM cobertas!");
					}
				}
				else if(!strcmp(cf, "armour", true))
				{
					if(uplevel >= 10 && uplevel <= 250 && (CarData[carid][carArmour] + float(uplevel)) <= 250)
					{
						if(!strcmp(cf3,"sim", true) && strlen(cf3))
					    {
							if(!VehicleLabel[vehicleid][vLabelTime])
							{
								new time = 5;

								if(uplevel >= 20) time = uplevel / 10;

							 	SetVehicleLabel(vehicleid, VLT_TYPE_ARMOUR, time);
								CoreVehicles[vehicleid][vOwnerID] = playerid;
								CoreVehicles[vehicleid][vUpgradeID] = uplevel;
							}
							else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					    }
					    else
					    {
					        SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(uplevel * GetVehicleDataArmourCost(CarData[carid][carModel])));
					        SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level] {FFFF00}sim");
					    }
					}
					else
					{
		                SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade armour [quantidade]");
		                SendClientMessage(playerid, COLOR_YELLOW3, "AMOUNT: 10-250");
		                SendClientMessageEx(playerid, COLOR_YELLOW3, "{33AA33}$%d{F0EA92} per Armour point.", GetVehicleDataArmourCost(CarData[carid][carModel]));
					}
				}
				else if(!strcmp(cf, "bateria", true))
				{
					if(!strcmp(cf2, "sim", true) && strlen(cf2))
					{
						if(!VehicleLabel[vehicleid][vLabelTime])
						{
							SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADEBATTERY, 30);
							CoreVehicles[vehicleid][vOwnerID] = playerid;
							CoreVehicles[vehicleid][vUpgradeID] = uplevel;
						}
						else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					}
					else
					{
					   	SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / 2.48) + floatround(VehicleData[CarData[carid][carModel] - 400][c_battery] * 13.0)));
					  	SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade bateria {FFFF00}sim");
					}
				}
				else if(!strcmp(cf, "motor", true))
				{
					if(!strcmp(cf2, "sim", true) && strlen(cf2))
					{
						if(!VehicleLabel[vehicleid][vLabelTime])
						{
							SetVehicleLabel(vehicleid, VLT_TYPE_UPGRADEENGINE, 30);
							CoreVehicles[vehicleid][vOwnerID] = playerid;
							CoreVehicles[vehicleid][vUpgradeID] = uplevel;
						}
						else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
					}
					else
					{
					   	SendClientMessageEx(playerid, COLOR_YELLOW, "Esta operação requer %s", FormatNumber(floatround(VehicleData[CarData[carid][carModel] - 400][c_price] / 1.72) + floatround(VehicleData[CarData[carid][carModel] - 400][c_engine] * 13.0)));
					  	SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade motor {FFFF00}sim");
					}
				}
				else
				{
	             	SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo upgrade [upgrade] [upgrade-level]");
	                SendClientMessage(playerid, COLOR_YELLOW3, "[UPGRADES] trava, alarme, imobilizador, seguro, armour");
	                SendClientMessage(playerid, COLOR_YELLOW3, "[UPGRADES] bateria, motor (( Esta opção substitui o original. ))");
				}
		    }
		    else SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve estar no veículo que foi chamado.");
		}
		else SendServerMessage(playerid, "Você não está perto de uma concessionária.");
	}
	else if(!strcmp(type, "sucatear", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

		carid = PlayerData[playerid][pCarKeys][carkey];

	    new scrap_price = VehicleData[GetVehicleModel(vehicleid) - 400][c_scrap];

	    if(!scrap_price)
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Preço do veículo incorreto, entre em contato com um administrador.");

		if(!strcmp(cf, "sim", true) && strlen(cf))
		{
			mysql_format(dbCon, query, sizeof(query), "DELETE FROM `cars` WHERE `carID` = '%d' LIMIT 1", CarData[carid][carID]);
			mysql_tquery(dbCon, query, "OnPlayerVehicleScrap", "ddd", playerid, carid, scrap_price);
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Você escolheu enviar seu veículo para o entulho.");
			SendClientMessageEx(playerid, COLOR_YELLOW3, "SERVER: Você receberá apenas %s Dos escombros", FormatNumber(scrap_price));
			SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: Quando você destrói um entulho, o veículo será removido do existente.");
			//SendClientMessageEx(playerid, COLOR_YELLOW3, "SERVER: You will get just %s From the debris", FormatNumber(scrap_price));
			//SendClientMessage(playerid, COLOR_YELLOW3, "SERVER: When you destroy a debris the vehicle will be removed from the existing.");
			SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo sucatear sim");
		}
	}
	else if(!strcmp(type, "comprar", true))
	{
	    new id = -1;

		if((id = Business_Nearest(playerid)) != -1 && BusinessData[id][bType] == 4)
		{
            ShowPlayerDealershipMenu(playerid);
		}
		else SendClientMessage(playerid, COLOR_GRAD1, "Você não está em uma concessionária.");
	}
	else if(!strcmp(type, "encontrar", true))
	{
	    new count, last;

		for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
		{
			if(PlayerData[playerid][pCarKeys][i] != 9999)
			{
				last = i, count++;
			}
		}

		if(!count) return SendServerMessage(playerid, "Você não tem nenhum veículo spawnado");

		if(count == 1)
		{
		    carid = PlayerData[playerid][pCarKeys][last], vehicleid = CarData[carid][carVehicle];

		    if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID || VehicleLabel[vehicleid][vLabelTime])
		        return SendClientMessage(playerid, COLOR_LIGHTRED, "Tem alguém no seu carro, não conseguimos encontrar!");

			new
				Float:vehDistance[3]
			;

			GetVehiclePos(vehicleid, vehDistance[0], vehDistance[1], vehDistance[2]);
			SetPlayerCheckpoint(playerid, vehDistance[0], vehDistance[1], vehDistance[2], 4.0);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_VEH;
		}
		else
		{
			new
				keyid
			;

			if(sscanf(cf, "d", keyid))
			{
				SendClientMessage(playerid, COLOR_YELLOW3, "Você tem vários veículos spawnados.");
				SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo encontrar vehicleid");

				for(new i = 0; i < last + 1; ++i)
				{
					if(PlayerData[playerid][pCarKeys][i] != 9999)
					{
						SendClientMessageEx(playerid, COLOR_YELLOW3, "ID:%d (vehicleid :%d) - %s", i + 1, CarData[ PlayerData[playerid][pCarKeys][i] ][carVehicle], ReturnVehicleName(CarData[ PlayerData[playerid][pCarKeys][i] ][carVehicle]));
					}
				}

				return true;
			}

			if(keyid < 1 || keyid > 6)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid key ID.");

			keyid--;

			if(PlayerData[playerid][pCarKeys][keyid] == 9999)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid note.");

		    carid = PlayerData[playerid][pCarKeys][keyid], vehicleid = CarData[carid][carVehicle];

		    if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID || VehicleLabel[vehicleid][vLabelTime])
		        return SendClientMessage(playerid, COLOR_LIGHTRED, "Tem alguém no seu carro, não conseguimos encontrar!");

			new
				Float:vehDistance[3]
			;

			GetVehiclePos(vehicleid, vehDistance[0], vehDistance[1], vehDistance[2]);
			SetPlayerCheckpoint(playerid, vehDistance[0], vehDistance[1], vehDistance[2], 4.0);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_VEH;
		}
	}
	else if(!strcmp(type, "estacionar", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

	    carid = PlayerData[playerid][pCarKeys][carkey];

		if(IsPlayerInRangeOfPoint(playerid, 4.0, CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]))
		{
		    SendClientMessage(playerid, COLOR_GREEN, "Veículo estacionado.");

		    RemoveVehicleKey(playerid, carid);

			SaveVehicleDamageID(carid);
			Car_SaveID(carid);
			Car_DespawnEx(carid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "Você tem que estar no local de estacionamento do veículo.");
			SendClientMessage(playerid, 0xFF00FFFF, "Siga o checkpoint.");

			SetPlayerCheckpoint(playerid,CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], 4.0);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_VEH;
		}
	}
	else if(!strcmp(type, "localizacao", true))
	{
	    new vehicleData[2], vehicleName[64], Float:vehDistance[4], rows;

		mysql_format(dbCon, query, sizeof(query), "SELECT `carID`, `carModel`, `carName`, `carPosX`, `carPosY`, `carPosZ` FROM `cars` WHERE `carOwner` = '%d'", PlayerData[playerid][pID]);
		new Cache:cache = mysql_query(dbCon, query);

		cache_get_row_count(rows);

		if(!rows)
		{
			cache_delete(cache);

			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não possui nenhum veículo.");
		}

		for(new i = 0; i < rows; ++i)
		{
		    cache_get_value_name_int(i, "carID", vehicleData[0]);
			cache_get_value_name_int(i, "carModel", vehicleData[1]);

			cache_get_value_name(i, "carName", vehicleName, 64);

			cache_get_value_name_float(i, "carPosX", vehDistance[0]);
			cache_get_value_name_float(i, "carPosY", vehDistance[1]);
			cache_get_value_name_float(i, "carPosZ", vehDistance[2]);

			if(strlen(vehicleName) >= 3)
				SendClientMessageEx(playerid, COLOR_GREEN, "O seu %s (#%d) esta localizado em %s, San Andreas.", vehicleName, vehicleData[1], ReturnDynamicAddress(vehDistance[0], vehDistance[1]));
			else
				SendClientMessageEx(playerid, COLOR_GREEN, "Oseu %s (#%d) esta localizado em %s, San Andreas.", ReturnVehicleModelNameEx(vehicleData[1]), vehicleData[1], ReturnDynamicAddress(vehDistance[0], vehDistance[1]));
		}

		cache_delete(cache);
	}
	else if(!strcmp(type, "comprarvaga", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

	    new Float:vehicleHealth;
	    GetVehicleHealth(vehicleid, vehicleHealth);

	    if(vehicleHealth < 300)
	        return SendServerMessage(playerid, "Seu veículo está muito danificado. A operação não pode ser concluída.");

	    new bool:housepark = false, Float:vehDistance[4];

		carid = PlayerData[playerid][pCarKeys][carkey];

		/*mysql_format(dbCon, query, sizeof(query), "SELECT `carPosX`, `carPosY`, `carPosZ` FROM `cars`");
		new Cache:cache = mysql_query(dbCon, query);

		cache_get_row_count(rows);

		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_float(i, 0, vehDistance[0]);
			cache_get_value_index_float(i, 1, vehDistance[1]);
			cache_get_value_index_float(i, 2, vehDistance[2]);

			if(IsPlayerInRangeOfPoint(playerid, 4.5, vehDistance[0], vehDistance[1], vehDistance[2]))
			{
				checked = true;
				break;
			}
		}

		cache_delete(cache);

		if(checked) return SendServerMessage(playerid, "Parking is too close to another vehicle spawn position, change location.");*/

		foreach (new i : Property)
		{
		    if(!PropertyData[i][hOwned]) continue;

		    if(PropertyData[i][hOwnerSQLID] == PlayerData[playerid][pID])
		    {
				if(IsPlayerInRangeOfPoint(playerid, 20.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
				{
					housepark = true;
					break;
				}
			}
		}

		if(!housepark)
		{
			new
				input[32]
			;

			sscanf(cf, "s[32]", input);

			if(strcmp(input, "sim", false) != 0)
				return SendSyntaxMessage(playerid, "Este lugar de estacionamento custa $2,500, digite 'sim' depois de comprarvaga para confirmar.");

			if(PlayerData[playerid][pCash] < 2500)
				return SendErrorMessage(playerid, "Você não tem dinheiro suficiente.");
		}

		GetVehiclePos(vehicleid, vehDistance[0], vehDistance[1], vehDistance[2]);
		GetVehicleZAngle(vehicleid, vehDistance[3]);

		CarData[carid][carPos][0] = vehDistance[0];
		CarData[carid][carPos][1] = vehDistance[1];
		CarData[carid][carPos][2] = vehDistance[2];
		CarData[carid][carPos][3] = vehDistance[3];

		if(!housepark)
		{
		    TakePlayerMoney(playerid, 2500);

			SendClientMessage(playerid, COLOR_GREEN, "Vaga de estacionamento adquirida por $2500 (Taxa do local).");
		}
		else SendClientMessage(playerid, COLOR_GREEN, "Vaga de estacionamento adquirida GRATUITAMENTE (Taxa do local).");

		SaveVehicleDamageID(carid);
		Car_SaveID(carid);
	}
	else if(!strcmp(type, "status", true))
	{
	    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

		carid = PlayerData[playerid][pCarKeys][carkey];

	    new
	        userid
		;

		if(sscanf(cf, "u", userid))
		{
		    Car_PrintStats(playerid, carid);
		}
		else
		{
			if(!IsPlayerConnected(userid))
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

			if(!IsPlayerNearPlayer(playerid, userid, 5.0))
				return SendErrorMessage(playerid, "Você não está perto daquele jogador.");

            Car_PrintStats(userid, carid);
		}
	}
	else if(!strcmp(type, "registrar", true))
	{
		if(PlayerData[playerid][pCash] < 100)
			return SendClientMessage(playerid, COLOR_YELLOW3, "Esta operação requer $100");

		new id = -1;

		if((id = Business_Nearest(playerid)) != -1 && BusinessData[id][bType] == 4)
		{
		    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

		    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
		        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

			carid = PlayerData[playerid][pCarKeys][carkey];

			if(!VehicleLabel[vehicleid][vLabelTime])
			{
		        SetVehicleLabel(vehicleid, VLT_TYPE_REGISTER, 10);
				CoreVehicles[vehicleid][vOwnerID] = playerid;
			}
			else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
		}
		else SendClientMessage(playerid, COLOR_GRAD1, "Você não está em uma concessionária.");
	}
	else if(!strcmp(type, "removerplaca", true))
	{
	    if(IsAtBlackMarket(playerid))
		{
		    vehicleid = GetPlayerVehicleID(playerid), carkey = GetVehicleKeyID(playerid, vehicleid);

		    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || carkey == -1)
		        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

			carid = PlayerData[playerid][pCarKeys][carkey];

			if(!VehicleLabel[vehicleid][vLabelTime])
			{
		    	SetVehicleLabel(vehicleid, VLT_TYPE_UNREGISTER, 10);

				SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: A remoção do registro do veículo começou...");
				CoreVehicles[vehicleid][vOwnerID] = playerid;
			}
			else SendServerMessage(playerid, "Este veículo está atualmente sendo usado.");
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está no mercado negro.");
	}
	else if(!strcmp(type, "rebocar", true))
	{
		if(PlayerData[playerid][pCash] < 2000)
			return SendClientMessage(playerid, COLOR_GRAD1, "Você não tem dinheiro suficiente ($2,000).");

	    new count, last;

		for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
		{
			if(PlayerData[playerid][pCarKeys][i] != 9999)
			{
				last = i, count++;
			}
		}

		if(!count) return SendServerMessage(playerid, "Você não tem nenhum veículo spawnado");

		if(count == 1)
		{
		    carid = PlayerData[playerid][pCarKeys][last], vehicleid = CarData[carid][carVehicle];

		    if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID || VehicleLabel[vehicleid][vLabelTime])
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s está em uso / roubado", g_arrVehicleNames[GetVehicleModel(vehicleid) - 400]);

            if(VehicleLabel[vehicleid][vLabelTime])
                return SendServerMessage(playerid, "O veículo está atualmente sendo operado.");

   			CoreVehicles[vehicleid][vOwnerID] = playerid;
	        SetVehicleLabel(vehicleid, VLT_TYPE_TOWING, 15);

	        SendClientMessage(playerid, COLOR_GREEN, "Solicitação de reboque enviada");
		}
		else
		{
			new
				keyid
			;

			if(sscanf(cf, "d", keyid))
			{
				SendClientMessage(playerid, COLOR_YELLOW3, "Você tem vários veículos spawnados.");
				SendClientMessage(playerid, COLOR_YELLOW3, "USE: /(v)eiculo rebocar vehicleid");

				for(new i = 0; i < last + 1; ++i)
				{
					if(PlayerData[playerid][pCarKeys][i] != 9999)
					{
						SendClientMessageEx(playerid, COLOR_YELLOW3, "ID:%d (vehicleid :%d) - %s", i + 1, CarData[ PlayerData[playerid][pCarKeys][i] ][carVehicle], ReturnVehicleName(CarData[ PlayerData[playerid][pCarKeys][i] ][carVehicle]));
					}
				}

				return true;
			}

			if(keyid < 1 || keyid > 6)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid key ID.");

			keyid--;

			if(PlayerData[playerid][pCarKeys][keyid] == 9999)
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid note.");

		    carid = PlayerData[playerid][pCarKeys][keyid], vehicleid = CarData[carid][carVehicle];

		    if(GetVehicleDriver(vehicleid) != INVALID_PLAYER_ID || VehicleLabel[vehicleid][vLabelTime])
		        return SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s is in use / stolen", g_arrVehicleNames[GetVehicleModel(vehicleid) - 400]);

            if(VehicleLabel[vehicleid][vLabelTime])
                return SendServerMessage(playerid, "O veículo está atualmente sendo operado.");

 			CoreVehicles[vehicleid][vOwnerID] = playerid;
	        SetVehicleLabel(vehicleid, VLT_TYPE_TOWING, 15);

	        SendClientMessage(playerid, COLOR_GREEN, "Solicitação de reboque enviada");
		}
	}
	else if(!strcmp(type, "luzes", true))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	        return SendServerMessage(playerid, "Você tem que estar em um veículo.");

		vehicleid = GetPlayerVehicleID(playerid);

		if(!IsEngineVehicle(vehicleid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você precisa estar em um veículo com motor.");

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não é o motorista.");

		switch (GetLightStatus(vehicleid))
		{
			case false:
			{
			    SetLightStatus(vehicleid, true);
			}
			case true:
			{
				SetLightStatus(vehicleid, false);
			}
		}
	}
	else if(!strcmp(type, "trancar", true))
	{
		if( (IsPlayerInAnyVehicle(playerid) ? ((vehicleid = GetPlayerVehicleID(playerid)) != 0) : ((vehicleid = Car_Nearest(playerid)) != -1)))
		{
	 		new
	 		    id,
			    engine,
			    lights,
			    alarm,
			    doors,
			    bonnet,
			    boot,
			    objective;


		    if((id = Car_GetID(vehicleid)) != -1)
		    {
				if(HasVehicleKey(playerid, id, true))
				{
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

					if(!CarData[id][carLocked])
					{
						CarData[id][carLocked] = true;

	                    format(query, sizeof(query), "~r~%s Trancado", ReturnVehicleModelName(CarData[id][carModel]));
						//PlayerPlaySoundEx(playerid, 24600);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
					}
					else
					{
						CarData[id][carLocked] = false;

	                    format(query, sizeof(query), "~g~%s Destrancado", ReturnVehicleModelName(CarData[id][carModel]));
						GameTextForPlayer(playerid, query, 2000, 4);
						//PlayerPlaySoundEx(playerid, 24600);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, bonnet, boot, objective);
					}
				}
				else
				{
					SendServerMessage(playerid, "Você não pode acessar este veículo.");

					if(CarData[id][carLocked]) SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: If you try to get into: \"/lock br{FFFF00}eakin\"");
				}
		    }
		    else
		    {
                if(IsPlayerInAnyVehicle(playerid))
				{
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

					if(doors != 1)
					{
					    format(query, sizeof(query), "~r~%s Trancado", ReturnVehicleModelName(GetVehicleModel(vehicleid)));
						GameTextForPlayer(playerid, query, 2000, 4);
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					}
					else
					{
					    format(query, sizeof(query), "~g~%s Destrancado", ReturnVehicleModelName(GetVehicleModel(vehicleid)));
						GameTextForPlayer(playerid, query, 2000, 4);
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
					}
				}
				else
				{
				    if(gLastCar[playerid] == vehicleid)
				    {
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

						if(doors != 1)
						{
						    format(query, sizeof(query), "~r~%s Trancado", ReturnVehicleModelName(GetVehicleModel(vehicleid)));
							GameTextForPlayer(playerid, query, 2000, 4);
							SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						}
						else
						{
						    format(query, sizeof(query), "~g~%s Destrancado", ReturnVehicleModelName(GetVehicleModel(vehicleid)));
							GameTextForPlayer(playerid, query, 2000, 4);
							SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						}
				    }
				}

		    }
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Não há veículos perto de você.");
	}
	else SendServerMessage(playerid, "Ação/parâmetro inválido.");

	return true;
}

CMD:capo(playerid, params[])
{
	foreach (new i : StreamedVehicle[playerid])
	{
		if(IsPlayerNearHood(playerid, i) || GetPlayerVehicleID(playerid) == i)
		{
		    if(!IsDoorVehicle(i))
		        return SendClientMessage(playerid, COLOR_LIGHTRED, "Este veículo não tem um capô.");

			if(!GetEngineStatus(i))
			    return SendClientMessage(playerid, COLOR_LIGHTRED, "O motor do veículo deve estar ligado.");

		    if(!GetHoodStatus(i))
			{
		        SetHoodStatus(i, true);

		        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s abriu o cap do %s.", ReturnName(playerid, 0), ReturnVehicleName(i));
			}
			else
			{
				SetHoodStatus(i, false);

		        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s fechou o capô do %s.", ReturnName(playerid, 0), ReturnVehicleName(i));
			}
		    return true;
		}
	}

	SendClientMessage(playerid, COLOR_GRAD1, "   Você deve ficar perto da frente ou no carro.");
	return true;
}

CMD:portamalas(playerid, params[])
{
	foreach (new i : StreamedVehicle[playerid])
	{
		if(IsPlayerNearBoot(playerid, i) || GetPlayerVehicleID(playerid) == i)
		{
		    if(!IsDoorVehicle(i))
		        return SendErrorMessage(playerid, "Este veículo não tem porta-malas.");

			if(IsVehicleTrunkBroken(i))
			{
				SendClientMessage(playerid, COLOR_YELLOW, "(( O porta-malas do carro caiu do chassi.");
				SendClientMessage(playerid, COLOR_YELLOW, "(( Enquanto estiver quebrado/aberto será concedido acesso /pegar e /colocar");
			    return 1;
			}

			if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			    return SendErrorMessage(playerid, "Você não está no banco do motorista.");

			if(GetLockStatus(i))
			    return SendErrorMessage(playerid, "O veículo está trancado.");

		    if(!GetTrunkStatus(i))
			{
		        SetTrunkStatus(i, true);
		        SendClientMessage(playerid, COLOR_YELLOW, "Você abriu o porta-malas");

		        if(IsVehicleTrunk(i)) SendClientMessage(playerid, COLOR_WHITE, "Você pode usar /colocar e /pegar.");

				format(sgstr, sizeof(sgstr), "** %s abriu o portamalas do %s's.", ReturnName(playerid, 0), ReturnVehicleName(i));
			 	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);
			 	SendClientMessage(playerid, COLOR_PURPLE, sgstr);
			}
			else
			{
				SetTrunkStatus(i, false);
				SendClientMessage(playerid, COLOR_YELLOW, "Você fechou o porta-malas");

				format(sgstr, sizeof(sgstr), "** %s fechou o porta-malas do %s's.", ReturnName(playerid, 0), ReturnVehicleName(i));
			 	SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);
			 	SendClientMessage(playerid, COLOR_PURPLE, sgstr);
			}
		    return true;
		}
	}

	SendServerMessage(playerid, "Você não está dentro ou perto de um veículo.");
	return true;
}

stock IsVehicleTrunkBroken(vehicleid)
{
	new damage1, damage2, damage3, damage4;
  	GetVehicleDamageStatus(vehicleid, damage1, damage2, damage3, damage4);
	return (damage2 >>> 8 & 15) >= 4 ? true:false;
}

stock IsVehicleTrunk(vehicleid)
{
	new model = GetVehicleModel(vehicleid);

	switch(model)
	{
	    case 415,517,525,473,541,545,542,562,480,475,603,402,559,474,500,401,410,589,532,496,491,526,536,549,518,436: return 10;
	    case 492,445,405,438,426,421,467,507,550,585,604,404,546,547,422,551,420,596,597,412,533,419,600,534,575,540,516,529,561,483: return 15;
	    case 580,479,567,560,535,554,478,566,446,430,601,497,487,488: return 20;
	    case 579,400,489,418,409,453,599,423: return 25;
	    case 431,582,482,508,417,408,588,454,416,490,427: return 30;
	}

	return 0;
}

CMD:cheque(playerid, params[])
{
	new tmp[32], tmp2[32], query[256];

	if(sscanf(params, "s[32]S()[32]", tmp, tmp2))
	{
		SendClientMessage(playerid,COLOR_LIGHTRED,"/cheque [param]");
		//SendClientMessage(playerid,COLOR_WHITE,"/cheque rip - Destroy the current check that you created.");
        SendClientMessage(playerid,COLOR_WHITE,"/cheque display - Check by the check or check all you have in it.");
        SendClientMessage(playerid,COLOR_WHITE,"/cheque give - Make your check with someone else.");
        SendClientMessage(playerid,COLOR_WHITE,"/cheque cash - Check Cash");
        SendClientMessage(playerid,COLOR_WHITE,"/cheque paycheck - receive Paycheck from your career");
		return true;
	}

	if(strcmp(tmp,"display",true) == 0)
	{
	    new
			string[32]
		;

		if(sscanf(tmp2, "s[32]", string))
			return SendClientMessage(playerid,COLOR_LIGHTRED,"/cheque display all or chequeID");

        if(strcmp(string,"all",true) == 0)
		{
			format(query,sizeof(query),"SELECT * FROM cheques WHERE owner_ID = '%d' ORDER BY id ASC", PlayerData[playerid][pID]);
			new Cache:cache = mysql_query(dbCon, query);

			if(cache_num_rows())
			{
			    new playername[MAX_PLAYER_NAME+1], rec[MAX_PLAYER_NAME+1], sen[MAX_PLAYER_NAME+1], code[64], amount, id;

			    GetPlayerName(playerid, playername, sizeof(playername));

			    for(new i = 0; i != cache_num_rows(); ++i)
			    {
				    cache_get_value_name(i, "sender", sen);
				    cache_get_value_name(i, "reciever", rec);
				    cache_get_value_name(i, "code", code);
					cache_get_value_name_int(i, "amount", amount);
					cache_get_value_name_int(i, "id", id);

                    SendClientMessage(playerid,COLOR_YELLOW3, "-------------------------------------------------------------------------------");
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|_Check_ID:_%06d_|", id);
                    SendClientMessage(playerid,COLOR_YELLOW3, "|_BANK OF LOS SANTOS - Los Santos, San Andress.");
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|_Pay to the order of: %s |_ From: %s", rec, sen);
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|____  To the sum of: $%d", amount);
                    SendClientMessage(playerid,COLOR_YELLOW3, "| Signature: Towards your efforts n the agency.");
                    SendClientMessage(playerid,COLOR_YELLOW3, "-------------------------------------------------------------------------------");

                    if(!strcmp(playername, rec, true))
                    {
                    	SendClientMessageEx(playerid, COLOR_YELLOW3,   "|=== Code: %s", code);
                    }
			    }
			}

			cache_delete(cache);
		}
		else
		{
			if(IsNumeric(string))
			{
				format(query,sizeof(query),"SELECT * FROM cheques WHERE owner_ID = '%d' AND id = '%s'", PlayerData[playerid][pID], string);
				new Cache:cache = mysql_query(dbCon, query);

				if(cache_num_rows())
				{
				    new playername[MAX_PLAYER_NAME+1], rec[MAX_PLAYER_NAME+1], sen[MAX_PLAYER_NAME+1], code[64];

				    cache_get_value_name(0, "sender", sen);
				    cache_get_value_name(0, "reciever", rec);
				    cache_get_value_name(0, "code", code);

					new amount;
					cache_get_value_name_int(0, "amount", amount);

                    SendClientMessage(playerid,COLOR_YELLOW3, "-------------------------------------------------------------------------------");
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|_Check_ID:_%06d_|", strval(string));
                    SendClientMessage(playerid,COLOR_YELLOW3, "|_BANK OF LOS SANTOS - Los Santos, San Andress.");
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|_Pay to the order of: %s |_ From: %s", rec, sen);
                    SendClientMessageEx(playerid,COLOR_YELLOW3,   "|____  To the sum of: $%d", amount);
                    SendClientMessage(playerid,COLOR_YELLOW3, "| Signature: Towards your efforts n the agency.");
                    SendClientMessage(playerid,COLOR_YELLOW3, "-------------------------------------------------------------------------------");

                    GetPlayerName(playerid, playername, sizeof(playername));
                    if(!strcmp(playername, rec, true))
                    {
                    	SendClientMessageEx(playerid,COLOR_YELLOW3,   "|=== Code: %s", code);
                    }
				}

				cache_delete(cache);
			}
		}
		return true;

	}
	else if(strcmp(tmp,"paycheck",true) == 0)
	{
	    if(PlayerData[playerid][pLocal] != 502 && PlayerData[playerid][pLocal] != 503 && PlayerData[playerid][pLocal] != 504)
			return SendClientMessage(playerid, COLOR_GREY, "   You are not at the bank!");

	    new
			string[16]
		;

		if(sscanf(tmp2, "s[16]", string))
			return SendClientMessage(playerid,COLOR_LIGHTRED,"/cheque paycheck yes to confirm");

        if(strcmp(string, "yes", true) == 0)
		{
            printf("paycheck yes");
		}
		return true;
	}
	else if(strcmp(tmp,"cash",true) == 0)
	{
	    if(PlayerData[playerid][pLocal] != 502 && PlayerData[playerid][pLocal] != 503 && PlayerData[playerid][pLocal] != 504)
			return SendClientMessage(playerid, COLOR_GREY, "   You are not at the bank!");

		new
			chequeid
		;

		if(sscanf(tmp2, "d", chequeid))
			return SendClientMessage(playerid,COLOR_LIGHTRED,"/cheque cash chequeID");

		format(query,sizeof(query),"SELECT * FROM cheques WHERE owner_ID = '%d' AND id = '%d'", PlayerData[playerid][pID], chequeid);
		new Cache:cache = mysql_query(dbCon, query);

		if(cache_num_rows())
		{
			new playername[MAX_PLAYER_NAME+1], rec[MAX_PLAYER_NAME+1], sen[MAX_PLAYER_NAME+1], code[64];

			cache_get_value_name(0, "sender", sen);
			cache_get_value_name(0, "reciever", rec);
			cache_get_value_name(0, "code", code);

          	GetPlayerName(playerid, playername, sizeof(playername));

          	if(!strcmp(playername, rec, true))
          	{
          	    new amount;
				cache_get_value_name_int(0, "amount", amount);

				PlayerData[playerid][pChequeCash] += amount;

				SendClientMessage(playerid, COLOR_WHITE, "|___ BANK STATEMENT ___|");
				SendClientMessageEx(playerid, COLOR_FADE1, "  Check number: %06d", chequeid);
				SendClientMessageEx(playerid, COLOR_FADE1, "  Paid to: %s", rec);
				SendClientMessageEx(playerid, COLOR_FADE1, "  From: %s", sen);
				SendClientMessage(playerid, COLOR_WHITE, "|-----------------------------------------|");
				SendClientMessageEx(playerid, COLOR_WHITE, "  Totals: $%d", amount);
          	    SendClientMessage(playerid,COLOR_WHITE, "You will be paid in next Paycheck ");

				format(query, sizeof(query), "DELETE FROM `cheques` WHERE `id` = '%d'", chequeid);
				mysql_pquery(dbCon, query);
           	}
           	else // Need Code
           	{
           	    new
				   string[16],
				   pass[64]
	   			;

           	    if(sscanf(tmp2, "s[16]s[64]", string, pass))
				   	return SendClientMessage(playerid,COLOR_LIGHTRED,"/cheque cash chequeID code [pass]");

				if(strcmp(string,"code",true) == 0)
				{
				    if(!strcmp(code, pass, true))
				    {
		          	    new amount;
						cache_get_value_name_int(0, "amount", amount);
						PlayerData[playerid][pChequeCash] += amount;

						SendClientMessage(playerid, COLOR_WHITE, "|___ BANK STATEMENT ___|");
						SendClientMessageEx(playerid, COLOR_FADE1, "  Check number: %06d", chequeid);
						SendClientMessageEx(playerid, COLOR_FADE1, "  Paid to: %s", rec);
						SendClientMessageEx(playerid, COLOR_FADE1, "  From: %s", sen);
						SendClientMessage(playerid, COLOR_WHITE, "|-----------------------------------------|");
						SendClientMessageEx(playerid, COLOR_WHITE, "  Total: $%d", amount);
		          	    SendClientMessage(playerid,COLOR_WHITE, "You will be paid in next Paycheck");

						format(query, sizeof(query), "DELETE FROM `cheques` WHERE `id` = '%d'", chequeid);
						mysql_pquery(dbCon, query);
				    }
				}
			}
		}

		cache_delete(cache);
	}
	return true;
}

CMD:boombox(playerid, params[])
{
	new
	    name[16], giveplayerid;

	if(sscanf(params, "s[16]U(65535)", name, giveplayerid))
 	{
		SendSyntaxMessage(playerid, "/boombox [place/take/grant/adjust]");
		return true;
	}

	if(!strcmp(name, "place", true))
	{
	    if(!PlayerData[playerid][pBoombox])
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "You do not have Boombox");

	    if(BoomboxData[playerid][boomboxPlaced])
	        return SendClientMessage(playerid, COLOR_GRAD3, "You have put Boombox");

		if(IsPlayerInAnyVehicle(playerid) || GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0 || Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "You can not place a Boombox in this area.");

		Boombox_Place(playerid);

		SendClientMessage(playerid, COLOR_GREEN, "[SERVER] use /setstation Near the larynx");
		SendClientMessage(playerid, COLOR_GREEN, "[SERVER] use /boombox take to keep it from the ground");
	}
	else if(!strcmp(name, "take", true))
	{
		if(Boombox_Nearest(playerid, 5.0) == playerid)
		{
            Boombox_Destroy(playerid);
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] Sorry, you are not near your Boombox.");
		}
	}
	/*else if(!strcmp(name, "give", true))
	{
	    new userid = INVALID_PLAYER_ID;

		if(!PlayerData[playerid][pBoombox])
	   		return SendClientMessage(playerid, COLOR_LIGHTRED, "You do not have Boombox");

		if(sscanf(params, "s[16]u", name, userid))
	 	{
			SendSyntaxMessage(playerid, "/boombox give [ID]");
			return true;
		}

		if(userid == INVALID_PLAYER_ID && GetPlayerMaskID(userid) == INVALID_PLAYER_ID)
	         	return SendClientMessage(playerid, COLOR_GRAD1, "   The specified player is not connected to the server.");

		if(userid == playerid)
			return SendClientMessage(playerid, COLOR_GRAD1, "   Can't Give yourself!");



	}*/
	else if(!strcmp(name, "grant", true))
	{
		//new giveplayerid = INVALID_PLAYER_ID;

		if(sscanf(params, "{s[16]}u", giveplayerid))
	 	{
			SendSyntaxMessage(playerid, "/boombox grant [ID]");
			return true;
		}

		if(giveplayerid == INVALID_PLAYER_ID) {
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "{s[16]}s[24]", maskid);
			if((giveplayerid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID) {
				return SendClientMessage(playerid, COLOR_GRAD1, "   The player cannot be found near you!");
			}
		}

		if(!IsPlayerNearPlayer(playerid, giveplayerid, 5.0))
			return SendClientMessage(playerid, COLOR_GRAD1, "   The player cannot be found near you!");

		if(giveplayerid == playerid)
			return SendClientMessage(playerid, COLOR_GRAD1, "   You cannot use it for yourself!");

		if(grantboombox[giveplayerid]==playerid) {
		    grantboombox[giveplayerid]=INVALID_PLAYER_ID;
			SendClientMessageEx(playerid, COLOR_WHITE, "You do not allow %s radio station changed", ReturnName(giveplayerid, 0));
			SendClientMessageEx(giveplayerid, COLOR_WHITE, "%s it is not allowed to change radio stations.", ReturnName(playerid, 0));
		}
		else
		{
			grantboombox[giveplayerid]=playerid;
			SendClientMessageEx(playerid, COLOR_WHITE, "You allow %s change your radio station", ReturnName(giveplayerid, 0));
			SendClientMessageEx(giveplayerid, COLOR_WHITE, "%s allows you to change his radio station", ReturnName(playerid, 0));
			SendClientMessage(giveplayerid, COLOR_GREEN, "The instructions: use /setstation");
		}
	}
	else if(!strcmp(name, "adjust", true))
	{
		if(Boombox_Nearest(playerid, 5.0) == playerid)
		{
			SetPVarInt(playerid, "BoomboxAdjust", 1);
			EditDynamicObject(playerid, BoomboxData[playerid][boomboxObject]);
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] Sorry, you're not near your boombox.");
		}
	}

	return true;
}

CMD:gascan(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GREY, "You must be outside of the vehicle");

	new vehicleid = -1;

	if((vehicleid = Car_Nearest(playerid)) != -1)
	{
		if(PlayerData[playerid][pGasCan])
		{
	        if(!GetLockStatus(vehicleid))
			{
				new Float:maxfuel = GetVehicleDataFuel(GetVehicleModel(vehicleid));

				if(CoreVehicles[vehicleid][vehFuel] < maxfuel)
				{
				    CoreVehicles[vehicleid][vehFuel] += 3.0;

				    if(CoreVehicles[vehicleid][vehFuel] > maxfuel)
					{
				        CoreVehicles[vehicleid][vehFuel] = maxfuel;
				    }
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "More fuel is not available.");
		    }
			else SendErrorMessage(playerid, "Vehicle is locked.");
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "You do not have a Gas Can");
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, " ..There are no vehicles near you.");

	return true;
}

stock IsPlayerDrinking(playerid)
{
	switch(GetPlayerSpecialAction(playerid))
	{
	    case SPECIAL_ACTION_DRINK_SPRUNK:
			return true;
	    case SPECIAL_ACTION_DRINK_BEER:
			return true;
	    case SPECIAL_ACTION_DRINK_WINE:
			return true;
	    default:
			return false;
	}
	return false;
}

YCMD:givedrink(playerid, params[], help) = passbottle;
YCMD:passdrink(playerid, params[], help) = passbottle;

CMD:passbottle(playerid, params[])
{
	new userid, emote[64];

	if(sscanf(params, "uS()[64]", userid, emote))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /passbottle [id/nome] [optional: emote]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Not close enough.");

	if(!IsPlayerDrinking(playerid))
	    return SendErrorMessage(playerid, "You aren't drinking anything.");

	SetPlayerSpecialAction(userid, GetPlayerSpecialAction(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);

	if(strlen(emote) > 0)
	    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid, 0), emote);
	else
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s passes their drink to %s.", ReturnName(playerid, 0), ReturnName(userid, 0));

	SendClientMessageEx(playerid, COLOR_YELLOW, "Your drink was passed to %s", ReturnName(userid, 0));
	SendClientMessageEx(userid, COLOR_YELLOW, "%s passed you a drink.", ReturnName(playerid, 0));

	SendClientMessage(userid, COLOR_WHITE, "[ ! ] Hint: Press ENTER to stop drinking.");
	return true;
}

CMD:bdrink(playerid, params[])
{
	new
	    drink
	;

	if(sscanf(params, "d", drink))
 	{
		SendSyntaxMessage(playerid, "/bdrink [drink #]");
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] Available drinks: 1| Sprunk, 2| Beer, 3|Wine");
		return true;
	}

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be on foot to perform this action.");

    if(!PlayerData[playerid][pDrink])
		return SendClientMessage(playerid, COLOR_LIGHTRED, " You do not have any bottles of drinks.");

	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_NONE)
	    return SendErrorMessage(playerid, "You can't do this now.");

	switch(drink)
	{
	    case 1:
	    {
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);

			PlayerData[playerid][pDrink]--;

	        SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Press ENTER to stop drinking. You can use /passdrink to give it to a friend.");
	    }
	    case 2:
	    {
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);

			PlayerData[playerid][pDrink]--;

			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Press ENTER to stop drinking. You can use /passdrink to give it to a friend.");
	    }
	    case 3:
	    {
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);

			PlayerData[playerid][pDrink]--;

			SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Press ENTER to stop drinking. You can use /passdrink to give it to a friend.");
	    }
	    default: SendErrorMessage(playerid, "Invalid drink ID. See /bdrink for a list.");
	}

	return true;
}

CMD:mascara(playerid, params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendErrorMessage(playerid, "Você não pode usar uma máscara na prisão.");

    if(!PlayerData[playerid][pHasMask] && PlayerData[playerid][pAdmin] < 1 && !HasDonatorRank(playerid, 1))
        return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem uma máscara.");

    if(!IsMasked{playerid})
    {
        GameTextForPlayer(playerid, "~p~VOCE COLOCOU A MASCARA", 3000, 3);

        format(PlayerData[playerid][pMask_Name], MAX_PLAYER_NAME, "%i_%i", PlayerData[playerid][pMaskID][0], PlayerData[playerid][pMaskID][1]);

		IsMasked{playerid} = true;

		if(HasDonatorRank(playerid, 1)) ShowMaskTextdraw(playerid);

		foreach (new i : Player)
	    {
			if(i != playerid)
		    {
				RefreshMaskStatus(playerid, i);
			}
   		}

	    SQL_LogMask(playerid, "masked", PlayerData[playerid][pMask_Name]);
	}
    else
    {
        GameTextForPlayer(playerid, "~p~VOCE REMOVEU A MASCARA", 3000, 3);

        IsMasked{playerid} = false;

		foreach (new i : Player)
  		{
	        if(i != playerid)
	        {
				RefreshMaskStatus(playerid, i);
			}
        }

		HideMaskTextdraw(playerid);

		PlayerData[playerid][pMask_Name][0] = EOS;
    }
	return true;
}

CMD:telapreta(playerid, params[])
{
	if(!Blindfold{playerid})
 	{
        Blindfold{playerid} = true;

        PlayerTextDrawShow(playerid, blindfold[playerid]);
	}
	else
	{
	    Blindfold{playerid} = false;

		PlayerTextDrawHide(playerid, blindfold[playerid]);
	}
	return true;
}

CMD:tognicks(playerid, params[])
{
	if(!ToggleNames{playerid})
	{
	    ToggleNames{playerid} = true;

	    SendNoticeMessage(playerid, "Nametags turned {FF6347}OFF{FFFFFF}.");

		foreach (new i : Player)
		{
			if(i != playerid)
			{
				ShowPlayerNameTagForPlayer(playerid, i, false);
			}
		}
	}
	else
	{
	    ToggleNames{playerid} = false;

	    SendNoticeMessage(playerid, "Nametags turned {FF6347}ON{FFFFFF}.");

		foreach (new i : Player)
		{
			if(i != playerid)
			{
				RefreshMaskStatus(i, playerid);
			}
		}
	}
	return true;
}

CMD:ans(playerid, params[])
{
	if(CanAdvertise(playerid) == -1)
	    return SendErrorMessage(playerid, "Você deve estar na área de anúncios para olhar a lista de anúncios.");

	ShowAdvertisementList(playerid);
	return true;
}

ShowAdvertisementList(playerid)
{
	new count = 0;

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "#\tAdvert\tAirs In\n");

	for(new i = MAX_AD_QUEUE - 1; i >= 0; i--)
	{
		if(AdvertData[i][ad_id])
		{
			if(strlen(AdvertData[i][ad_text]) > 86)
				format(gstr, sizeof(gstr), "%s\n{FFFFFF}%d\t%.86s...\t~%ds", gstr, i + 1, AdvertData[i][ad_text], AdvertData[i][ad_time]); //%.28s
			else
				format(gstr, sizeof(gstr), "%s\n{FFFFFF}%d\t%s\t~%ds", gstr, i + 1, AdvertData[i][ad_text], AdvertData[i][ad_time]);

			count++;				
		}
	}	

	if(!count) return Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "View Advertisements", "No advertisements", "Okay", "");

	Dialog_Show(playerid, AdvertiseDialog, DIALOG_STYLE_TABLIST_HEADERS, "View Advertisements", gstr, "Okay", "");	
	return true;
}

YCMD:anuncio(playerid, params[], help) = an;

CMD:an(playerid, params[])
{
	new id = -1;

	if((id = CanAdvertise(playerid)) == -1)
	    return SendErrorMessage(playerid, "Você deve estar no local de anúncios para postar um anúncio.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/an [texto]");

	if(!PlayerData[playerid][pPnumber])
	    return SendErrorMessage(playerid, "Você não tem um celular.");

	if(adTick[playerid])
	    return SendErrorMessage(playerid, "Você deve esperar %d segundos antes de utilizar novamente.", adTick[playerid]);

	new price, players = Iter_Count(Player);

	if(PlayerData[playerid][pADPoint] > 2) price = 1500;
	else if(PlayerData[playerid][pADPoint] > 4) price = 2000;
	else if(PlayerData[playerid][pADPoint] > 6) price = 2500;
	else price = 1000;

	price += players * 250;

    if(PlayerData[playerid][pCash] < price)
        return SendErrorMessage(playerid, "Você não tem dinheiro.");

	new exists = -1;

	for(new i = 0; i != MAX_AD_QUEUE; ++i)
	{
		if(!AdvertData[i][ad_id])
		{
			exists = i;
			break;
		}
	}

	if(exists == -1 || (CountPlayerAdvert(playerid) && !PlayerData[playerid][pDonateRank]))
	    return SendErrorMessage(playerid, "A fila está cheia ou você já tem um anúncio na fila.");

	TakePlayerMoney(playerid, price);

	SendClientMessage(playerid, COLOR_GREEN, "Você enviou um anúncio para a fila! (/ans para verificar quando ele irá ao ar)");

	AdvertData[exists][ad_time] = 60 * (CountAdvert() + 1);

	mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO advertisement (charid, text, time) VALUES('%d', '%e', '%d')", PlayerData[playerid][pID], params, gettime() + AdvertData[exists][ad_time]);
	new Cache:cache = mysql_query(dbCon, gquery);

	AdvertData[exists][ad_id] = cache_insert_id();

	cache_delete(cache);

	AdvertData[exists][ad_owner] = playerid;
	format(AdvertData[exists][ad_text], 128, "%s", params);
	AdvertData[exists][ad_type] = 0;

	Iter_Add(sv_activevehicles, exists);

	PlayerData[playerid][pADPoint]++;

	if(PlayerData[playerid][pDonateRank] > 1)
	{
		adTick[playerid] = 30;
	}
	else adTick[playerid] = 60;

	BusinessData[id][bProducts] --;
	BusinessData[id][bTill] += floatround(price * 0.7);

	Business_Save(id);
	return true;
}

CMD:anemp(playerid, params[])
{
	new id = -1;

	if((id = CanAdvertise(playerid)) == -1)
	    return SendErrorMessage(playerid, "You must be at the advertisment area to post an advertisment.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/anemp [empresa-texto]");

	if(!PlayerData[playerid][pPnumber])
	    return SendErrorMessage(playerid, "Você não tem um celular.");

	if(adTick[playerid])
	    return SendErrorMessage(playerid, "Você deve esperar %d segundos antes de utilizar novamente.", adTick[playerid]);

	new price, players = Iter_Count(Player);

	price = 5000 + players * 500;

    if(PlayerData[playerid][pCash] < price)
        return SendErrorMessage(playerid, "Você não tem dinheiro.");

	new exists = -1;

	for(new i = 0; i != MAX_AD_QUEUE; ++i)
	{
		if(!AdvertData[i][ad_id])
		{
			exists = i;
			break;
		}
	}

	if(exists == -1 || (CountPlayerAdvert(playerid) && !PlayerData[playerid][pDonateRank]))
	    return SendErrorMessage(playerid, "A fila está cheia ou você já tem um anúncio na fila.");

	TakePlayerMoney(playerid, price);

	SendClientMessage(playerid, COLOR_GREEN, "Você enviou um anúncio para a fila! (/ans para verificar quando ele irá ao ar)");

	AdvertData[exists][ad_time] = 60 * (CountAdvert() + 1);

	mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO advertisement (charid, text, time) VALUES('%d', '%e', '%d')", PlayerData[playerid][pID], params, gettime() + AdvertData[exists][ad_time]);
	new Cache:cache = mysql_query(dbCon, gquery);

	AdvertData[exists][ad_id] = cache_insert_id();

	cache_delete(cache);

	AdvertData[exists][ad_owner] = playerid;
	format(AdvertData[exists][ad_text], 128, "%s", params);
	AdvertData[exists][ad_type] = 1;

	Iter_Add(sv_activevehicles, exists);

	PlayerData[playerid][pADPoint]++;

	if(PlayerData[playerid][pDonateRank] > 1)
	{
		adTick[playerid] = 30;
	}
	else adTick[playerid] = 60;

	BusinessData[id][bProducts] --;
	BusinessData[id][bTill] += floatround(price * 0.7);

	Business_Save(id);
	return true;
}

CMD:modmenu(playerid, params[])
{
	if(PlayerData[playerid][pInTuning])
		return SendErrorMessage(playerid, "You already in tuning.");

	if(IsPlayerInRangeOfPoint(playerid, 5, EXTERIOR_TUNING_X, EXTERIOR_TUNING_Y, EXTERIOR_TUNING_Z) == 0)
		return SendErrorMessage(playerid, "You are not in Wang's Car.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You must be driver.");

	new vehID = GetPlayerVehicleID(playerid);

	if(IsABike(vehID) > 0 || IsAMotorBike(vehID) > 0)
		return SendErrorMessage(playerid, "This vehicle can not be modded..");

	if(!PlayerOwnsVehicle(playerid, vehID))
		return SendErrorMessage(playerid, "You don't own this vehicle.");

	foreach (new i : VehicleOccupant(vehID))
	{
		if(i != playerid)
		{
			return SendErrorMessage(playerid, "There's someone in your car.");
		}
	}

	SetPlayerCameraPos(playerid, 441.1662, -1302.0037, 18.0385);
	SetPlayerCameraLookAt(playerid, 440.2185, -1301.6881, 17.6184);

	SetVehiclePos(vehID, INTERIOR_TUNING_X, INTERIOR_TUNING_Y, INTERIOR_TUNING_Z);
	SetVehicleZAngle(vehID, -180);
	SetPlayerVirtualWorld(playerid, playerid + 1);
	SetVehicleVirtualWorld(vehID, playerid + 1);

	SetEngineStatus(vehID, false);
	SetLightStatus(vehID, false);
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s stopped the engine of the %s.", ReturnName(playerid, 0), g_arrVehicleNames[GetVehicleModel(vehID) - 400]);
 	StopCarBoomBox(vehID);

	TogglePlayerControllable(playerid, false);

	SendClientMessage(playerid, COLOR_WHITE, "Hint: Use {FFFF00}E and or {FFFF00}Q {FFFFFF}to change throughout the component types.");
	SendClientMessage(playerid, COLOR_WHITE, "Hint: Use {FFFF00}UP and  or {FFFF00}DOWN {FFFFFF}to change throughout the components.");

	PlayerData[playerid][pInTuning] = 1;
	PlayerData[playerid][pTuningCategoryID] = 0;

	Tuning_CreateTD(playerid); //important

	new string[64], categoryTuning = PlayerData[playerid][pTuningCategoryID];

	format(string, sizeof(string), "%s (~>~)~y~ %s", TuningCategories[categoryTuning], TuningCategories[categoryTuning + 1]);
	PlayerTextDrawSetString(playerid, TDTuning_Component[playerid], string);
	PlayerTextDrawShow(playerid, TDTuning_Component[playerid]);

	Tuning_SetDisplay(playerid);

	PlayerTextDrawShow(playerid, TDTuning_Dots[playerid]);
	PlayerTextDrawShow(playerid, TDTuning_Price[playerid]);
	PlayerTextDrawShow(playerid, TDTuning_ComponentName[playerid]);
	PlayerTextDrawShow(playerid, TDTuning_YN[playerid]);
 	return true;
}

CMD:carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");

	new
		vehicleid = GetPlayerVehicleID(playerid), id;

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SHERIFF  && GetFactionType(playerid) != FACTION_CORRECTIONAL && GetFactionType(playerid) != FACTION_MEDIC && !PlayerData[playerid][pHasLabel])
		return SendUnauthMessage(playerid, "You can't use this command.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/carsign [text]");

	if(strlen(params) < 2 || strlen(params) >= 50)
		return SendErrorMessage(playerid, "Your text has to be greater than 1 char and less than 50.");

    if(IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]) != -1)
    {
		new carid = Vehicle_GetID(vehicleid);

		if(CoreVehicles[vehicleid][vehSign])
		{
			Update3DTextLabelText(CoreVehicles[vehicleid][vehSignText], COLOR_WHITE, params);
			format(vehicleVariables[carid][vVehicleCarsign], 50, params);
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /remove_carsign {FFFFFF}- When you're done with it.");

			CoreVehicles[vehicleid][vehSignText] = Create3DTextLabel(params, COLOR_WHITE, 0.0, 0.0, 0.0, 25.0, 0, 0);
			Attach3DTextLabelToVehicle(CoreVehicles[vehicleid][vehSignText], vehicleid, -0.7, -1.9, -0.3);
			format(vehicleVariables[carid][vVehicleCarsign], 50, params);

			CoreVehicles[vehicleid][vehSign] = 1;
		}

		Vehicle_Save(carid);
	}
	else if((id = Car_GetID(vehicleid)) != -1)
	{
		if(PlayerData[playerid][pHasLabel] > 0)
		{
			if(HasVehicleKey(playerid, id, true))
			{
			    PlayerData[playerid][pHasLabel] -= 1;

				if(CoreVehicles[vehicleid][vehSign])
				{
					Update3DTextLabelText(CoreVehicles[vehicleid][vehSignText], 0x00B301FF, params);
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /remove_carsign {FFFFFF}- When you're done with it.");

					CoreVehicles[vehicleid][vehSignText] = Create3DTextLabel(params, 0x00B301FF, 0.0, 0.0, 0.0, 25.0, GetPlayerVirtualWorld(playerid), 0);
					Attach3DTextLabelToVehicle(CoreVehicles[vehicleid][vehSignText], vehicleid, -0.7, -1.9, -0.3);

					CoreVehicles[vehicleid][vehSign] = 1;
				}
			}
		}
		else return SendClientMessage(playerid, COLOR_GRAD2, "   You don't have any advert label!");
	}

	return true;
}

CMD:remove_carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");

	new
		vehicleid = GetPlayerVehicleID(playerid), id;

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SHERIFF && GetFactionType(playerid) != FACTION_MEDIC && !PlayerData[playerid][pHasLabel])
		return SendClientMessage(playerid, COLOR_GRAD2, "   You can't use this command!");

    if(IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]) != -1)
	{
		if(!CoreVehicles[vehicleid][vehSign])
			return SendErrorMessage(playerid, "Your vehicle doesn't have a carsign.");

		new carid = Vehicle_GetID(vehicleid);

		Delete3DTextLabel(CoreVehicles[vehicleid][vehSignText]);
		CoreVehicles[vehicleid][vehSign] = 0;
		vehicleVariables[carid][vVehicleCarsign][0] = EOS;

		SendServerMessage(playerid, "You deleted your vehicles carsign.");

		Vehicle_Save(carid);
	}
	else if((id = Car_GetID(vehicleid)) != -1)
	{
	    if(HasVehicleKey(playerid, id, true))
	    {
			if(!CoreVehicles[vehicleid][vehSign])
				return SendErrorMessage(playerid, "Your vehicle doesn't have a carsign.");

			Delete3DTextLabel(CoreVehicles[vehicleid][vehSignText]);
			CoreVehicles[vehicleid][vehSign] = 0;

			SendServerMessage(playerid, "You deleted your vehicles carsign.");
	    }
	}
	return true;
}

CMD:callsign(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendUnauthMessage(playerid, "You can't use this command.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/callsign [callsign]");

	if(strlen(params) < 3 || strlen(params) >= 32)
		return SendErrorMessage(playerid, "Your text has to be greater than 3 chars and less than 32.");

	if(CheckCallsign(playerid, params))
	{
	    SetPVarString(playerid, "TempCallSign", params);

	    ConfirmDialog(playerid, "Confirmation", " This unit is already claimed by another member. Do you wish to join them?", "OnPlayerChangeCallSign");
	}
	else
	{
		format(CallSign[playerid], 32, "%s", params);

		SendNoticeMessage(playerid, "You are now registered under %s!", params);
		SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now under %s!", Faction_GetRank(playerid), ReturnName(playerid, 0), params);
	}
	return true;
}

FUNX::OnPlayerChangeCallSign(playerid, response)
{
	if(response)
	{
	    GetPVarString(playerid, "TempCallSign", CallSign[playerid], 32);

	    SendNoticeMessage(playerid, "You are now registered under %s!", CallSign[playerid]);
	   	SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now under %s!", Faction_GetRank(playerid), ReturnName(playerid, 0), CallSign[playerid]);

	    DeletePVar(playerid, "TempCallSign");
	}
    return true;
}

stock CheckCallsign(playerid, const callsign[])
{
	foreach (new i : Player)
	{
	    if(i == playerid) continue;

	    if(!PlayerData[i][pOnDuty]) continue;

		if(isnull(CallSign[i])) continue;

	    if(!strcmp(CallSign[i], callsign, true))
		{
	        return true;
	    }
	}

	return false;
}

// /taxi [accept / duty / fare / start / stop]
CMD:taxi(playerid, params[])
{
	new option[11], secoption, vehicle = GetPlayerVehicleID(playerid), msg[128];

	if(sscanf(params, "s[11]D(-1)", option, secoption))
	{
		SendSyntaxMessage(playerid, "/taxi [option]");
		SendClientMessage(playerid, COLOR_GREY, "Option: | duty | fare | check | accept | start | stop");
		return true;
	}

	if(!strcmp(option, "duty", true))
	{
	    if(PlayerData[playerid][pSideJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "You are not a Taxi Driver.");

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GREY, "You must be the driver");

		if(!IsATaxi(vehicle))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be inside a Taxi");

		if(TaxiDuty{playerid})
		{
			SendClientMessage(playerid, COLOR_YELLOW, "You are now off duty!");

			TaxiDuty{playerid} = false;
			TaxiMade[playerid] = 0;
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW, "You are now on duty!");

			TaxiDuty{playerid} = true;
			TaxiMade[playerid] = 0;
		}

		SetPlayerToTeamColor(playerid);
	}
	else if(!strcmp(option, "start", true))
	{
	    if(PlayerData[playerid][pSideJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "You are not a Taxi Driver.");

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GREY, "You must be the driver");

		if(!IsATaxi(vehicle))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a Taxi/Cabbie.");

		if(!TaxiDuty{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You need to go on-duty.");

		if(TaxiFare{playerid} == 0)
			return SendClientMessage(playerid, COLOR_GREY, "You have not set up the fare.");

		if(TaxiStart{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You have already started your taxi services.");

		SendClientMessage(playerid, COLOR_YELLOW, "You have started your taxi services.");

		TaxiStart{playerid} = true;
	}
	else if(!strcmp(option, "fare", true))
	{
	    if(PlayerData[playerid][pSideJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "You are not a Taxi Driver.");

		new fare;

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GREY, "You must be the driver");

		if(!IsATaxi(vehicle))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a Taxi/Cabbie.");

		if(sscanf(params,"{s[11]}d",fare))
			return SendSyntaxMessage(playerid, "/taxi fare [amount]");

		if(!TaxiDuty{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You need to go on-duty.");

		if(fare < 0 || fare > 25)
			return SendClientMessage(playerid, COLOR_YELLOW, "There is a fare limit ($0-$25)");

		if(TaxiStart{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You must stop your taxi services before setting the fare.");

        TaxiFare{playerid} = fare;

		SendClientMessageEx(playerid, COLOR_YELLOW, "Taxi fare set to $%d.", fare);
	}
	else if(!strcmp(option, "accept", true))
	{
	    if(PlayerData[playerid][pSideJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "You are not a Taxi Driver.");

		new id = INVALID_PLAYER_ID, phid;

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GREY, "You must be the driver");

		if(!IsATaxi(vehicle))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a Taxi/Cabbie.");

		if(sscanf(params,"{s[11]}d",phid))
			return SendSyntaxMessage(playerid, "/taxi accept [phone number]");

		if(!TaxiDuty{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You need to go on-duty.");

		foreach (new p : Player)
		{
		    if(p == playerid) continue;

		    if(PlayerData[p][pPnumber] == phid)
		    {
		        id = p;
		        break;
		    }
		}

		if(id == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");

		if(GetPVarInt(id, "NeedTaxi") == 0 || GetPVarInt(id, "ResponseTaxi") == 2)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "They've either been answered already or don't need one.");

		SetPVarInt(id, "ResponseTaxi", GetPVarInt(id, "ResponseTaxi") + 1);

		switch(GetPVarInt(id, "ResponseTaxi"))
		{
			case 1: SendClientMessage(playerid, COLOR_WHITE, "You were the first to respond!");
			case 2: SendClientMessage(playerid, COLOR_WHITE, "You were the second to respond!");
		}

		GetPVarString(id, "CallTaxiLoc", msg, sizeof(msg));

		new Float:playerPos[3];
		GetPlayerPos(id, playerPos[0], playerPos[1], playerPos[2]);

		SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
		SendClientMessageEx(playerid, COLOR_YELLOW, "Caller: Ph:%d", PlayerData[id][pPnumber]);
		SendClientMessageEx(playerid, COLOR_YELLOW, "Current Location: %s", ReturnLocationPos(playerPos[0], playerPos[1]));
		SendClientMessageEx(playerid, COLOR_YELLOW, "Destination: %s", msg);
	}
	else if(!strcmp(option, "stop", true))
	{
	    if(PlayerData[playerid][pSideJob] != JOB_TAXI && PlayerData[playerid][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "You are not a Taxi Driver.");

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, COLOR_GREY, "You must be the driver");

		if(!IsATaxi(vehicle))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be in a Taxi/Cabbie.");

		if(!TaxiDuty{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You need to go on-duty.");

		if(!TaxiStart{playerid})
			return SendClientMessage(playerid, COLOR_GREY, "You haven't started your taxi services yet.");

		SendClientMessage(playerid, COLOR_YELLOW, "You have stopped your taxi services.");

		TaxiStart{playerid} = false;
		TaxiMade[playerid] = 0;
		TaxiMoney[playerid] = 0;
	}
	else if(!strcmp(option, "check", true))
	{
		new id;

		if(sscanf(params,"{s[11]}d",id))
			return SendSyntaxMessage(playerid, "/taxi check [playerid]");

		if(id == INVALID_PLAYER_ID)
		{
			new maskid[MAX_PLAYER_NAME];
			sscanf(params, "{s[11]}s[24]", maskid);
			if((id = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			{
				return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
			}
		}

		if(PlayerData[id][pSideJob] != JOB_TAXI && PlayerData[id][pJob] != JOB_TAXI)
			return SendClientMessage(playerid, COLOR_WHITE, "The player is not Taxi Driver.");

		if(id == playerid)
		    return SendClientMessage(playerid, COLOR_WHITE, "Yourself?");

        if(!TaxiDuty{id} || TaxiFare{id} == 0)
			return SendClientMessage(playerid, COLOR_WHITE, "Player is not on taxi duty.");

        SendClientMessageEx(playerid, COLOR_WHITE, "** %s's charges $%d per second **", ReturnName(id, 0), TaxiFare{id});
	}
	return true;
}

CMD:examelicenca(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsVehicleDMV(vehicleid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está em um veículo para exame de carteira de motorista.");

	new model = GetVehicleModel(vehicleid);

	if(model == 405)
	{
	    if(PlayerData[playerid][pCarLic])
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você já tem carteira de motorista.");

		SetPVarInt(playerid, "InDriveTest", 1);
	}
	else if(model == 438)
	{
 		if(PlayerData[playerid][pJob] == JOB_TAXI || PlayerData[playerid][pSideJob] == JOB_TAXI)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você já é um motorista de táxi!");

        if(PlayerData[playerid][pJob] != JOB_NONE && PlayerData[playerid][pSideJob] != JOB_NONE)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "Você tem que deixar o emprego primeiro (/leavejob or /leavesidejob)");

		SetPVarInt(playerid, "InDriveTest", 2);
	}

	SetEngineStatus(vehicleid, true);

	SendClientMessage(playerid, COLOR_LIGHTRED,"_____________Principais regras de condução:____________");
	SendClientMessage(playerid, COLOR_LIGHTRED, "1) Dirija no lado direito da estrada");
	SendClientMessage(playerid, COLOR_LIGHTRED, "2) Não dirija muito rápido");
	SendClientMessage(playerid, COLOR_LIGHTRED, "3) Respeite os outros motoristas na estrada");
	SendClientMessage(playerid, COLOR_WHITE, "Agora chegue ao último checkpoint a tempo de completar.");
	SendClientMessage(playerid, COLOR_WHITE, "Não vá muito rápido, pois nas ruas você pode ter problemas se fizer isso.");

	SetPVarInt(playerid, "LessonSeconds", 75);
	SetPlayerCheckpointEx(playerid, 1219.1036, -1569.8324, 13.0955, 4.0, CHECKPOINT_CAREXAM, 1);
	return true;
}

CMD:setstyle(playerid, params[])
{
	new option, secoption;

	if(sscanf(params, "dD(-1)", option, secoption))
	{
		SendSyntaxMessage(playerid, "/setstyle [Style]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "1 - Walk Style. | 2 - Chat Style. | 3 - HUD Style.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "4 - Toggle FightStyle. | 5 - Jog Style. | 6 - Street HUD Style.");
	}
	else
	{
		if(option == 1)
		{
		    if(PlayerData[playerid][pDonateRank] < 1)
				return SendUnauthMessage(playerid, "Sorry but Walk Styles are for Donators only. Check out ls-rp.com.br to purchase premium!");

			new style;

			if(sscanf(params, "{d}d", style))
			{
				SendSyntaxMessage(playerid, "/setstyle 1 [StyleID]");
				SendClientMessage(playerid, COLOR_WHITE, "Walk Styles: 1,2,3,4,5,6,7,8,9");
				SendClientMessage(playerid, COLOR_WHITE, "Walk Styles: 10,11,12,13,14,15,16");
				SendClientMessage(playerid, COLOR_WHITE, "Walk Styles: 17,18");
				return true;
			}

			if(style < 1 || style > 18)
				return SendClientMessage(playerid, COLOR_WHITE, "ID 1-18");

			PlayerData[playerid][pWalk] = style;

			SendClientMessage(playerid, COLOR_GREEN, "Enjoy your new walking style!");

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `pWalk` = '%d' WHERE `ID` = '%d'", style, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);

		}
		else if(option == 2)
		{
		    if(PlayerData[playerid][pDonateRank] < 1)
				return SendUnauthMessage(playerid, "Sorry but Chat Styles are for Donators only. Check out ls-rp.com.br to purchase premium!");

			new style;

			if(sscanf(params, "{d}d", style) || (style < 0 || style > 8))
			{
				SendSyntaxMessage(playerid, "/setstyle 2 [StyleID]");
				SendClientMessage(playerid, COLOR_WHITE, "Chat Styles: 0 1 2");
				SendClientMessage(playerid, COLOR_WHITE, "Chat Styles: 3 4");
				SendClientMessage(playerid, COLOR_WHITE, "Chat Styles: 5 6 7 8");
				return true;
			}

			PlayerData[playerid][pTalk] = style;

			SendClientMessage(playerid, COLOR_YELLOW, "Enjoy your new chat style!");

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `pTalk` = '%d' WHERE `ID` = '%d'", style, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);

		}
		else if(option == 3)
		{
		    if(PlayerData[playerid][pDonateRank] < 1)
    			return SendUnauthMessage(playerid, "Sorry but HUD Styles are for Donators only. Check out ls-rp.com.br to purchase premium!");

			new style;

			if(sscanf(params, "{d}d", style) || (style < 0 || style > 4))
			{
				SendSyntaxMessage(playerid, "/setstyle 3 [StyleID]");
				SendClientMessage(playerid, COLOR_WHITE, "HUD Styles: 0 1 4");
				SendClientMessage(playerid, COLOR_WHITE, "HUD Styles: 2 3 [Vehicles Only]");				
				//SendClientMessage(playerid, COLOR_WHITE, "HUD Styles: 0 1 3 4");
				//SendClientMessage(playerid, COLOR_WHITE, "HUD Styles: 2 5 [Vehicles Only]");
				return true;
			}

			PlayerFlags[playerid][toggleHUD] = true;

			ToggleHudTextdraw(playerid, false);
			PlayerTextDrawHide(playerid, MaskTD[playerid]);

			PlayerData[playerid][pHUDStyle] = style;

			CreatePlayerHUD(playerid);

			SendClientMessageEx(playerid, COLOR_YELLOW, "Your HUD Style is now %d!", style);
			SendClientMessage(playerid, COLOR_YELLOW, "/toghud to turn it back on!");

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `pHUDStyle` = '%d' WHERE `ID` = '%d'", style, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);
		}
		else if(option == 4)
		{
		    if(GetPlayerFightingStyle(playerid) != FIGHT_STYLE_NORMAL)
		    {
			    SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);

		    	SendClientMessage(playerid, COLOR_YELLOW, "You will now have your default fight style back");
		    	return true;
			}
			else
			{
		        CheckFightingStyle(playerid);

		    	SendClientMessage(playerid, COLOR_YELLOW, "You now have your custom fight style back.");
		    	return true;
			}
		}
  		else if(option == 5)
		{
		    if(PlayerData[playerid][pDonateRank] < 1)
    			return SendUnauthMessage(playerid, "Sorry but Jog Styles are for Donators only. Check out ls-rp.com.br to purchase premium!");

			new style;

			if(sscanf(params, "{d}d", style))
			{
				SendSyntaxMessage(playerid, "/setstyle 5 [StyleID]");
				SendClientMessage(playerid, COLOR_WHITE, "Jog Styles: 1,2");
				return true;
			}

			if(style < 1 || style > 2)
				return SendClientMessage(playerid, COLOR_WHITE, "ID 1-2");

			PlayerData[playerid][pJog] = style;

			SendClientMessageEx(playerid, COLOR_GREEN, "Enjoy your new jog style! Try it out with /jog!", style);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `pJog` = '%d' WHERE `ID` = '%d'", style, PlayerData[playerid][pID]);
			mysql_pquery(dbCon, gquery);
		}
		else if(option == 6)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "Street name HUD is currently disabled.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "1 - Walk Style. | 2 - Chat Style. | 3 - HUD Style.");
			SendClientMessage(playerid, COLOR_LIGHTRED, "4 - Toggle FightStyle. | 5 - Jog Style. | 6 - Street HUD Style.");
		}
	}
	return true;
}

CMD:toghud(playerid, params[])
{
	if(!PlayerFlags[playerid][toggleHUD])
	{
		PlayerFlags[playerid][toggleHUD] = true;

		ToggleHudTextdraw(playerid, false);
        PlayerTextDrawHide(playerid, MaskTD[playerid]);

 		SendClientMessage(playerid, COLOR_YELLOW, "HUD togged off.");
	}
	else
	{
		PlayerFlags[playerid][toggleHUD] = false;

		ToggleHudTextdraw(playerid, true);

		if(IsMasked{playerid})
		{
			PlayerTextDrawShow(playerid, MaskTD[playerid]);
		}

		SendClientMessage(playerid, COLOR_YELLOW, "HUD togged on.");
	}
	return true;
}

CMD:andar(playerid, params[])
{
	switch(PlayerData[playerid][pWalk])
	{
 		case 1: ApplyAnimation(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 2: ApplyAnimation(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
	    case 3: ApplyAnimation(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
	    case 4: ApplyAnimation(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 5: ApplyAnimation(playerid, "FAT", "FatWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 6: ApplyAnimation(playerid, "MUSCULAR", "MuscleWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 7: ApplyAnimation(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
	    case 8: ApplyAnimation(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
	    case 9: ApplyAnimation(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
	    case 10: ApplyAnimation(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
	    case 11: ApplyAnimation(playerid, "PED", "WALK_wuzi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 12: ApplyAnimation(playerid, "PED", "WOMAN_walkbusy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 13: ApplyAnimation(playerid, "PED", "WOMAN_walkfatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 14: ApplyAnimation(playerid, "PED", "WOMAN_walknorm", 4.1, 1, 1, 1, 1, 1, 1);
	    case 15: ApplyAnimation(playerid, "PED", "WOMAN_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 16: ApplyAnimation(playerid, "PED", "WOMAN_walkshop", 4.1, 1, 1, 1, 1, 1, 1);
	    default: ApplyAnimation(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
	}

	if(PlayerData[playerid][pWalk]) PlayerData[playerid][pAnimation] = 1;

	return true;
}

CMD:correr(playerid, params[])
{
	switch(PlayerData[playerid][pJog])
	{
		case 1: ApplyAnimation(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
 		case 2: ApplyAnimation(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
	}

	if(PlayerData[playerid][pJog]) PlayerData[playerid][pAnimation] = 1;

	return true;
}

stock ChatAnimation(playerid, length)
{
	if(PlayerData[playerid][pAnimation]) return true;

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
	{
		if(PlayerData[playerid][pInjured] || DeathMode{playerid} || KnockedOut{playerid} || IsTazed{playerid}) return true;

		new chatstyle = PlayerData[playerid][pTalk];

		PlayerData[playerid][pAnimation] = 1;

		switch(chatstyle)
		{
		    case 0: ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 1, 1, 1, 1, 1);
		    case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.0, 0, 1, 1, 1, 1, 1);
		    case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.0, 0, 1, 1, 1, 1, 1);
		    case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 4.0, 0, 1, 1, 1, 1, 1);
		    case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 1, 1, 1, 1, 1);
		    case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.0, 0, 1, 1, 1, 1, 1);
		    case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.0, 0, 1, 1, 1, 1, 1);
		    case 7: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.0, 0, 1, 1, 1, 1, 1);
		    case 8: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.0, 0, 1, 1, 1, 1, 1);
		}

		SetTimerEx("StopChatting", floatround(length) * 100, false, "i", playerid);
	}
	return true;
}

//roadblocks
CMD:disband(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SHERIFF)
		return SendUnauthMessage(playerid, "You can't access this.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho!");

	new
	    id
	;

	if(sscanf(params, "d", id))
	{
	    new Float:objectPos[3], bool:found = false;

		for(new i = 0; i < 10; ++i)
		{
			if(RoadBlocks[playerid][i][roadblockObject] == INVALID_OBJECT_ID) continue;

			GetDynamicObjectPos(RoadBlocks[playerid][i][roadblockObject], objectPos[0], objectPos[1], objectPos[2]);

			if(IsPlayerInRangeOfPoint(playerid, 2.5, objectPos[0], objectPos[1], objectPos[2]))
			{
			    found = true;

			    DisbandRoadblockDialog(playerid, playerid, i);
                break;
			}
		}

		if(!found) SendErrorMessage(playerid, "You aren't close enough to a roadblock.");

		return true;
	}

	if(id < 1 || id > 10)
	    return SendErrorMessage(playerid, "Invalid slot specified (1 - 10).");

	id -= 1;

	if(RoadBlocks[playerid][id][roadblockObject] == INVALID_OBJECT_ID)
		return SendErrorMessage(playerid, "Invalid slot specified.");

    DisbandRoadblockDialog(playerid, playerid, id);
	return true;
}

YCMD:rb(playerid, params[], help) = roadblock;

CMD:roadblock(playerid, const params[])
{
	if(!IsPolice(playerid))
		return SendUnauthMessage(playerid, "You can't access this.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho!");

	new
	    id,
	    message[24]
	;

	if(sscanf(params, "dS(None)[24]", id, message))
	{
	    new count = 0;

		foreach (new i : Player)
		{
			if(!IsPolice(i)) continue;

			for(new rb = 0; rb < 10; ++rb)
			{
				if(RoadBlocks[i][rb][roadblockObject] != INVALID_OBJECT_ID)
				{
					count++;
				}
			}
		}

	    format(sgstr, sizeof(sgstr), "{A9C4E4}Deploy a roadblock\n{A9C4E4}View {7e98b6}%d{A9C4E4} deployed roadblocks.", count);
		return Dialog_Show(playerid, Roadblock, DIALOG_STYLE_LIST, "Roadblock", sgstr, "Select", "<< Exit");
	}

	new maxslot = sizeof(Road_Blocks);

	if(id < 0 || id > maxslot)
	    return SendErrorMessage(playerid, "Invalid slot specified (0 - %d).", maxslot - 1);

	DeployRoadblock(playerid, id, message);
	return true;
}

CMD:cone(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendUnauthMessage(playerid, "You can't access this.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho!");

    DeployRoadblock(playerid, 0, "");
	return true;
}

CMD:stinger(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendUnauthMessage(playerid, "You can't access this.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho!");

    DeployRoadblock(playerid, 10, "");
	return true;
}

CMD:cellinfo(playerid, params[])
{
	if(PlayerData[playerid][pJailed] != PUNISHMENT_TYPE_PRISON)
	    return SendErrorMessage(playerid, "You're not imprisoned.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "You're in cell A%d", PlayerCell[playerid] + 100);
	return true;
}

CMD:liberdade(playerid, params[])
{
	if(PlayerData[playerid][pJailed] < 2 || PlayerData[playerid][pSentenceTime] > 0)
	{
		SendErrorMessage(playerid, "Você não tem acesso a este comando. Não está na cadeia/prisão ou o tempo não acabou. /horas.");
		SendErrorMessage(playerid, "Se você estiver realmente na prisão, faça login novamente para corrigir esse problema.");
		return true;
	}

	ReleaseFromPrison(playerid);

	SendClientMessage(playerid, COLOR_GREY, "   Você pagou sua dívida com a sociedade.");
	GameTextForPlayer(playerid, "~g~Liberdade~n~~w~Tente ser um cidadão melhor", 5000, 1);
	return true;
}

CMD:arrestrecord(playerid, params[])
{
    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SHERIFF)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	new
		userid,
		playerc = INVALID_PLAYER_ID,
		forcearrest
	;

	if(sscanf(params, "uD(0)", userid, forcearrest))
	    return SendSyntaxMessage(playerid, "/arrestrecord [id/Mask/nome]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	foreach (new i : Player)
	{
	    if(WritingArrest[i] == userid)
	    {
	        playerc = i;
	        break;
		}
	}

	if(playerc != INVALID_PLAYER_ID)
	{
	    if(forcearrest == 1)
			return WriteArrestRecord(playerid, userid, playerc);

		SendClientMessageEx(playerid, -1, "Someone else is already writing an arrest record on %s, /arrestrecord %d 1 to force through (eg. initial writer has quit.)", ReturnName(userid), userid);
		return true;
	}

	WriteArrestRecord(playerid, userid);
	return true;
}

CMD:mdc(playerid, params[])
{
    new type = GetFactionType(playerid);

	if(type != FACTION_POLICE && type != FACTION_SHERIFF && type != FACTION_MEDIC && !AdminDuty{playerid})
		return SendUnauthMessage(playerid, "You don't have access to the MDC.");

	if(PCarOpening{playerid} || IsBrutallyWounded(playerid))
	    return SendErrorMessage(playerid, "You can't use the MDC right now.");

	if(!AdminDuty{playerid})
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(!IsPlayerInAnyVehicle(playerid) || vehicleid == INVALID_VEHICLE_ID)
		    return SendErrorMessage(playerid, "You can't use the MDC here.");

		if(!IsAFactionCar(vehicleid, PlayerData[playerid][pFaction]) || IsAPlane(vehicleid) || IsABoatModel(vehicleid))
		    return SendErrorMessage(playerid, "You can't use the MDC here.");
	}

	if(!MDC_Created{playerid}) return true;

	if(UsingMDC{playerid}) TogglePlayerMDC(playerid, false);

	e_Player_MDC_Cache[playerid][faction_type] = type;

	PlayerTextDrawDestroy(playerid, MDC_UI[playerid][1]);

	MDC_UI[playerid][1] = CreatePlayerTextDraw(playerid, 170.666702, 161.000000, "LD_SPAC:white"); //160.947937
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][1], 0.000000, 1.144950);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][1], 298.000030, 10.785170);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][1], 186668031);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][1], 0);

	switch(type)
	{
	    case FACTION_POLICE:
	    {
			PlayerTextDrawColor(playerid, MDC_UI[playerid][1], 186668031);

			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][0], "Main_Screen");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][1], "Look_Up");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][2], "Emergency");
		}
	    case FACTION_SHERIFF:
	    {
			PlayerTextDrawColor(playerid, MDC_UI[playerid][1], 155656447);

			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][0], "Main_Screen");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][1], "Look_Up");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][2], "Emergency");
		}
	    case FACTION_MEDIC:
	    {
			PlayerTextDrawColor(playerid, MDC_UI[playerid][1], COLOR_MEDIC);

			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][0], "Main_Screen");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][1], "Emergency");
			PlayerTextDrawSetString(playerid, MDC_MenuUI[playerid][2], "Roster");
		}
	}

    TogglePlayerMDC(playerid, true);
	SelectTextDraw(playerid, COLOR_BLACK);
	return true;
}

CMD:jail(playerid, params[])
{
	if(!IsPolice(playerid) && !AdminDuty{playerid})
	    return SendUnauthMessage(playerid, "You must be a POLICE OFFICER or on ADMINDUTY to perform this command.");

	new
		userid,
		time_sum,
		arrest_point
	;

	if(sscanf(params, "ud", userid, time_sum))
		return SendSyntaxMessage(playerid, "/jail [id/Mask/nome] [time in minutes]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{ddd}", maskid);

		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
	}

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Playerid is not an active playerid.");

    if(!SQL_IsLogged(userid))
        return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	arrest_point = ReturnArrestPoint(playerid);

	if(arrest_point != ARREST_POINT_ADMIN && arrest_point != ARREST_POINT_HARBOUR)
		return SendErrorMessage(playerid, "You can't arrest here.");

    if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "You're too far away.");

	if(time_sum < 1 || time_sum > 60 && !AdminDuty{playerid})
	    return SendErrorMessage(playerid, "Maximum jail time is 60 minutes, use /prison for a longer sentence.");

	if(PlayerData[userid][pJailed])
	    return SendErrorMessage(playerid, "The player you specified is already arrested.");

	new query[180], list[256], charge_type, count;
	mysql_format(dbCon, query, sizeof(query), "SELECT charge_type FROM criminal_record WHERE player_name = '%e' ORDER BY idx DESC LIMIT 15", ReturnName(userid));
	new Cache:record_cache = mysql_query(dbCon, query);

	if(cache_num_rows())
	{
		for(new i = 0; i < cache_num_rows(); ++i)
		{
			cache_get_value_name_int(i, "charge_type", charge_type);

			if(charge_type != 1) break;

	        count++;
		}
	}

	cache_delete(record_cache);

 	ResetWeapons(userid);

	PlayerData[userid][pJailed] = PUNISHMENT_TYPE_JAIL;
	PlayerData[userid][pSentenceTime] = time_sum * 60;

	if(AdminDuty{playerid}) format(list, sizeof(list), "[Prison] Game Admin %s has just arrested %s for %d minute(s).", ReturnName(playerid, 0), ReturnName(userid, 0), time_sum);
	else format(list, sizeof(list), "[Prison] %s %s has just arrested %s for %d minute(s).", Faction_GetRank(playerid), ReturnName(playerid, 0), ReturnName(userid, 0), time_sum);

	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == -1) continue;

	    if(GetFactionType(i) == FACTION_POLICE || i == userid || AdminDuty{i})
	    {
	        SendClientMessage(i, COLOR_LIGHTRED, list);
	    }
	}

	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `ActiveListings` = 0, `Jailed` = 2, `SentenceTime` = %i, `JailTimes` = JailTimes + 1 WHERE `ID` = %i LIMIT 1", time_sum, PlayerData[userid][pModel], PlayerData[userid][pID]);
	mysql_pquery(dbCon, query);

	InsertCriminalRecord(playerid, userid, CHARGE_TYPE_ARREST, list, count);

	ForceSwitchPhone(userid, true);

	if(IsMasked{userid})
	{
        IsMasked{userid} = false;

		foreach (new i : Player)
  		{
	        if(i != userid)
	        {
				RefreshMaskStatus(userid, i);
			}
        }

        HideMaskTextdraw(userid);
	}

	SendClientMessage(userid, COLOR_LIGHTRED, "[ ! ] Warning: Your phone was turned off because you are in jail. Don't forget to turn it back on once you're out!");

	PutPlayerInJail(userid, arrest_point != ARREST_POINT_ADMIN ? -1 : random(sizeof(JailSpawns)));
	SendClientMessageEx(playerid, COLOR_GREEN, "Successfully arrested %s.", ReturnName(userid, 0));
	GameTextForPlayer(playerid, "~r~suspect detained", 4000, 1);

	MDC_Global_Cache[Arrests] += 1;
	return true;
}

CMD:prison(playerid, params[])
{
	if(!IsPolice(playerid) && !AdminDuty{playerid})
	    return SendUnauthMessage(playerid, "You must be a POLICE OFFICER or on ADMINDUTY to perform this command.");

	new
		userid,
		time_sum,
		arrest_point
	;

	if(sscanf(params, "ud", userid, time_sum))
		return SendSyntaxMessage(playerid, "/prison [id/Mask/nome] [time in minutes]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{ddd}", maskid);

		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
	}

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Playerid is not an active playerid.");

    if(!SQL_IsLogged(userid))
        return SendErrorMessage(playerid, "O player que você especificou não esta logado.");

	if((arrest_point = ReturnArrestPoint(playerid)) == ARREST_POINT_INVALID)
		return SendErrorMessage(playerid, "You can't /prison here.");

    if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "You're too far away.");

	if(time_sum < 1 || time_sum > 720 && !AdminDuty{playerid})
	    return SendErrorMessage(playerid, "Maximum prison time is 720 minutes.");

	if(PlayerData[userid][pJailed])
	    return SendErrorMessage(playerid, "The player you specified is already arrested.");

	new query[180], list[256], charge_type, count;
	mysql_format(dbCon, query, sizeof(query), "SELECT charge_type FROM criminal_record WHERE player_name = '%e' ORDER BY idx DESC LIMIT 15", ReturnName(userid));
	new Cache:record_cache = mysql_query(dbCon, query);

	if(cache_num_rows())
	{
		for(new i = 0; i < cache_num_rows(); ++i)
		{
			cache_get_value_name_int(i, "charge_type", charge_type);

			if(charge_type != 1) break;

	        count++;
		}
	}

	cache_delete(record_cache);

 	ResetWeapons(userid);

	PlayerData[userid][pJailed] = PUNISHMENT_TYPE_PRISON;
	PlayerData[userid][pSentenceTime] = time_sum * 60;

	if(AdminDuty{playerid}) format(list, sizeof(list), "[Prison] Game Admin %s has just imprisoned %s for %d minute(s).", ReturnName(playerid, 0), ReturnName(userid, 0), time_sum);
	else format(list, sizeof(list), "[Prison] %s %s has just imprisoned %s for %d minute(s).", Faction_GetRank(playerid), ReturnName(playerid, 0), ReturnName(userid, 0), time_sum);

	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == -1) continue;

	    if(GetFactionType(i) == FACTION_POLICE || i == userid || AdminDuty{i})
	    {
	        SendClientMessage(i, COLOR_LIGHTRED, list);
	    }
	}

	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `ActiveListings` = 0, `Jailed` = 3, `SentenceTime` = %i, `PrisonTimes` = PrisonTimes + 1, `PrisonSkin` = %i WHERE `ID` = %i LIMIT 1", time_sum, PlayerData[userid][pModel], PlayerData[userid][pID]);
	mysql_pquery(dbCon, query);

	InsertCriminalRecord(playerid, userid, CHARGE_TYPE_ARREST, list, count);

	ForceSwitchPhone(userid, true);

	if(IsMasked{userid})
	{
        IsMasked{userid} = false;

		foreach (new i : Player)
  		{
	        if(i != userid)
	        {
				RefreshMaskStatus(userid, i);
			}
        }

        HideMaskTextdraw(userid);
	}

	SendClientMessage(userid, COLOR_LIGHTRED, "[ ! ] Warning: Your phone was turned off because you are in jail. Don't forget to turn it back on once you're out!");

	PutPlayerInPrison(userid, random(sizeof(PrisonSpawns)));

	if(arrest_point == ARREST_POINT_ADMIN || arrest_point == ARREST_POINT_RECEIVE_RELEASE)
	{
		SendClientMessageEx(playerid, COLOR_GREEN, "Successfully arrested %s in cell A%d", ReturnName(userid, 0), PlayerCell[userid] + 100);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREEN, "Successfully arrested %s in a station jail, awaiting SACF transport.", ReturnName(userid, 0));
		SendClientMessage(playerid, COLOR_LIGHTRED, "Make sure all the doors in here are locked!");
	}

	MDC_Global_Cache[Arrests] += 1;
	return true;
}

CMD:siren(playerid, params[])
{
    if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV && GetFactionType(playerid) != FACTION_CORRECTIONAL)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't use this command as you aren't a medic or law enforcer.");

	new vehicleid = GetPlayerVehicleID(playerid), Float:x, Float:y, Float:z, Float:tmp;

	if(!vehicleid)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not inside of any vehicle.");

	if(IsAPlane(vehicleid))
	    return SendErrorMessage(playerid, "This vehicle doesn't support a siren!");

	if(!IsValidDynamicObject(vehicleSiren[vehicleid]))
	{
	    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, z, z, z);
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, x, y, tmp);

		vehicleSiren[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, -x, y, z / 1.9, 0.0, 0.0, 0.0);

		switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
		    case 596:
		    {
		        AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.000000, -0.389999, 0.914999, 0.000000, 0.000000, 0.000000);
		    }
		    case 597:
		    {
		        AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.000000, -0.384999, 0.914999, 0.000000, 0.000000, 0.000000);
		    }
		    case 598:
		    {
		        AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, -0.014999, -0.334999, 0.964999, 0.000000, 0.000000, 0.000000);
		    }
		    case 599:
		    {
		        AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.000000, 0.039999, 1.153999, 0.000000, 0.000000, 0.000000);
		    }
			case 560:
			{
			    AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.225000,0.750000,0.449999, 0.000000, 0.000000, 0.000000);
			}
			case 541:
			{
			    AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.375000,0.524999,0.375000, 0.000000, 0.000000, 0.000000);
			}
			case 426:
			{
			    AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.524999,0.749999, 0.375000, 0.000000, 0.000000, 0.000000);
			}
			case 579:
			{
			    AttachDynamicObjectToVehicle(vehicleSiren[vehicleid], vehicleid, 0.679999, 0.479999, 0.734999, 0.000000, 0.000000, 0.000000);
			}
		}

        GameTextForPlayer(playerid, "~g~SIREN TURNED ON!", 5000, 4);
	}
	else
	{
	    DestroyDynamicObject(vehicleSiren[vehicleid]);
	    vehicleSiren[vehicleid] = INVALID_OBJECT_ID;

	    GameTextForPlayer(playerid, "~r~SIREN TURNED OFF!", 5000, 4);
	}

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return true;
}

CMD:createscene(playerid, params[])
{
	if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_MEDIC && !AdminDuty{playerid})
		return SendErrorMessage(playerid, "You do not have access to this command.");

	new
		Float:x,
		Float:y,
		Float:z,
		text[256],
		string[256],
		duration,
		Float:viewdistance
	;

	GetPlayerPos(playerid, x, y, z);

	if(sscanf(params, "dfs[256]", duration, viewdistance, text))
		return SendSyntaxMessage(playerid, "/createscene [duration (def: 300)] [viewdistance (def: 30.0)] Description...]");

	if(duration < 1)
	    return SendErrorMessage(playerid, "Invalid duration specified.");

	if(viewdistance < 1)
	    return SendErrorMessage(playerid, "Invalid viewdistance specified.");

	format(string, sizeof(string), "* %s (( %s ))", text, ReturnName(playerid, 0));

	if(strlen(string) > MAX_MSG_LENGTH / 2)
	{
	    strins(string, "...\n...", MAX_MSG_LENGTH / 2);
	}

    new found = 0, foundid = 0;

  	for(new i = 0; i < MAX_SCENES; ++i)
    {
	   	if(SceneInfo[i][scExist] == 0 && found == 0)
	   	{
    		found ++;
	       	foundid = i;
       	}
    }

  	if(found == 0) return SendClientMessage(playerid, COLOR_GREY, "Scenes slots are currently full. Ask developers to increase the internal limit.");

	SceneInfo[foundid][scExist] = 1;
    SceneInfo[foundid][scFaction] = PlayerData[playerid][pFaction];
    SceneInfo[foundid][scID] = CreateDynamic3DTextLabel(string, 0xC2A2DAFF, x, y, z, viewdistance, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, viewdistance);
    SceneInfo[foundid][scX] = x;
  	SceneInfo[foundid][scY] = y;
  	SceneInfo[foundid][scZ] = z;

  	SendClientMessageEx(playerid, COLOR_LIGHTRED, "%d", duration);

  	format(string, sizeof(string), "-> Created scene with description (( %s )) %s (duration: %d, distance: %.6f) - You can /clearscene.", ReturnName(playerid, 0), text, duration, viewdistance);

  	if(strlen(string) > 120)
  	{
  	    SendClientMessageEx(playerid, COLOR_YELLOW, "%.120s", string);
  	    SendClientMessageEx(playerid, COLOR_YELLOW, "%s", string[120]);
  	}
  	else SendClientMessage(playerid, COLOR_YELLOW, string);

  	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return true;
}

//YCMD:cs(playerid, params[], help) = clearscene;

CMD:clearscene(playerid, params[])
{
	if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_MEDIC && !AdminDuty{playerid})
		return SendErrorMessage(playerid, "You do not have access to this command.");

	new found = 0;

    for(new i = 0; i < MAX_SCENES; ++i)
    {
	    if(SceneInfo[i][scExist] == 1 && SceneInfo[i][scFaction] == PlayerData[playerid][pFaction])
	    {
 	    	if(IsPlayerInRangeOfPoint(playerid, 2.5, SceneInfo[i][scX], SceneInfo[i][scY], SceneInfo[i][scZ]))
		    {
		   		DestroyDynamic3DTextLabel(SceneInfo[i][scID]);

           		SceneInfo[i][scExist] = 0;

           		found++;

           		SendClientMessage(playerid, COLOR_YELLOW, "-> Scene removed.");
           		break;
       		}
	    }
	}

	if(!found) return SendClientMessage(playerid, COLOR_YELLOW, "-> You have no active scenes.");

    Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
  	return true;
}

YCMD:csall(playerid, params[], help) = clearsceneall;

CMD:clearsceneall(playerid, params[])
{
	if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_MEDIC && !AdminDuty{playerid})
		return SendErrorMessage(playerid, "You do not have access to this command.");

	new count = 0;

    for(new i = 0; i < MAX_SCENES; ++i)
	{
	    if(SceneInfo[i][scExist] == 1 && SceneInfo[i][scFaction] == PlayerData[playerid][pFaction])
	    {
			DestroyDynamic3DTextLabel(SceneInfo[i][scID]);

	        SceneInfo[i][scExist] = 0;

	        count++;
	   	}
    }

    if(!count) return SendClientMessage(playerid, COLOR_YELLOW, "-> You have no active scenes.");

    SendClientMessage(playerid, COLOR_YELLOW, "-> Scene removed.");

    Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return true;
}

CMD:alarm(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_CORRECTIONAL)
		return SendErrorMessage(playerid, "Access Denied.");

  	foreach (new i : Player)
	{
	    PlayerPlaySound(i, 6001, 158.5095, -191.7217, 355.0178);

	    SendFactionMessageEx(FACTION_CORRECTIONAL, COLOR_POLICE, "** HQ: An Alarm went off on Block A at SACF **");
	}
	return true;
}

CMD:alarmoff(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_CORRECTIONAL)
		return SendErrorMessage(playerid, "Access Denied.");

  	foreach (new i : Player)
	{
	    PlayerPlaySound(i, 60000, 0.0, 0.0, 0.0);
	}
	return true;
}

CMD:taser(playerid, params[])
{
	if(!IsPolice(playerid) && GetFactionType(playerid) != FACTION_CORRECTIONAL)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	if(TazerActive{playerid})
	{
		TazerActive{playerid} = false;

		RemoveWeapon(playerid, 23);
		if(GetPVarInt(playerid, "WeaponSlot")) GivePlayerValidWeapon(playerid, GetPVarInt(playerid, "WeaponSlot"), GetPVarInt(playerid, "WeaponSlot2"), 0, false);

		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s holsters their taser.", ReturnName(playerid, 0));

		DeletePVar(playerid, "WeaponSlot");
		DeletePVar(playerid, "WeaponSlot2");
	}
	else
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "You need to be on foot.");

		if(ParticleSettings[playerid][usingParticle])
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "Drop the particle gun first.");

		TazerActive{playerid} = true;

		if(PlayerData[playerid][pWeapon][2] > 0 && PlayerData[playerid][pAmmunation][2] > 0)
		{
		    SetPVarInt(playerid, "WeaponSlot", PlayerData[playerid][pWeapon][2]);
			SetPVarInt(playerid, "WeaponSlot2", PlayerData[playerid][pAmmunation][2]);
		}

		GivePlayerValidWeapon(playerid, 23, 999999, 0, false);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s unholsters their taser.", ReturnName(playerid, 0));
	}
	return true;
}

CMD:togalpr(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	if(ALPR_Enabled{playerid})
	{
	    ALPR_Enabled{playerid} = false;

	    SendNoticeMessage(playerid, "ALPR has been disabled.");
	}
	else
	{
	    ALPR_Enabled{playerid} = true;

	    SendNoticeMessage(playerid, "ALPR has been enabled.");
	}
	return true;
}

CMD:alprlog(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	new
	    count,
		stamp = gettime(),
		body[200]
	;

	format(body, sizeof(body), "BOLO #\tPlate\tWanted For\n");

	for(new x = 0; x < MAX_VEHICLE_BOLOS; ++x)
	{
		if(!VehicleBOLOS[x][Exists]) continue;

		if((stamp - VehicleBOLOS[x][lastPing]) <= 60)
		{
			format(body, sizeof(body), "%s%d\t%s\t%s\n", body, x + 1, VehicleBOLOS[x][boloPlate], VehicleBOLOS[x][boloCharges]);

			count++;
		}
	}

	if(!count) return Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "ALPR Log - Last 60 Seconds", "Nothing found", "Close", "");

	Dialog_Show(playerid, ALPRlogs, DIALOG_STYLE_TABLIST_HEADERS, "ALPR Log - Last 60 Seconds (click)", body, "Close", "");
	return true;
}

CMD:apb(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está em trabalho.");

	new option[32], action[32];

	if(sscanf(params, "s[32]S()[32]", option, action))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "___________________________________");
		SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /apb [action] | ( ) means optional");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Show] /apb show (page number)");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Details] /apb details [number]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Clear] /apb clear [number]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Modify] /apb modify [number] [suspect]//[charges]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[Create] /apb create [suspect]//[charges]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Example: \"/apb create Red Premier // Speeding\"");
		SendClientMessage(playerid, COLOR_LIGHTRED, "___________________________________");
	    return 1;
	}

	if(!strcmp(option, "show", true))
	{
		if(isnull(action) || !IsNumeric(action))
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /apb show (page number)");

		new currentpage = strval(action);

		if(currentpage < 1 || currentpage > 95)
		    return SendClientMessage(playerid, COLOR_GREY, "The page number doesn't exist.");

		currentpage -= 1;

		new count, bool:more = false;

	    for(new i = currentpage * 5; i < 100; ++i)
	    {
	        if(count == 5)
	        {
	            if(i + 1 < 100)
				{
	                if(APB[i + 1][Exists])
	                {
	                    more = true;
	                }
	            }

	            break;
	        }

	        if(APB[i][Exists])
	        {
				count++;
	        }
	    }

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "__________All Points Bulletins(%d)__________", count);

		if(count > 0)
		{
			count = 0;

			for(new i = currentpage * 5; i < 100; ++i)
			{
				if(count == 5) break;

			    if(APB[i][Exists])
			    {
					SendClientMessageEx(playerid, COLOR_LIGHTRED, "%d. APB: %s", i + 1, APB[i][Description]);

					count++;
				}
			}
		}

		if(more) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "________((Use /apb show %d for more))________", currentpage + 2);

		SendClientMessage(playerid, COLOR_LIGHTRED, "_______________________________________________");
		return true;
	}
	else if(!strcmp(option, "details", true))
	{
		if(isnull(action) || !IsNumeric(action))
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /apb details [number]");

		new idx = strval(action);

		if(idx < 1 || idx > 100)
		    return SendClientMessage(playerid, COLOR_GREY, "The page number doesn't exist.");

		idx -= 1;

		if(!APB[idx][Exists])
			return SendClientMessage(playerid, COLOR_GREY, "The page number doesn't exist.");

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "____________All Points Bulletins Number %d____________", idx + 1);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "APB: %s", APB[idx][Description]);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "CHARGES: %s", APB[idx][Charges]);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "__________ISSUED BY: %s, %s__________", APB[idx][Creator], APB[idx][Department]);
	}
	else if(!strcmp(option, "clear", true))
	{
		if(isnull(action) || !IsNumeric(action))
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /apb clear [number]");

		new idx = strval(action);

		if(idx < 1 || idx > 100)
		    return SendClientMessage(playerid, COLOR_GREY, "The page number doesn't exist.");

		idx -= 1;

		if(!APB[idx][Exists])
			return SendClientMessage(playerid, COLOR_GREY, "The page number doesn't exist.");

	    APB[idx][Exists] = false;
	    APB[idx][Stamp] = 1930177671;
	    APB[idx][Creator][0] = EOS;
	    APB[idx][Department][0] = EOS;
	    APB[idx][Description][0] = EOS;
	    APB[idx][Charges][0] = EOS;

	    SortDeepArray(APB, Stamp, .order = SORT_ASC);

		SendClientMessage(playerid, COLOR_LIGHTRED, "APB Warrant has been cleared.");
	}
	else if(!strcmp(option, "create", true))
	{
	    if(isnull(action))
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /apb create [suspect] // [charges]");

	    new idx = -1, pos;

	    for(new i = 0; i < 100; ++i)
	    {
	        if(!APB[i][Exists])
	        {
	            APB[i][Exists] = true;

	            APB[i][Stamp] = gettime();

	            format(APB[i][Creator], MAX_PLAYER_NAME, ReturnName(playerid, 0));
	            format(APB[i][Department], 10, "%s", (GetFactionType(playerid) == FACTION_POLICE) ? ("LSPD") : ("LSSD"));

	            pos = strfind(action, "/");

	            strmid(APB[i][Description], action, 0, pos, 128);
	            strmid(APB[i][Charges], action, pos + 2, strlen(params), 60);

				idx = i;
				break;
	        }
	    }

	    if(idx == -1) return true;

	    SortDeepArray(APB, Stamp, .order = SORT_ASC);

	    SendPoliceMessage(COLOR_LIGHTRED, "%s %s has just added a new APB warrant. (( /apb details %d to check it ))", (GetFactionType(playerid) == FACTION_POLICE) ? ("Officer") : ("Deputy"), ReturnName(playerid, 0), idx + 1);
	}
	else SendServerMessage(playerid, "Invalid Parameter.");

	return true;
}

CMD:fine(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	new userid, amount, reason[128];

	if(sscanf(params, "uds[128]", userid, amount, reason))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /fine [id/Mask/nome] [amount] [reason, 60 char max]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{ds[60]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	/*if(userid == playerid)
		return SendErrorMessage(playerid, "You can't fine yourself.");*/

    if(amount <= 0)
		return SendErrorMessage(playerid, "Fine value must be greater than 0.");

	if(strlen(reason) > 60)
	    return SendErrorMessage(playerid, "Reason must be greater than 1 character and less than 60.");

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
		return SendErrorMessage(playerid, "You are too far away.");

	format(sgstr, sizeof(sgstr), "writes a fine of $%d to %s for '%s'.", amount, ReturnName(userid, 0), reason);
	AnnounceMeAction(playerid, sgstr);

    SendClientMessageEx(userid, COLOR_LIGHTRED, "[ ! ] You were fined by %s for '%s'. See /fines", ReturnName(playerid, 0), reason);

	PlacePlayerFine(userid, playerid, amount, reason);

	MDC_Global_Cache[Fines] += 1;
	return true;
}

CMD:fines(playerid, params[])
{
	if(!IsPolice(playerid))
	{
		ListPlayerFines(playerid, playerid);
	}
	else
	{
		new userid;

		if(sscanf(params, "u", userid))
			return SendSyntaxMessage(playerid, "/fines [id/nome]");

        if(userid == playerid)
		{
			ListPlayerFines(playerid, playerid);
        }
        else
		{
            if(!PlayerData[playerid][pOnDuty])
				return SendClientMessage(playerid, COLOR_GRAD1, "Você não está em trabalho.");

			if(userid == INVALID_PLAYER_ID)
			{
				new maskid[MAX_PLAYER_NAME];
				sscanf(params, "s[24]", maskid);
				if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
				{
					return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
				}
			}

			ListPlayerFines(playerid, userid);
		}
	}
	return true;
}

/*CMD:vehiclefine(playerid, params[])
{
	if(!IsPolice(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "For police officers only.");

	if(!PlayerData[playerid][pOnDuty])
		return SendErrorMessage(playerid, "Você não está em trabalho.");

	new vehicleid, amount, reason[64];

	if(sscanf(params, "s[64]ds[64]", vehicleid, amount, reason))
		return SendSyntaxMessage(playerid, "/vehiclefine [vehicleid] [amount] [reason]");

	if(!IsValidVehicle(vehicleid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Invalid vehicle specified.");

	new carid = -1;

	if((carid = Car_GetID(vehicleid)) == -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Personal cars only.");

	if(amount <= 0)
		return SendClientMessage(playerid, COLOR_GRAD1, "Fine must be greater than 0.");

	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s tears a fine and puts it on the %s's windshield.", ReturnName(playerid, 0), g_arrVehicleNames[CarData[carid][carModel] - 400]);

	PlaceVehicleFine(carid, playerid, amount, reason);
	return true;
}

CMD:vehiclefines(playerid, params[])
{
	if(!IsPolice(playerid))
	{
		ViewVehicleFine(playerid, playerid);
	}
	else
	{
		new userid;

		if(sscanf(params, "u", userid))
			return SendSyntaxMessage(playerid, "/vehiclefines [vehicleid]");

        if(userid == playerid)
		{
			ViewVehicleFine(playerid, playerid);
        }
        else
		{
            if(!PlayerData[playerid][pOnDuty])
				return SendClientMessage(playerid, COLOR_GRAD1,"   You have not started to perform duties");

			if(userid == INVALID_PLAYER_ID)
			{
				new maskid[MAX_PLAYER_NAME];
				sscanf(params, "s[24]", maskid);
				if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
				{
					return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
				}
			}

			ViewVehicleFine(playerid, userid);
		}
	}
	return true;
}*/

CMD:admins(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREY, "Admins Online:");

	new
	    count
	;

	foreach (new i : Player)
	{
		if(PlayerData[i][pAdmin] > 0)
		{
		    SendClientMessageEx(playerid, AdminDuty{i} ? COLOR_GREEN : COLOR_GRAD2, " (Level: %d) %s (ID: %d) Em trabalho: %s", PlayerData[i][pAdmin] == 1338 ? 2 : PlayerData[i][pAdmin], AccountName(i), i, AdminDuty{i} ? "Yes" : "No");

			count++;
		}
	}

	if(!count) SendClientMessage(playerid, COLOR_GRAD2, "Não há administradores online.");

	return true;
}

CMD:testers(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GRAD1, "Testers Online:");

	foreach (new i : Player)
	{
		if(PlayerData[i][pAdmin] == -1 || TesterDuty{i})
		{
			SendClientMessageEx(playerid, TesterDuty{i} ? COLOR_GREEN : COLOR_GREY,  "(ID: %d) %s - Em trabalho: %s", i, AccountName(i), TesterDuty{i} ? "Yes" : "No");
		}
	}

	return true;
}

// Fuel

CMD:fill(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está em um veículo.");

	new id, vehicleid = GetPlayerVehicleID(playerid);

	if((id = Car_GetID(vehicleid)) == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve estar em um veículo pessoal.");

	if((id = Business_Nearest(playerid, 20.0)) != -1 && BusinessData[id][bType] == 1)
	{
		new string[256], Float:maxfuel = GetVehicleDataFuel(GetVehicleModel(vehicleid)), Float:fueladd = maxfuel - CoreVehicles[vehicleid][vehFuel];
		format(string, sizeof(string), "{FFFFFF}Fuel Type:{FFFF00}%s\n\t{FFFFFF}Current Fuel:{FFFF00}%.6f{FFFFFF}/{FFFF00}%.6f{FFFFFF}( MAX )\n\tAmount Adding:{FFFF00}%.6f\n\t{FFFFFF}Price:{FFFF00}%s", (BusinessData[id][bsubType]) ? ("Diesel") : ("Petrol"), CoreVehicles[vehicleid][vehFuel], maxfuel, fueladd, FormatNumber(floatround(fueladd*float(BusinessData[id][bItems][0]), floatround_ceil)));
		Dialog_Show(playerid, FuelRefill, DIALOG_STYLE_MSGBOX, "Fuel Purchase:", string, "Purchase", "Cancel");
	}
	else SendServerMessage(playerid, "Você não está perto de um posto de gasolina.");

	return true;
}

Dialog:FuelRefill(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(IsPlayerInAnyVehicle(playerid))
		{
			new id = -1 , vehicleid = GetPlayerVehicleID(playerid);

			if((id = Business_Nearest(playerid, 20.0)) != -1 && BusinessData[id][bType] == 1)
			{
				if(!VehicleLabel[vehicleid][vLabelTime])
				{
				    new
						Float:maxfuel = GetVehicleDataFuel(GetVehicleModel(vehicleid)),
				    	Float:fueladd = maxfuel - CoreVehicles[vehicleid][vehFuel],
						price = floatround(fueladd * float(BusinessData[id][bItems][0]), floatround_ceil)
					;

				    if(PlayerData[playerid][pCash] >= price)
					{
					    new time = 10, timecal = floatround(fueladd, floatround_ceil);

					    if(timecal >= 10) time = (timecal * 2) - (5 * (timecal / 5));

						SetVehicleLabel(vehicleid, VLT_TYPE_REFILL, time);
						CoreVehicles[vehicleid][vOwnerID] = playerid;

						SendClientMessageEx(playerid, COLOR_GREEN, "SERVER: This operation will require %d seconds. Amount:%.6f", time, fueladd);
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem essa quantia de dinheiro!");
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "The vehicle has already started operation.");
			}
			else SendServerMessage(playerid, "Você não está perto de um posto de gasolina.");
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está em um veículo.");
	}
	return true;
}

CMD:motd(playerid, params[]) return showServerMOTD(playerid);

CMD:licencas(playerid, params[])
{
	new
		userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/licencas [id/nome/MaskID]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{s[128]}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "Jogador especificado não está conectado.");
		}
	}

	if(!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Você não está perto desse jogador.");

    LicenseOffer[userid] = playerid;
    ViewingLicense[userid] = INVALID_PLAYER_ID;

    SendNoticeMessage(userid, "%s quer te mostrar a licença dele, Pressione {FFFF00}Y{FFFFFF} para abrir ou {FFFF00}N{FFFFFF} para mostrar no chat.", ReturnName(playerid, 0));
	return true;
}

stock ShowLicensesUI(playerid, forplayerid)
{
	if(playerid == forplayerid)
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s olha para o seu cartão de identidade.", ReturnName(playerid, 0));
	else
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s mostra o seu cartão de identidade para %s.", ReturnName(playerid, 0), ReturnName(forplayerid, 0));

	new str[128], houseid = -1;

	foreach (new h : Property)
	{
	    if(!PropertyData[h][hOwned]) continue;

	    if(PropertyData[h][hOwnerSQLID] == PlayerData[playerid][pID])
	    {
	        houseid = h;
	        break;
	    }
	}

    PlayerTextDrawSetPreviewModel(forplayerid, LicensesUI[forplayerid][1], PlayerData[playerid][pModel]);

	format(str, sizeof(str), "%d", 1000000 + PlayerData[playerid][pID]);
    PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][3], str);

    format(str, sizeof(str), "%s", ReturnFormatName(playerid));
    PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][4], str);

    PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][5], (houseid != -1 ? (ReturnPropertyAddress(houseid)) : ("Sem endereço registrado")));

    if(PlayerData[playerid][pCarLic])
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][6], "Sim");
    else
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][6], "Não");


    if(PlayerData[playerid][pWepLic])
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][7], "Sim");
    else
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][7], "Não");


    if(PlayerData[playerid][pFlyLic])
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][8], "Sim");
    else
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][8], "Não");


    if(PlayerData[playerid][pMedLic])
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][9], "Sim");
    else
		PlayerTextDrawSetString(forplayerid, LicensesUI[forplayerid][9], "Não");


	for(new i = 0; i < 10; ++i) PlayerTextDrawShow(forplayerid, LicensesUI[forplayerid][i]);

	ViewingLicense[forplayerid] = playerid;
}

stock PrintLicenses(playerid, forplayerid)
{
	if(ViewingLicense[forplayerid] == INVALID_PLAYER_ID)
	{
		if(playerid == forplayerid)
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s olha para o seu cartão de identidade.", ReturnName(playerid, 0));
		else
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s mostra o seu cartão de identidade para %s.", ReturnName(playerid, 0), ReturnName(forplayerid, 0));
	}
	else ViewingLicense[forplayerid] = INVALID_PLAYER_ID;

	for(new i = 0; i < 10; ++i) PlayerTextDrawHide(forplayerid, LicensesUI[forplayerid][i]);

	new houseid = -1;

	foreach (new h : Property)
	{
	    if(!PropertyData[h][hOwned]) continue;

		if(PropertyData[h][hOwnerSQLID] == PlayerData[playerid][pID])
	    {
	        houseid = h;
	        break;
	    }
	}

	SendClientMessage(forplayerid, 0x5c92adFF, "|_____ SAN ANDREAS ID _____|");
	SendClientMessageEx(forplayerid, 0x5c92adFF, "| CN: {E6E6E6}%d", 1000000 + PlayerData[playerid][pID]);
	SendClientMessageEx(forplayerid, 0x5c92adFF, "| Nome: {E6E6E6}%s", ReturnNameEx(playerid));
	SendClientMessageEx(forplayerid, 0x5c92adFF, "| Endereço: {E6E6E6}%s", (houseid != -1 ? (ReturnPropertyAddress(houseid)) : ("SEM ENDEREÇO REGISTRADO")));
	SendClientMessageEx(forplayerid, 0x5c92adFF, "| Motorista: {E6E6E6}%s          {5c92ad}Arma: {E6E6E6}%s", PlayerData[playerid][pCarLic] ? ("SIM") : ("NÃO"), PlayerData[playerid][pWepLic] ? ("SIM") : ("NÃO"));
	SendClientMessageEx(forplayerid, 0x5c92adFF, "| Vôo:  {E6E6E6}%s           {5c92ad}Médico: {E6E6E6}%s", PlayerData[playerid][pFlyLic] ? ("SIM") : ("NÃO"), PlayerData[playerid][pMedLic] ? ("SIM") : ("NÃO"));
	return true;
}
