$ ->
	# Make sure we are on the right page.
	if $(".user_edit_form").length == 0
		return

	# ----
	# Add the logic for the "Exchange Student" checkbox.
	# ----

	# Retrieve the dom elements.
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

	# Add an event for a selection change on the University dropdowns.
	country_dropdowns.change ->
		$this = $(this)

		# Get the selected country Id.
		country_id = $this.val()

		# Retrieve a reference to the corresponding city dropdown.
		city_dropdown = $this.parents(".country-university-group").find(".city-dropdown")
		university_dropdown = $this.parents(".country-university-group").find(".university-dropdown")

		# Update the city dropdown.
		update_dropdown("/countries/#{country_id}/cities", city_dropdown)

		# Also reset the corresponding university dropdown.
		reset_dropdown(university_dropdown)

	# Add an event for a selection change on the City dropdowns.
	city_dropdowns.change ->
		$this = $(this)

		# Get the selected city Id.
		city_id = $this.val()

		# Retrieve a reference to the corresponding university dropdown.
		university_dropdown = $this.parents(".country-university-group").find(".university-dropdown")
	
		# Update the university dropdown.
		update_dropdown("/countries/#{city_id}/universities", university_dropdown)

	return

# ----
# Common methods.
# ----

# Method to update a Dropdown by retrieving a list of values.
update_dropdown = (url, dropdown_to_update) ->
	# Make a request to retrieve the universities for the selected country.
	$.ajax
		url: url
		type: "GET"
		dataType: "json"
		success: (data) =>
			# Reset the DropDown.
			reset_dropdown(dropdown_to_update)

			# Add the retrieved elements.
			$.each(data, ->
				dropdown_to_update.append(create_select_option(this.id, this.name))
			)

# Empty a Dropdown and add the "Other" value.
reset_dropdown = (dropdown_to_reset) ->
	dropdown_to_reset.empty()
	dropdown_to_reset.append(create_select_option(-1, "Other"))

# Method to create the Select Option from a value and a text.
create_select_option = (value, text) ->
	$("<option></option>").attr("value", value).text(text)
