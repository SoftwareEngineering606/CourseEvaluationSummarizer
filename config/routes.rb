Rails.application.routes.draw do
  #The routes for future use
  # resources :excel_sheets
  # get 'excel_sheets/index'
  # get 'excel_sheets/show'
  # get 'excel_sheets/new'
  # get 'excel_sheets/edit'
  # get 'excel_sheets/create'
  # get 'excel_sheets/update'
  # get 'excel_sheets/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
root "pages#homepage"
match '/excels/sheet/generate', to: 'pages#generate', via: :get,
        as: 'generate_excel'
  get '/download_excel', to: 'pages#download', as: 'download_excel'
get 'download_excel_sheet', to: 'pages#download_excel_sheet', as: 'download_excel_sheet'
#root "hello#index"
  get "/download_report", to: "pages#download_report", as: "download_report"
get "/homepage", to: "pages#new", as: "homepage"
  post "/download_report", to: "pages#validate"
  # get 'download_report', to: 'report#download'


end
