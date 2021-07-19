Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do

    #basic CRUD endpoints
    resources :teams
    resources :people
    resources :entries

    get "/score", to: "scoreboard#index"
    get "/team_score", to: "scoreboard#team"
  end
end
