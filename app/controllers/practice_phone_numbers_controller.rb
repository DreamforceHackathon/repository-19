class PracticePhoneNumbersController < ApplicationController
  before_action :redirect_to_root_unless_user_signed_in

  def index
    @practice_phone_numbers = policy_scope(PracticePhoneNumber)
  end

  def new
    @practice_phone_number = PracticePhoneNumber.new
  end

  def create
    @practice_phone_number = PracticePhoneNumber.new(practice_phone_number_params)
    @practice_phone_number.owner = current_user
    if @practice_phone_number.save
      flash[:notice] = "Practice phone number purchased successfully."
      redirect_to @practice_phone_number
    else
      render :new
    end
  end

  def show
    @practice_phone_number = PracticePhoneNumber.find(params[:id])
    authorize @practice_phone_number
  end

  def update
    @practice_phone_number = PracticePhoneNumber.find(params[:id])
    if @practice_phone_number.update(practice_phone_number_params)
      flash[:notice] = "Practice phone number updated successfully."
    end
    redirect_to @practice_phone_number
  end

private

  def practice_phone_number_params
    params.require(:practice_phone_number).permit(:name)
  end

end
