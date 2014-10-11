module UsersHelper
  def user_password_input_hint(minimum_password_length, validatable)
    return unless validatable
    "(#{minimum_password_length} characters minimum)"
  end
end
