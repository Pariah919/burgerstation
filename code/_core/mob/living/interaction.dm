mob/living/on_right_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/on_left_down(object,location,control,params)
	return src.attack(src,object,params)


mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	var/final_pronoun = "They"
	if(examiner == src)
		final_pronoun = "You"

	if(health)
		if(health.damage[TOX] >= 25)
			. += div("warning","[final_pronoun] looks a bit sickly.")

		if(health.damage[OXY] >= 25)
			. += div("warning","[final_pronoun] looks a bit pale.")

	if(status & FLAG_STATUS_CRIT)
		. += list(div("warning","They do not appear to be breathing."))

	if(dead)
		if(client)
			. += list(div("warning","They lay dead and lifeless."))
		else
			. += list(div("warning","They lay dead and lifeless, and their soul has departed."))

	return .