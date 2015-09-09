Rails.application.routes.draw do

  root to: "page#home"
  devise_for :users
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
 
end
