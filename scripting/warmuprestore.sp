#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "1.0.0"

public Plugin myinfo = {
	name = "Warmup Restore",
	author = "Demetrius",
	description = "Restore the old CS:GO warmup, without the 1v1 arenas",
	version = PLUGIN_VERSION,
	url = "https://github.com/stalsus/warmuprestore"
};

public void OnEntityCreated(int entity, const char[] classname) {
	if (StrEqual(classname, "logic_script", true) || StrEqual(classname, "trigger_multiple", true)) {
		SDKHook(entity, SDKHook_Spawn, SDK_OnEntitySpawn);
	}
}

public void SDK_OnEntitySpawn(int entity) {
	char vScripts[256];
	GetEntPropString(entity, Prop_Data, "m_iszVScripts", vScripts, sizeof(vScripts));
	
	if (StrEqual(vScripts, "warmup/warmup_arena.nut", true) || StrEqual(vScripts, "warmup/warmup_teleport.nut", true)) {
		DispatchKeyValue(entity, "vscripts", "");
		DispatchKeyValue(entity, "targetname", "");
	}
}