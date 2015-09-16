Rails.application.routes.draw do
 
  root to: "page#home"
  devise_for :users
  ################################
  ###### General User Routes #####
  ################################
  get 'subscribe', to: "page#subscription"
  
  resources :courses, only: [:index, :show] do
    resources :chapters, only: [:show]
  end
  resources :chapters, only: [:show] do
    resources :videos, only: [:show]
  end
  ################################
  ########## Admin Routes ########
  ################################
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :answers
  end

  namespace :admin do
    resources :questions
  end

  namespace :admin do
    resources :quizzes
  end

  namespace :admin do
    resources :videos
  end

  namespace :admin do
   resources :courses do
     resources :chapters
   end
  end
  namespace :admin do
    resources :chapters do
      resources :videos
      resources :quizzes
    end
  end
  namespace :admin do
    resources :quizzes do
      resources :questions
    end
  end
  namespace :admin do
    resources :questions do
      resources :answers
    end
  end
 
end
