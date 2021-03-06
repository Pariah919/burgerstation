var/global/list/tracked_bosses = list()

SUBSYSTEM_DEF(bosses)
	name = "Boss Subsystem"
	desc = "Tracks which players are bossfighting someone."
	tick_rate = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_IMPORTANT

/subsystem/bosses/on_life()

	for(var/k in tracked_bosses)
		var/mob/living/L = tracked_bosses[k]
		if(L.dead)
			for(var/mob/living/advanced/P in L.players_fighting_boss)
				L.remove_player_from_boss(P)
			continue

		if(L.ai)
			var/ai/AI = L.ai
			if(AI.objective_attack)
				for(var/mob/living/advanced/P in view(L,L.boss_range))
					L.add_player_to_boss(P)

		for(var/mob/living/advanced/P in L.players_fighting_boss)
			if(get_dist(P,L) >= L.boss_range*2)
				L.remove_player_from_boss(P)

	return TRUE

/mob/living/proc/update_boss_health()
	for(var/mob/living/advanced/P in players_fighting_boss)
		for(var/obj/hud/button/boss_health/B in P.buttons)
			B.target_boss = src
			B.update_stats()

/mob/living/proc/add_player_to_boss(var/mob/living/advanced/player/P)
	if(P in src.players_fighting_boss)
		return FALSE
	players_fighting_boss += P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_boss = src
		B.update_stats()

/mob/living/proc/remove_player_from_boss(var/mob/living/advanced/player/P)
	if(!(P in src.players_fighting_boss))
		return FALSE
	players_fighting_boss -= P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_boss = null
		B.update_stats()