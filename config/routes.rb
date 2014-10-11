Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :practice_phone_numbers do
    resources :incoming_calls
  end

  resources :incoming_calls do
    post "purpose_routing", to: "purpose_routing#create", as: :purpose_routing
  end

  resources :user_practice_phone_numbers
  resources :scenarios
  resources :prompts

end
