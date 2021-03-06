/*
/proc/broadcast(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/mob/object in world)
		object.to_chat(text_to_say)
*/

/proc/broadcast_to_clients(var/text_to_say as text, var/text_type = TEXT_OOC)
	for(var/client/C in all_clients)
		C.to_chat(text_to_say,TEXT_OOC)

proc/display_message(var/atom/speaker, var/atom/source, var/text_to_say as text, var/text_type as num,var/frequency=RADIO_FREQ_COMMON)

	if(!text_to_say)
		return FALSE

	var/turf/source_turf = get_turf(source)

	switch(text_type)
		if(TEXT_RADIO)
			for(var/mob/M in range(RADIO_RANGE,source_turf))
				if(!M.client)
					continue
				M.to_chat(format_speech(speaker,source,text_to_say,text_type,frequency),CHAT_TYPE_RADIO)
				sleep(-1)
			//We don't send to other radios because that's a fucking terrible idea.
		if(TEXT_WHISPER)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(WHISPER_RANGE,source_turf))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)
					sleep(-1)

				for(var/obj/item/device/radio/R in all_radios)
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_WHISPER_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))
					sleep(-1)

		if(TEXT_TALK)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(TALK_RANGE,source_turf))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)
					sleep(-1)

				for(var/obj/item/device/radio/R in all_radios)
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_TALK_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))
					sleep(-1)

		if(TEXT_YELL)
			if(istype(source,/client/))
				var/client/C = source
				C.to_chat("You cannot talk like this!")
				return
			else
				for(var/mob/M in range(YELL_RANGE,source_turf))
					if(!M.client)
						continue
					M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)
					sleep(-1)

				for(var/obj/item/device/radio/R in all_radios)
					if(!R.broadcasting || get_dist(source_turf,R) > RADIO_YELL_RANGE)
						continue
					R.send_data(list("speaker" = speaker, "source" = source, "message" = text_to_say))
					sleep(-1)

		if(TEXT_LOOC)
			for(var/mob/M in range(YELL_RANGE,source_turf))
				if(!M.client)
					continue
				M.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_LOOC)
				sleep(-1)

		if(TEXT_OOC)
			for(var/client/C in all_clients)
				if(!C.mob)
					continue
				C.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_OOC)
				sleep(-1)

			if(SSwikibot && ENABLE_WIKIBOT)
				SSwikibot.process_string(source,text_to_say)

		if(TEXT_GHOST)
			for(var/client/C in all_clients)
				if(!C.mob || !is_observer(C.mob))
					continue
				C.to_chat(format_speech(speaker,source,text_to_say,text_type),CHAT_TYPE_SAY)

	if(text_type == TEXT_TALK || text_type == TEXT_YELL)
		var/area/A = get_area(source)
		if(A && !(A.flags_area & FLAGS_AREA_SINGLEPLAYER))
			new/obj/effect/chat_text(source,text_to_say)


/atom/proc/visible_message(var/third_person_text,var/first_person_text,var/blind_text,var/view_range=VIEW_RANGE)

	if(src.x == 0 && src.y == 0 && src.z == 0)
		return

	if(!first_person_text)
		first_person_text = third_person_text

	if(!blind_text)
		blind_text = third_person_text

	for(var/mob/M in all_mobs_with_clients)

		if(!M.client) //Just in case.
			continue

		if(get_dist(M,src) > view_range)
			continue

		if(M.see_invisible < src.invisibility)
			continue

		var/local_first_person_text
		var/local_third_person_text
		var/local_blind_text

		var/distance = get_dist(M,src)
		if(M == src)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			local_blind_text = span("distance_medium",blind_text)
		else if(distance <= 2)
			local_first_person_text = span("distance_large",first_person_text)
			local_third_person_text = span("distance_large",third_person_text)
			local_blind_text = span("distance_large",blind_text)
		else if(distance <= 4)
			local_first_person_text = span("distance_medium",first_person_text)
			local_third_person_text = span("distance_medium",third_person_text)
			local_blind_text = span("distance_medium",blind_text)
		else if(distance <= 6)
			local_first_person_text = span("distance_small",first_person_text)
			local_third_person_text = span("distance_small",third_person_text)
			local_blind_text = span("distance_small",blind_text)
		else
			local_first_person_text = span("distance_tiny",first_person_text)
			local_third_person_text = span("distance_tiny",third_person_text)
			local_blind_text = span("distance_tiny",blind_text)

		if(src in view(M.client.eye))
			if(src == M)
				M.to_chat(local_first_person_text)
			else
				M.to_chat(local_third_person_text)
		else
			M.to_chat(local_blind_text)

		sleep(-1)





