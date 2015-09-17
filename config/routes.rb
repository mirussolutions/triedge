Rails.application.routes.draw do
 
  root to: "page#home"
  devise_for :users
  ################################
  ###### General User Routes #####
  ################################
  get 'subscribe', to: "page#subscription"
  get 'quizzes/:id/question/:question_id', controller: 'quizzes', action: 'show', as: 'show_question'
  get 'quizzes/:id/quiz_complete', controller: 'quizzes', action: 'complete', as: 'quiz_complete'
  post 'update_answer', to: 'answers#update'  
  
  resources :courses, only: [:index, :show] do
    resources :chapters, only: [:show]
  end
  resources :chapters, only: [:show] do
    resources :videos, only: [:show]
    resources :quizzes, only: [:show, :complete]
  end
  resources :quizzes, only: [:show] do
    resources :questions, only:[:show, :update]
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
