Rails.application.routes.draw do
  devise_for :users
  resources :cards
  resources :boxes

  Box.types.each do |type|
    resources type.to_s.pluralize.underscore.to_sym, controller: :boxes
  end

  resources :imports

  root to: "cards#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
