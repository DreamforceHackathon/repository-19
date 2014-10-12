Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :practice_phone_numbers do
    resources :incoming_calls
  end

  resources :incoming_calls do
    post "purpose_routing", to: "purpose_routing#create", as: :purpose_routing
    post "scenario_routing", to: "scenario_routing#create", as: :scenario_routing
    post "prompt_pre_recording", to: "prompt_pre_recording#create", as: :prompt_pre_recording
    post "recordings", to: "recordings#create", as: :recordings
  end

  post "recording_dummy", to: "recording_dummy#create", as: :recording_dummy
  post "post_recording/:id", to: "post_recording#create", as: :post_recording

  post "complete_incoming_call", to: "complete_incoming_call#create", as: :complete_incoming_call

  resources :user_practice_phone_numbers
  resources :scenarios
  resources :prompts

end
