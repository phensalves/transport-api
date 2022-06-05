Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :operations
      resources :contacts
      resources :facilities
      resources :customers
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
  end
end
