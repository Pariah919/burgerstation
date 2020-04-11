/obj/item/defib
	name = "defibrillator"
	icon = 'icons/obj/items/defib.dmi'
	desc = "Contains a lot of atoms!"
	desc_extended = "Put it on your back and after that take out the paddles and apply them on a recently dead person."

	var/obj/item/defib_paddle/paddle_left
	var/obj/item/defib_paddle/paddle_right

	worn_layer = LAYER_MOB_CLOTHING_BACK
	item_slot = SLOT_TORSO_B
	slot_icons = TRUE

	value = 110

/obj/item/defib/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/defib/New(var/desired_loc)

	paddle_left = new /obj/item/defib_paddle(src)
	paddle_left.linked_defib = src

	paddle_right = new /obj/item/defib_paddle(src)
	paddle_right.linked_defib = src

	return ..()


/obj/item/defib/proc/on_paddle(var/mob/caller)

	if(!paddle_left.placed_target_ref || !paddle_right.placed_target_ref || paddle_left.placed_target_ref != paddle_right.placed_target_ref)
		return FALSE

	var/mob/living/target = locate(paddle_left.placed_target_ref)
	if(!target)
		return FALSE

	caller.visible_message("\The [caller.name] charges up \the [src.name]...","You charge up \the [src.name]...")

	play('sounds/items/defib/defib_charge.ogg',src)

	PROGRESS_BAR(caller,src,30,.proc/defib_target,caller,target)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_defib_target,caller,target)

	return TRUE

/obj/item/defib/proc/can_defib_target(var/mob/caller,var/mob/living/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	return TRUE

/obj/item/defib/proc/defib_target(var/mob/caller,var/mob/living/target)

	target.add_adrenaline(300)

	caller.visible_message("\The [caller.name] shocks \the [target.name] with \the [src.name]!","You shock \the [target.name] with \the [src.name]!")

	play('sounds/items/defib/defib_zap.ogg',src)

	if(target.check_death() && !target.client)
		target.visible_message("Nothing happens!")
		play('sounds/items/defib/defib_failed.ogg',src)
		return FALSE

	play('sounds/items/defib/defib_ready.ogg',src)

	target.revive()
	caller.visible_message("\The [target.name] jolts to life!")

	return TRUE

/obj/item/defib/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object) && is_inventory(src.loc) && is_advanced(caller))
		var/obj/hud/inventory/I = src.loc
		var/obj/hud/inventory/I2 = object
		if(src in I.worn_objects)
			if(paddle_left in src.contents)
				I2.add_held_object(paddle_left)
				return TRUE
			else if(paddle_right in src.contents)
				I2.add_held_object(paddle_right)
				return TRUE

	return ..()

/obj/item/defib_paddle
	name = "defibrillator paddle"
	icon = 'icons/obj/items/defib_paddle.dmi'
	var/obj/item/defib/linked_defib
	var/placed_target_ref //While refs can be replaced by other objects, placing the last paddle with check if it's a valid ref.

	throwable = FALSE

	value = 10

/obj/item/defib_paddle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object == linked_defib)
		drop_item(get_turf(src))
		return TRUE

	if(is_living(object))
		caller.visible_message("\The [caller.name] places \a [src.name] on [object.name]'s chest...","You place \the [src.name] on \the [object.name]'s chest...")
		placed_target_ref = "\ref[object]"
		linked_defib.on_paddle(caller)
		return TRUE

	return ..()

/obj/item/defib_paddle/drop_item(var/turf/new_location,var/pixel_x_offset = 0,var/pixel_y_offset = 0)

	. = ..()

	if(. && linked_defib)
		placed_target_ref = null
		src.force_move(linked_defib)

	return .
