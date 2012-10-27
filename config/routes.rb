Radlibs5::Application.routes.draw do

  resources :stories, only: [:show, :new, :create, :update, :destroy, :index] do
  	member do
  		post :vote
  	end
  end

  resources :radlibs, only: [:show, :new, :create, :destroy, :index] do
  	member do
  		post :vote
  	end
  end

  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/aboutus' => "home#aboutus"
end
