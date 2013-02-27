DressShare::Application.routes.draw do
  devise_for :users
  resources :static_pages
  resources :rentals, :only => [:edit, :show, :destroy]

  resources :dresses do
    resources :rentals, :only => [:new, :index]
    member do
      get "photo"
    end
  end

  root :to => "dresses#index"

  devise_scope :user do
    get "/signin", :to => "devise/sessions#new"
    delete "/signout", :to => "devise/sessions#destroy"
    get "/signup", :to => "devise/registrations#new"
    match '/confirm/:confirmation_token', :to => "devise/confirmations#show", :as => "user_confirm", :only_path => false
  end

  resources :users, :only=> :show
  get "/contact_us", :to => "static_pages#contact"
  get "/about_us", :to => "static_pages#about"
  get "/our_story", :to => "static_pages#story"
  get "/legal_stuff", :to => "static_pages#legal"

end