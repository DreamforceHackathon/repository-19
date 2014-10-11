class ScenariosController < ApplicationController

  def create
    @scenario = Scenario.new(scenario_params)
    if @scenario.save
      flash[:notice] = "The scenario was added."
    else
      flash[:notice] = "There was a problem adding the scenario."
    end
    redirect_to @scenario.practice_phone_number
  end

  def destroy
    @scenario = Scenario.find(params[:id])
    if @scenario.destroy
      flash[:notice] = "The scenario was deleted."
    end
    redirect_to @scenario.practice_phone_number
  end

  def update
    @scenario = Scenario.find(params[:id])
    if @scenario.update(scenario_params)
      flash[:notice] = "The scenario was updated."
    end
    redirect_to @scenario.practice_phone_number
  end

private

  def scenario_params
    params.require(:scenario).permit(:name, :practice_phone_number_id, :sequence_position)
  end

end
