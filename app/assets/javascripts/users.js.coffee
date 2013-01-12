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
	dropdowns_original_values = $(".original-location")

	additional_option = "Other"

	# Add an event for a selection change on the University dropdowns.
	update_cities = (country_dropdown, callback) ->
		# Get the selected country Id.
		country_id = country_dropdown.val()

		# Retrieve a reference to the corresponding city dropdown.
		city_dropdown = country_dropdown.parents(".country-university-group").find(".city-dropdown")
		university_dropdown = country_dropdown.parents(".country-university-group").find(".university-dropdown")

		# Update the city dropdown.
		$.helpers.update_dropdown_cities("/countries/#{country_id}/cities", city_dropdown, true, additional_option, callback)

		# Also reset the corresponding university dropdown.
		$.helpers.reset_dropdown(university_dropdown, additional_option)

	country_dropdowns.change ->
		update_cities $(this)

	# Add an event for a selection change on the City dropdowns.
	update_universities = (city_dropdown, callback) -># Get the selected city Id.
		city_id = city_dropdown.val()

		# Retrieve a reference to the corresponding university dropdown.
		university_dropdown = city_dropdown.parents(".country-university-group").find(".university-dropdown")
	
		# Update the university dropdown.
		$.helpers.update_dropdown_universities("/cities/#{city_id}/universities", university_dropdown, true, additional_option, callback)

	city_dropdowns.change ->
		update_universities $(this)

	# Process the original values of the dropdowns.
	dropdowns_original_values.each (index, value) ->
		$value = $(value)

		# Extract the original values for, respectively, the country, the city, and the university.
		original_values = $value.data("location").split(",")

		return if original_values.length < 3

		# Select the country.
		country_dropdown = $value.parents(".country-university-group").find(".country-dropdown")
		country_dropdown.val(original_values[0])

		# Update the city dropdown with this new country value.
		update_cities country_dropdown, ->
			# Select the city.
			city_dropdown = $value.parents(".country-university-group").find(".city-dropdown")
			city_dropdown.val(original_values[1])

			# Update the university dropdown with this new city value.
			update_universities city_dropdown, ->
				# Select the university.
				university_dropdown = $value.parents(".country-university-group").find(".university-dropdown")
				university_dropdown.val(original_values[2])

		# TODO: Find a more elegant way, if possible, than nested callbacks.

	return
