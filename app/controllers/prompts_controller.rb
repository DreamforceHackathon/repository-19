class PromptsController < ApplicationController

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
      flash[:notice] = "The prompt was added to the scenario."
    else
      flash[:notice] = "The prompt could not be added to the scenario."
    end
    redirect_to @prompt.practice_phone_number
  end

  def destroy
    @prompt = Prompt.find(params[:id])
    @prompt.destroy
    flash[:notice] = "The prompt was removed."
    redirect_to @prompt.practice_phone_number
  end

  def update
    @prompt = Prompt.find(params[:id])
    if @prompt.update(prompt_params)
      flash[:notice] = "Thr prompt was moved."
    end
    redirect_to @prompt.practice_phone_number
  end

private

  def prompt_params
    params.require(:prompt).permit(:content, :scenario_id, :sequence_position)
  end

end
