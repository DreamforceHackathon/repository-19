class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

private

  def redirect_to_root_unless_current_user
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

end
