Radlibs5::Application.routes.draw do

  resources :radlibs do
  	member do
  		post :vote
  	end
  end

  resources :templates do
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
end
