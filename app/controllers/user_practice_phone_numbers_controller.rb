class UserPracticePhoneNumbersController < ApplicationController

  def create
    @user_practice_phone_number = UserPracticePhoneNumber.new(user_practice_phone_number_params)
    @user_practice_phone_number.user = User.find_or_create_by(phone_number: user_phone_number_param)
    @user_practice_phone_number.save
    redirect_to @user_practice_phone_number.practice_phone_number
  end

private

  def user_practice_phone_number_params
    params.require(:user_practice_phone_number).permit(:practice_phone_number_id)
  end

  def user_phone_number_param
    params[:user_practice_phone_number][:user_attributes][:phone_number]
  rescue NoMethodError
  end

end
