var/global/list/all_reagents = list()

var/global/list/all_reagent_recipes = list()

var/global/list/reagent_container/all_reagent_containers = list()

SUBSYSTEM_DEF(reagent)
	name = "Reagent Subsystem"
	desc = "Store all the reagents."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(1)

/subsystem/reagent/on_life()

	for(var/reagent_container/R in all_reagent_containers)

		if(R.flags_temperature & REAGENT_TEMPERATURE_NO_AMBIENT)
			continue

		R.process_temperature()

	return TRUE

/subsystem/reagent/Initialize()

	for(var/k in subtypesof(/reagent/))
		var/reagent/R = k
		var/id = initial(R.id)
		if(id)
			R = new k
			all_reagents[id] = R

	log_subsystem(name,"Initialized [length(all_reagents)] reagents.")

	for(var/k in subtypesof(/reagent_recipe/))
		var/reagent_recipe/R = k
		var/id = initial(R.id)
		if(id)
			R = new k
			all_reagent_recipes[id] = new k

	log_subsystem(name,"Initialized [length(all_reagent_recipes)] reagent recipes.")