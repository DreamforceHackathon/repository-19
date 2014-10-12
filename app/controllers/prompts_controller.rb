class PromptsController < ApplicationController
  before_action :redirect_to_root_unless_user_signed_in

  def create
    @prompt = Prompt.new(prompt_params)
    authorize @prompt

    if @prompt.save
      flash[:notice] = "The prompt was added to the scenario."
    else
      flash[:notice] = "The prompt could not be added to the scenario."
    end
    redirect_to @prompt.practice_phone_number
  end

  def destroy
    @prompt = Prompt.find(params[:id])
    authorize @prompt

    @prompt.destroy
    flash[:notice] = "The prompt was removed."
    redirect_to @prompt.practice_phone_number
  end

  def update
    @prompt = Prompt.find(params[:id])
    authorize @prompt

    if @prompt.update(prompt_params)
      flash[:notice] = "The prompt was updated."
    end
    redirect_to @prompt.practice_phone_number
  end

private

  def prompt_params
    params.require(:prompt).permit(:content, :scenario_id, :sequence_position)
  end

end
