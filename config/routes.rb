Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  namespace :v1, defaults: { format: :json } do
    resources :recruiters
    resources :talents, concerns: :paginatable

    namespace :recruiter do
      resources :jobs, concerns: :paginatable
    end

    namespace :public do
      resources :submissions, concerns: :paginatable, except: :update
    end
  end
end
