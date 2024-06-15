Rails.application.routes.draw do
  devise_for :users
  resources :users do
    collection do
      get :invite, to: 'users#invite'
      post :invite, to: 'users#send_invitation'
      get :pending_invitations
    end

    member do
      # TODO
      # patch :lock_account
      patch :resend_invitation
    end
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "main#index"
end
