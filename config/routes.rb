Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :practice_phone_numbers do
    resources :incoming_calls
  end

  resources :user_practice_phone_numbers
  resources :scenarios
  resources :prompts

end
