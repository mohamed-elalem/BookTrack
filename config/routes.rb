Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'books#index'

  resources :books do
    resources :chapters do
      put 'toggle_read', to: 'chapters#toggle_read', on: :member
    end
  end
end
