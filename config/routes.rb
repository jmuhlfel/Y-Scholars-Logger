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
  match "send_alert" => "students#send_alert"
  match "clear_custom_hours" => "students#clear_custom_hours"#, :type => "Student", :action => "clear_custom_hours"

  # Resourceful routes
  resources :users
  resources :requirements
  resources :students, :type => "Student"
  resources :tutors, :type => "Tutor"
  resources :administrators, :controller => "users", :type => "Administrator"
  resource :session, :only => [:new, :create, :destroy], :controller => "session"
end
