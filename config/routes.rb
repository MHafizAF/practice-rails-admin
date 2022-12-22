Rails.application.routes.draw do
  devise_for :admin, :skip => [:registrations] do 
    get "/admin" => "devise/sessions#new", :as => :new_user_session 
    post "/admin" => "devise/sessions#create", :as => :user_session 
  end
  
  devise_for :users,
  controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/", to: redirect("/admin")

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end