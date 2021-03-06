/obj/shuttle_controller/syndicate
	name = "syndicate shuttle controler"
	desc = "Controls the syndicate shuttle."

	transit_start = "syndicate_shuttle_centcomm"
	transit_bluespace = "syndicate_shuttle_bluespace"
	transit_end = "syndicate_shuttle_planet"

	default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME
	default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME * 0.5

/obj/shuttle_controller/syndicate/on_shuttle_think()

	if(state == SHUTTLE_STATE_LANDED)
		display = "Landed"
		if(time >= SHUTTLE_DEFAULT_IDLE_TIME)
			state = SHUTTLE_STATE_WAITING
			time = 0

	return ..()


/obj/shuttle_controller/syndicate/transit(var/starting_transit_id,var/ending_transit_id)

	. = ..()

	if(.)

		if(SShorde.allow_shuttle_launch && starting_transit_id == "syndicate_shuttle_centcomm" && ending_transit_id == "syndicate_shuttle_bluespace")

			var/area/A = get_area(src)
			var/list/mob/living/mobs_to_delete = list()
			var/list/mob/living/found_syndicate = list()

			for(var/mob/living/L in A.contents)
				if(!L.dead && L.client)
					return .
				if(L.iff_tag == "Syndicate")
					found_syndicate += L
				else if(!is_player(L))
					mobs_to_delete += L

			for(var/mob/living/L in mobs_to_delete)
				qdel(L)

			var/list/valid_spots = list()

			for(var/obj/structure/interactive/chair/C in A.contents)
				valid_spots += C.loc

			if(!length(valid_spots))
				log_error("Spawn Error: Couldn't find any chairs to spawn syndicate on!")
				return .

			spawn for(var/i=1,i<=5-length(found_syndicate),i++)
				var/turf/T = pick(valid_spots)
				valid_spots -= T
				var/mob/living/advanced/npc/syndicate/S = new(T)
				INITIALIZE(S)
				sleep(-1)


		if(starting_transit_id == "syndicate_shuttle_bluespace" && ending_transit_id == "syndicate_shuttle_planet")

			var/area/A = get_area(src)

			var/obj/marker/landmark/B = locate(pick("Bravo","Village"))

			if(!B || !B.loc)
				log_error("Path Error: Couldn't find a landmark to go to!")
				return .

			var/obj/marker/map_node/N_end = find_closest_node(B)

			if(!N_end)
				log_error("Path Error: Couldn't find closet node to [B]!")
				return .

			for(var/mob/living/L in A.contents)
				if(L.iff_tag != "Syndicate")
					continue
				if(!L.ai)
					continue

				var/obj/marker/map_node/N_start = find_closest_node(L)
				if(!N_start)
					log_error("Path Error: Couldn't find closet node to [L]!")
					continue

				var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)

				if(!found_path || !length(found_path))
					log_error("Path Error: Couldn't find a path from [L] to [B]!")
					continue

				L.ai.set_path(found_path)

	return .