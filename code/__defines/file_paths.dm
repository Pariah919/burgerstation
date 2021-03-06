#define SERVER_PATH_FORMAT "data/server/"

#define SOAPSTONE_FILE_FORMAT SERVER_PATH_FORMAT + "soapstone.json"

#define CKEY_PATH_FORMAT "data/users/%CKEY/"

#define CHARACTER_PATH_FORMAT CKEY_PATH_FORMAT + "characters/"
#define CHARACTER_FILE_FORMAT "character_%CID.json"

#define CONNECTION_PATH_FORMAT CKEY_PATH_FORMAT + "connections/"
#define CONNECTION_FILE_FORMAT "%DATE_%TIME.json"