#define METABOLISM_BLOOD 0.2
#define METABOLISM_STOMACH METABOLISM_BLOOD * 0.75
#define METABOLISM_SKIN METABOLISM_BLOOD * 10
#define OVERDOSE_THRESHOLD_MEDICINE 30

/reagent/medicine/
	metabolism_stomach = METABOLISM_STOMACH //How many units of the reagent to metabolize per second.
	metabolism_blood = METABOLISM_BLOOD //How many units of the reagent to metabolize per second.
	metabolism_skin = METABOLISM_SKIN //How many units of the reagent to metabolize per second.
	overdose_threshold = OVERDOSE_THRESHOLD_MEDICINE

	value = 0.1

/reagent/medicine/on_overdose(var/atom/original_owner,var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/metabolism_amount=0)

	. = ..()

	if(original_owner && original_owner.health)
		original_owner.health.adjust_loss_smart(tox=.)

	return .

/reagent/medicine/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	desc = "Red for brute."
	color = "#FF0000"

	flavor = "bandaids"

/reagent/medicine/bicaridine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_C)

	return .

/reagent/medicine/bicaridine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_D)

	return .

/reagent/medicine/bicaridine_plus
	name = "Bicaridine+"
	id = "bicaridine_plus"
	color = "#FF0080"

/reagent/medicine/bicaridine_plus/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_B)

	return .

/reagent/medicine/bicaridine_plus/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_C)

	return .

/reagent/medicine/kelotane
	name = "Kelotane"
	id = "kelotane"
	desc = "Yellow for burn."
	color = "#FFFF00"

	flavor = "ointment"

/reagent/medicine/kelotane/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-HEALING_C)


	return .

/reagent/medicine/kelotane/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-HEALING_D)

	return .

/reagent/medicine/dylovene
	name = "Dylovene"
	id = "dylovene"
	desc = "Green for toxin."
	color = "#00FF00"

	flavor = "sweetness"

/reagent/medicine/dylovene/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*-HEALING_C)

	return .

/reagent/medicine/dylovene/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*-HEALING_D)

	return .

/reagent/medicine/dexalin
	name = "Dexalin"
	id = "dexalin"
	desc = "Blue for oxy."
	color = "#0000FF"

	flavor = "bitterness"

/reagent/medicine/dexalin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-HEALING_C)

	return .

/reagent/medicine/dexalin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(oxy=.*-HEALING_D)

	return .

/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	id = "tricordrazine"
	desc = "Heals everything except for oxygen loss."
	color = "#B21FFF"

	flavor = "sourness"

	metabolism_blood = METABOLISM_BLOOD*0.75
	metabolism_stomach = METABOLISM_STOMACH*0.75

/reagent/medicine/tricordrazine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_D,burn=.*-HEALING_D,tox=.*-HEALING_D)

	return .

/reagent/medicine/tricordrazine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_E,burn=.*-HEALING_E,tox=.*-HEALING_E)

	return .

/reagent/medicine/omnizine
	name = "Omnizine"
	id = "omnizine"
	desc = "Heals everything."
	desc_extended = "Works just as good when consumed."
	color = "#F7F7F7"

	flavor = "bitter sourness"

	metabolism_blood = METABOLISM_BLOOD*0.5
	metabolism_stomach = METABOLISM_STOMACH*0.5

/reagent/medicine/omnizine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_D,burn=.*-HEALING_D,tox=.*-HEALING_D,oxy=.*-HEALING_D)

	return .

/reagent/medicine/omnizine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_E,burn=.*-HEALING_E,tox=.*-HEALING_E,oxy=.*-HEALING_E)

	return .


/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	id = "silver_sulfadiazine"
	desc = "Heals burn damage. Only works when applied to skin."
	desc_extended = ""
	color = "#E8BEED"

	flavor = "bitter silver"

	metabolism_skin = METABOLISM_STOMACH

/reagent/medicine/silver_sulfadiazine/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(burn=.*-HEALING_B)

	return .

/reagent/medicine/silver_sulfadiazine/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(container.owner && container.owner.health)
		container.owner.health.adjust_loss_smart(burn=.*-HEALING_D)
		container.remove_reagent(id,. * 0.5)

	return .

/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	id = "styptic_powder"
	desc = "Heals brute damage. Only works when applied to skin."
	desc_extended = ""
	color = "#FFC9DD"

	flavor = "baby powder"

	metabolism_skin = METABOLISM_STOMACH


/reagent/medicine/styptic_powder/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(container.owner && container.owner.health)
		container.owner.health.adjust_loss_smart(brute=.*-HEALING_D)
		container.remove_reagent(id,. * 0.5)

	return .

/reagent/medicine/styptic_powder/on_metabolize_skin(var/atom/owner,var/reagent_container/container,var/starting_volume=0)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(brute=.*-HEALING_B)

	return .

/reagent/medicine/epinephrine
	name = "epinephrine"
	id = "epinephrine"
	desc = "Prevents people from dying by increasing the amount of damage one must take before succumbing to death."
	desc_extended = ""
	color = "#FFFFFF"
	flavor = "bandaids"

	metabolism_blood = 1
	metabolism_stomach = 1

/reagent/medicine/epinephrine/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_adrenaline(.*50)

	return .

/reagent/medicine/epinephrine/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0)
	. = ..()

	if(is_living(owner))
		var/mob/living/L = owner
		L.add_adrenaline(.*50)

	return .