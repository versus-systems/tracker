Rails.application.routes.draw do
  crud = %i(index show create update destroy)

  namespace :v1 do
    resources :projects, only: crud
    resources :tasks, only: [:create, :show]
    get '/tasks/:id', to: 'tasks#index'
  end
end
