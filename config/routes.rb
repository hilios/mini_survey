MiniSurvey::Application.routes.draw do
  resources :surveys do
    resources :questions do
      resources :choices
      resources :answers
    end
  end

  resources :users, :except => [:index]

  resources :sessions, 
    :only => [:new, :create]
  match 'sessions/destroy' => 'sessions#destroy', :as => :destroy_session
  # You can have the root of your site routed with "root"
  root :to => 'sessions#new'
end
