Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  namespace :v1 do
    resources :recruiters

    namespace :recruiter do
      resources :jobs, concerns: :paginatable
    end
  end
end
