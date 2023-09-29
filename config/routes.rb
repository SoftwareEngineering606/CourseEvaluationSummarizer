Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root "pages#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  


get 'download_excel_sheet', to: 'pages#download_excel_sheet', as: 'download_excel_sheet'
#root "hello#index"
get "/download_report", to: "pages#download_report", as: "download_report"
get "/homepage", to: "pages#new", as: "homepage"
post "/homepage", to: "pages#validate"
post "/homepage", to: "pages#homepage"

end
