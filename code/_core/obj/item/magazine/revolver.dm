/obj/item/magazine/clip/revolver/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"

/obj/item/magazine/clip/revolver/bullet_38
	name = "\improper .38 speedloader"
	icon = 'icons/obj/items/magazine/revolver/38.dmi'
	icon_state = "38"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/detective
	)

	ammo = /obj/item/bullet_cartridge/revolver_38

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

/obj/item/magazine/clip/revolver/bullet_44
	name = "\improper .44 magnum speedloader"
	icon = 'icons/obj/items/magazine/revolver/44.dmi'
	icon_state = "44"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/commander,
		/obj/item/weapon/ranged/bullet/revolver/deckhard
	)

	ammo = /obj/item/bullet_cartridge/revolver_44

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 10
	bullet_diameter_best = 10.9
	bullet_diameter_max = 11



/*
/obj/item/magazine/clip/revolver/bullet_44/surplus/
	name = "\improper surplus .44 magnum speedloader"
	ammo = /obj/item/bullet_cartridge/revolver_44/surplus
*/

/obj/item/magazine/clip/revolver/bullet_22
	name = "\improper .22LR speedloader"
	icon = 'icons/obj/items/magazine/revolver/22.dmi'
	icon_state = "22"
	bullet_count_max = 6

	weapon_whitelist = list()

	ammo = /obj/item/bullet_cartridge/pistol_22

/obj/item/magazine/clip/revolver/bullet_357
	name = "\improper .357 speedloader"
	icon = 'icons/obj/items/magazine/revolver/357.dmi'
	icon_state = "357"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/traitor_357
	)

	ammo = /obj/item/bullet_cartridge/revolver_357

	bullet_length_min = 20
	bullet_length_best = 33
	bullet_length_max = 35

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

/*
/obj/item/magazine/clip/revolver/bullet_357/surplus
	name = "\improper surplus .357 speedloader"
	ammo = /obj/item/bullet_cartridge/revolver_357/surplus
*/