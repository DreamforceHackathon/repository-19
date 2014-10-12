$ ->

  $(document).on "click", "a.edit_scenario", (event) ->
    $(this).closest("li.scenario").find("form.edit_scenario").show()
    event.preventDefault()
