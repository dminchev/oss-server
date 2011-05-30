OssServer::Application.routes.draw do
  devise_for :users
  resources :users

  root :to => "home#index"
  match "account" => "users#account"
  match "oauth/authorize" => "oauth#authorize"
  match "oauth/grant" => "oauth#grant"
  match "oauth/deny" => "oauth#deny"
  mount Rack::OAuth2::Server::Admin => "/oauth/admin"
end
