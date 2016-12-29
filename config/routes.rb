Rails.application.routes.draw do
  crud = %i(index show create update destroy)

  namespace :v1 do
    resources :projects, only: crud do
      post :create_task

      member do
        get :list_tasks
      end

    resources :tasks, only: [:update] do
      put :update_task_state
    end

    end
  end
end
