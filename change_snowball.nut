try {
	if(chs_TIMER_NAME){}
} catch {
	chs_TIMER_NAME <- "chs_replace_snowball";
	chs_ball <- "props/de_dust/hr_dust/dust_soccerball/dust_soccer_ball001.mdl";
	chs_snowballs <- [
		"models/weapons/w_eq_snowball.mdl",
		"models/weapons/w_eq_snowball_dropped.mdl",
		"models/weapons/w_snowball.mdl"
	];
	Entities.First().PrecacheModel(chs_ball);
}

function chs_CreateTimer(tm = null){
	if(!Entities.FindByName(null, chs_TIMER_NAME)) {
		tm = Entities.CreateByClassname("logic_timer");
		SetKeyValue(tm, "targetname", chs_TIMER_NAME);
		SetKeyValue(tm, "refiretime", "0.1");
		tm.ConnectOutput("OnTimer", "chs_Change");
		SetKeyValue(tm, "classname", "soundent");
		ent_fire(tm, "disable");
	}
}

function chs_EnableChanging(){ent_fire(chs_TIMER_NAME, "Enable")}
function chs_DisableChanging(){ent_fire(chs_TIMER_NAME, "Disable")}

function chs_Change(snowball = null) {
	foreach(snow_model in snowballs) {
		while((nowball = Entities.FindByModel(snowball, snow_model)) {
			snowball.SetModel(ball);
		}
	}
}

function SetKeyValue(ent, parametr, value){
	switch(typeof(parametr)){
		case "float":
			ent.__KeyValueFromFloat(parametr, value);
			break;
		case "integer":
			ent.__KeyValueFromInt(parametr, value);
			break;
		case "string":
			ent.__KeyValueFromString(parametr, value);
			break;
		case "Vector":
			ent.__KeyValueFromVector(parametr, value);
			break;
	}
}
function ent_fire(ent, action, value="", delay=0, activator=null, caller=null){
	switch(typeof ent){
		case "string":
			EntFire(ent, action, value, delay, activator);
			break;
		case "instance":
			EntFireByHandle(ent, action, value, delay, activator, caller);
			break;
	}
}

chs_CreateTimer();
ScriptPrintMessageChatAll("script chs_EnableChanging()\t вкл скрипт");
ScriptPrintMessageChatAll("script chs_chs_DisableChanging()\t выкл скрипт");