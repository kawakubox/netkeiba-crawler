Rails.application.routes.draw do
  resources :events, only: %i[index] do
    resources :races, only: :index
  end

  resources :races, only: :show
end
