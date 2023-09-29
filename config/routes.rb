Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
root "pages#homepage"
get "/download_report", to: "pages#download_report", as: "download_report"
get "/homepage", to: "pages#new", as: "homepage"
post "/homepage", to: "pages#validate"
end
