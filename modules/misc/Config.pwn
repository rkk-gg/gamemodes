#define SERVER_SITE "ls-rp.com.br"
#define SERVER_MODE "LS-RP 1.0.0"

#if IS_LOCAL_HOST == true
	#define SERVER_NAME "Los Santos Roleplay | ls-rp.com.br"
	#define SQL_HOSTNAME "127.0.0.1"
	#define SQL_USERNAME "root"
	#define SQL_DATABASE "roleplay"
	#define SQL_PASSWORD ""
#else
	#define SERVER_NAME "Los Santos Roleplay | ls-rp.com.br"
	#define SQL_HOSTNAME "127.0.0.1"
	#define SQL_USERNAME "root"
	#define SQL_DATABASE "roleplay"
	#define SQL_PASSWORD ""
#endif

#define MAX_CHARACTERS (6)

new
	modelsURL[] = "http://127.0.0.1/models/",
	RegistrationEnabled = false,
	MySQL:dbCon
;
