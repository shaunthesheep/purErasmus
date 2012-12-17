$ ->
	# Make sure we are on the right page.
	return if $(".user_edit_form").length == 0

	# ----
	# Add the logic for the "Exchange Student" checkbox.
	# ----

	# Retrieve the DOM elements.
	check_is_exchange = $(".cb_is_exchange_student")
	div_exchange_student_location = $("#exchange_student_location")

	# Add an event for a change of state for the checkbox.
	check_is_exchange.change ->
		# If the checkbox is checked, show the fields.
		if check_is_exchange.is ":checked"
			div_exchange_student_location.show()
		# If not, hide them.
		else
			div_exchange_student_location.hide()

	# Trigger the event a first time for initial state.
	check_is_exchange.trigger "change"

	# ----
	# Add the logic for the "Universities" and "Cities" dropdown.
	# ----

	# Retrieve the dom elements.
	country_dropdowns = $(".country-dropdown")
	city_dropdowns = $(".city-dropdown")

	additional_option = "Other"

	# Add an event for a selection change on the University dropdowns.
	country_dropdowns.change ->
		$this = $(this)

		# Get the selected country Id.
		country_id = $this.val()

		# Retrieve a reference to the corresponding city dropdown.
		city_dropdown = $this.parents(".country-university-group").find(".city-dropdown")
		university_dropdown = $this.parents(".country-university-group").find(".university-dropdown")

		# Update the city dropdown.
		$.helpers.update_dropdown("/countries/#{country_id}/cities", city_dropdown, true, additional_option)

		# Also reset the corresponding university dropdown.
		$.helpers.reset_dropdown(university_dropdown, additional_option)

	# Add an event for a selection change on the City dropdowns.
	city_dropdowns.change ->
		$this = $(this)

		# Get the selected city Id.
		city_id = $this.val()

		# Retrieve a reference to the corresponding university dropdown.
		university_dropdown = $this.parents(".country-university-group").find(".university-dropdown")
	
		# Update the university dropdown.
		$.helpers.update_dropdown("/countries/#{city_id}/universities", university_dropdown, true, additional_option)

	return
