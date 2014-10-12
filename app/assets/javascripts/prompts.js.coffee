$ ->

  $(document).on "click", "a.edit_prompt", (event) ->
    event.preventDefault()
    $(this).closest("li.prompt").find("form.edit_prompt").show()
