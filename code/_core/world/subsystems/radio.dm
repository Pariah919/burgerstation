var/global/list/all_unprocessed_radio_data = list()

SUBSYSTEM_DEF(radio)
	name = "Radio Subsystem"
	desc = "Controls radios."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

/subsystem/radio/on_life()

	for(var/obj/item/device/radio/R in all_radios)
		if(!R.receiving)
			continue
		for(var/data_key in all_unprocessed_radio_data)
			var/data_value = all_unprocessed_radio_data[data_key]
			R.receive_data(data_value)

	all_unprocessed_radio_data.Cut()

	return TRUE

