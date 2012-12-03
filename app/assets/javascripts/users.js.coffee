# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	# Make sure we are on the right page.
	if $("#new_user").length == 0
		return

	# ----
	# Add the logic for the "Exchange Student" checkbox.
	# ----

	# Retrieve the dom elements.
	check_is_exchange = $("#exchange_student")
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
	# Add the logic for the "Universities" dropdown.
	# ----

	# Retrieve the dom elements.
	country_dropdowns = $(".country-dropdown")

	# Add an event for a selection change on those dropdowns.
	country_dropdowns.change ->
		$this = $(this)

		# Get the selected country Id.
		country_id = $this.val()

		# Retrieve a reference to the corresponding university dropdown.
		university_dropdown = $this.parents(".country-university-group").find(".university-dropdown")

		# Make a request to retrieve the universities for the selected country.
		$.ajax
			url: "/countries/" + country_id + "/universities"
			type: "GET"
			dataType: "json"
			success: (data) =>
				# Clear all the elements in the University Dropdown.
				university_dropdown.empty()

				# Add the retrieved elements.
				$.each(data, ->
					university_dropdown.append($("<option></option>").attr("value", this.id).text(this.name))
				)