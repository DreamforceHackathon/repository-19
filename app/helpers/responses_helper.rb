module ResponsesHelper

  def response_scenario_name(response)
    return "Unknown" unless response.prompt && response.prompt.scenario

    response.prompt.scenario.name.to_s
  end

end
