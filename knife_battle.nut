class knife_player {
    player = null

    constructor(_h) {
        player = _h
    }

    function StripWep() {
        local w;
        while (w = Entities.FindByClassname(w, "weapon*"))
            if (w.GetOwner() == player && w.GetClassname() != "weapon_knife") w.Destroy()
    }
}

knife_tick <- function() {
    local p;
    while (p = Entities.FindByClassname(p, "player")) {
        local flag = false;
        foreach(pl in knife_pls) if (pl.player == p) flag = true;
        if (!flag) knife_pls.append(knife_player(p))
    }
    for (local i = 0; i < knife_pls.len(); i++) {
        local sc = knife_pls[i]
        local p = sc.player
        if (!p.IsValid()) {
            knife_pls.remove(i);
            continue;
        }
    }
    foreach(pl in knife_pls) pl.StripWep();
}

knife_tm <- function() {
    local tm = Entities.CreateByClassname("logic_timer")
    skv(tm, "refiretime", 0.3)
    skv(tm, "classname", "soundent")
    skv(tm, "targetname", "knife_tm")
    tm.ConnectOutput("OnTimer", "knife_tick")
    EF(tm, "enable")
}

disable_knife_battle <- function() {
    EF("knife_tm", "kill")
    delete MRSHK_KNIFE_BATTLE, knife_pls, knife_tm, knife_tick, knife_player
}

function skv(h, k, v, t = 0) {
    t = typeof v
    if (t == "float") {
        h.__KeyValueFromFloat(k, v)
    } else if (t == "integer") {
        h.__KeyValueFromInt(k, v)
    } else if (t == "string") h.__KeyValueFromString(k, v)
}

function EF(h, i, v = "", d = 0, a = null, c = null) {
    if (typeof h == "string") {
        EntFire(h, i, v, d, a)
    } else if (typeof h == "instance") EntFireByHandle(h, i, v, d, a, c)
}

function bot_pl() {
    local b;
    while (b = Entities.FindByClassname(b, "cs_bot")) b.__KeyValueFromString("targetname", b.GetName() == "" ? "" : b.GetName())
}

try {
    if (MRSHK_KNIFE_BATTLE) {}
} catch (a) {
    MRSHK_KNIFE_BATTLE <-true
    bot_pl()
    knife_pls <-[]
    knife_tm()
}