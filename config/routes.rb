Rails.application.routes.draw do

  namespace :v1 do
    resources :recruiters

    namespace :recruiter do
      resources :jobs
    end
  end
end
