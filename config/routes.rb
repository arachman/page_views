Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'}  do
    namespace :v1 do
      resources :page_views
    end
  end
  root :to => "page_views#index"
end
