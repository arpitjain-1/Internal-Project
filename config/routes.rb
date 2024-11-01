Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  devise_scope :user do
    # Authority login paths
    get 'login/authority', to: 'users/sessions#new_authority', as: 'new_authority_session'
    post 'login/authority', to: 'users/sessions#create_authority'

    # Normal user login paths
    get 'login/normal_user', to: 'users/sessions#new_normal_user', as: 'new_normal_user_session'
    post 'login/normal_user', to: 'users/sessions#create_normal_user'
  end

  # Authority routes (including complaints management)
  authenticate :user, ->(u) { u.authority? } do
    get 'authority/profile', to: 'authorities#profile', as: 'authority_profile'
    get 'authority/dashboard', to: 'authorities#dashboard', as: 'authority_dashboard'
    get 'authority/profile/edit', to: 'authorities#edit_profile', as: 'edit_authority_profile'
    get 'authority/pending_complaints', to: 'authorities#pending_complaints', as: 'pending_complaints'
    
    resources :complaints do
      member do
        put :resolve  # This creates resolve_complaint_path
        put :reject   # This creates reject_complaint_path
      end
    end
  end

  # Normal user routes
  authenticate :user, ->(u) { u.normal_user? } do
    # Profile related routes
    get 'normal_user/profile', to: 'normal_user#profile', as: 'normal_user_profile'
    get 'normal_user/profile/edit', to: 'normal_user#edit_profile', as: 'edit_normal_user_profile'
    patch 'normal_user/profile', to: 'normal_user#update_profile', as: 'update_normal_user_profile'
    get 'normal_user/dashboard', to: 'normal_user#dashboard', as: 'normal_user_dashboard'
    get 'normal_user/complaints', to: 'normal_user#complaints', as: 'normal_user_complaints'
    
    # Only normal users should be able to create complaints
    resources :complaints, only: [:new, :create]
  end

  root 'index#index'

  # Catch-all route
  match '*path', to: redirect('/'), via: :all
end
