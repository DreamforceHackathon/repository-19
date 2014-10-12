class UserPracticePhoneNumbersController < ApplicationController
  before_action :redirect_to_root_unless_user_signed_in

  def create
    @user_practice_phone_number = UserPracticePhoneNumber.new(user_practice_phone_number_params)
    @user_practice_phone_number.user = User.find_or_create_by(phone_number: user_phone_number_param)

    unless @user_practice_phone_number.save
      if @user_practice_phone_number.errors[:user_id]
        flash[:notice] = "The user was already added to this practice phone number."
      end
    end

    redirect_to @user_practice_phone_number.practice_phone_number
  end

  def destroy
    @user_practice_phone_number = UserPracticePhoneNumber.find(params[:id])

    if @user_practice_phone_number.destroy
      flash[:notice] = "The user was removed from this practice phone number."
    else
      flash[:notice] = "Something went wrong."
    end
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
