$ ->
	# --
	# Code to to vertically center the university picture.
	# --

	# Check if the picture is present on the current page.
	university_img = $(".university-img img")
	return if university_img.length == 0

	# Add an event handler for when the picture is loaded.
	university_img[0].onload = ->
		# Once loaded, vertically center the picture.
		university_img.css("margin-top", -((university_img.height() - university_img.parent().height()) / 2))

	# Start loading the picture by setting its URL.
	university_img.attr("src", university_img.data("url"))