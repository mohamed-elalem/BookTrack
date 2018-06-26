Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'books#index'

  resources :books do
    get 'reading_path', on: :member
    resources :chapters do
      put 'toggle_read', to: 'chapters#toggle_read', on: :member
    end
    resources :dependencies
  end

  resources :suggestions
end
