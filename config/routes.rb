MiniSurvey::Application.routes.draw do
  resources :surveys do
    resources :questions do
      resources :options
    end
    resources :answers
  end

  resources :users

  resources :sessions, 
    :only => [:new, :create, :destroy]
  # You can have the root of your site routed with "root"
  root :to => 'sessions#new'
end
