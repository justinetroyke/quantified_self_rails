Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :foods
      get '/meals', to: 'meals#index'
      get '/meals/:meal_id/foods', to: 'meals#show'
      post '/meals/:meal_id/foods/:id', to: 'food_meals#create'
      delete '/meals/:meal_id/foods/:id', to: 'food_meals#destroy'
    end
  end
end
