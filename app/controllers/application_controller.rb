class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :sign_in_with_signature, if: -> { params["s"] }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  def redirect_to_root_unless_user_signed_in
    unless current_user
      redirect_to root_path, notice: "You must be logged in to view that page."
    end
  end

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |action|
      devise_parameter_sanitizer.for(action) << :first_name
      devise_parameter_sanitizer.for(action) << :last_name
    end
    devise_parameter_sanitizer.for(:sign_up) << :password_required
  end

  def sign_in_with_signature
    user = User.find_by_signature(params["s"])

    # if they signed in with a signature
    # that is the same as confirming
    user.confirm! if not user.confirmed?

    sign_in(user)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, notice: "That was not a valid signature."
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
