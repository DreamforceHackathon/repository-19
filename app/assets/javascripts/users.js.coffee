clean_phone_number = (value) ->
  value = value.replace(/\D/g, "")
  return "+1" + value if /^\d{10}$/.test(value)
  return "+" + value if /^\d{11,}$/.test(value)
  return value

$ ->
  $(document).on "submit", "form[action='/users/sign_in']", (event) ->
    i = $(this).find("input[name='user[phone_number]']")
    i.val(clean_phone_number(i.val()))
    event.preventDefault()
