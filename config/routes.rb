YScholar::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  # Root (index) path
  root :to => "logger#index"
  
  # Misc Routes
  match "login" => "session#new", :as => "login"
  match "logout" => "session#destroy", :as => "logout"
  match "signin" => "mentoring#signin", :as => "signin"
  match "signout" => "mentoring#signout", :as => "signout"
  #match "new_user" => "user#new", :as => "new_user"
  match "dashboard" => "dashboard#index", :as => "dashboard"

  # Resourceful routes
  resources :users
  resources :requirements
  resources :students, :controller => "users", :type => "Student"
  resources :tutors, :controller => "users", :type => "Tutor"
  resources :administrators, :controller => "users", :type => "Administrator"
  resource :session, :only => [:new, :create, :destroy], :controller => "session"
end
