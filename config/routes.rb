# frozen_string_literal: true

Rails.application.routes.draw do
  # The routes for future use
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

  root 'pages#login'
  

  #root 'pages#homepage'
  match '/excels/sheet/compare', to: 'pages#compare', via: :get,
        as: 'compare_excel'

  get 'excel_sheets/new', to: 'excel_sheets#new', as: 'excel_sheets_new'
  post 'excel_sheets/create', to: 'excel_sheets#create', as: 'excel_sheets_create'
  match '/excels/sheet/generate', to: 'pages#generate', via: :get,
                                  as: 'generate_excel'
  get '/download_excel', to: 'pages#download', as: 'download_excel'

  resources :excel_sheets
  get "downloads/xls/:report_id_final" => "pages#download_processed_sheet", :as => :download_processed_sheet
  get 'download_processed_sheet', to: 'pages#download_processed_sheet'
  #get 'download_processed_sheet', to: 'pages#download_processed_sheet', as: 'download_processed_sheet'
  # root "hello#index"
  get '/download_report', to: 'pages#download_report', as: 'download_report'
  #get '/homepage', to: 'pages#new', as: 'homepage'
  post '/download_report', to: 'pages#validate'
  # get 'download_report', to: 'report#download'

  get '/chatgpt', to: 'chatgpt#index'
  get '/login', to: 'pages#login'
  get '/homepage', to: 'pages#homepage'
  # root "pages#homepage"
  # match '/excels/sheet/generate', to: 'pages#generate', via: :get,
  #         as: 'generate_excel'
  #   get '/download_excel', to: 'pages#download', as: 'download_excel'

  #  root "pages#home"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # get 'download_processed_sheet', to: 'pages#download_processed_sheet', as: 'download_processed_sheet'
  # #root "hello#index"
  #   get "/download_report", to: "pages#download_report", as: "download_report"
  # get "/homepage", to: "pages#new", as: "homepage"
  #   post "/download_report", to: "pages#validate"
  # get 'download_report', to: 'report#download'

  post '/homepage', to: 'pages#validate'
  post '/homepage', to: 'pages#homepage'
  get '/new_route', to: 'controller_name#custom_action'
end
