Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :practice_phone_numbers
  resources :user_practice_phone_numbers

end
