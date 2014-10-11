$ ->

  $(document).on "click", "a.edit_practice_phone_number", (event) ->
    event.preventDefault()
    $("form.edit_practice_phone_number").show()
    $("div.practice_phone_number_header").hide()
