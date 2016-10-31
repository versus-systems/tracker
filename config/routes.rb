Rails.application.routes.draw do
  crud = %i(index show create update destroy)

  namespace :v1 do
    resources :projects,  only: crud do
      resources :tasks, only: [:index, :new, :create]
    end
    resources :tasks, only: [:show, :edit, :update, :destroy]
  end
end
