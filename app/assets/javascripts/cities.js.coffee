$ ->
    # Make sure we are on right page.
    return if $(".city_find_form").length == 0

    # ---
    # Add the logic for the country and city dropdowns.
    # ---

    # Retrieve the DOM elements.
    country_dropdown = $(".country-dropdown")
    city_dropdown = $(".city-dropdown")

    default_city_text = city_dropdown.find("option[value='-1']").text()

    # Add an event for a selection change on the Country Dropdown.
    country_dropdown.change ->
        $this = $(this)

        # Get the selected country Id.
        country_id = $this.val()

        if country_id < 0
            city_dropdown.prop("disabled", true)
        else
            city_dropdown.prop("disabled", false)

            # Update the city dropdown accordingly using helper methods.
            $.helpers.update_dropdown("/countries/#{country_id}/cities", city_dropdown, true, default_city_text)

    # Ass an event for a selection change on the City Dropdown.
    city_dropdown.change ->
        $this = $(this)

        # Get the selected city Id.
        city_id = $this.val()

        return if city_id < 0

        # Navigate to the selected city.
        window.location.href = "/cities/" + city_id

    # Trigger the initial change event on the Country Dropdown.
    country_dropdown.trigger "change"

    return 