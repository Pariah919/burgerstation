/obj/item/clothing/head/helmet/polymorphic
	name = "protective helmet"
	icon = 'icons/obj/items/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_C,
		BOMB = ARMOR_D
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 40

	polymorphs = list(
		"base" = "#FFFFFF",
		"ears" = "#FFFFFF",
		"stripe" = "#FFFFFF"
	)

	no_initial_blend = TRUE


/obj/item/clothing/head/helmet/polymorphic/security
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_SECURITY,
		"stripe" = COLOR_SECURITY
	)

/obj/item/clothing/head/helmet/polymorphic/engineering
	polymorphs = list(
		"base" = "#FFFFFF",
		"ears" = "#FFFFFF",
		"stripe" = "#FFFFFF"
	)

/obj/item/clothing/head/helmet/polymorphic/medical
	polymorphs = list(
		"base" = "#FFFFFF",
		"ears" = "#FFFFFF",
		"stripe" = "#FFFFFF"
	)