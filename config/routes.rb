Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults:{ format: :json }do
    namespace :v1 do
      post   '/login'       => 'sessions#session_login'
      post   '/logout'       => 'sessions#session_logout'
      resources :employees
      resources :projects do
        member do
          post 'add_employee'  => 'projects#add_employee'
          post 'remove_employee'  => 'projects#remove_employee'
        end
      end
      resources :clients do
        member do
          post 'add_project'  => 'clients#add_project'
          post 'remove_project'  => 'clients#remove_project'
        end
      end
    end
  end
end
