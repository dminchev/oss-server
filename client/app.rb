require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'httparty'

CLIENT_ID = '4de2531f1d41c821f7000001'
CLIENT_SECRET = 'f14e425b1fe4b737ea172b8d57630cac01516df60b2e9887897f5f7230f16706'
RESOURCE_HOST = 'http://localhost:3000'

enable :sessions

helpers do
  def redirect_uri
    "http://localhost:9292/callback"
  end

  def access_token
    session[:access_token]
  end

  def get_with_access_token(path)
    HTTParty.get(RESOURCE_HOST + path, :query => {:oauth_token => access_token})
  end

  def authorize_url
    RESOURCE_HOST + "/oauth/authorize?response_type=token&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&redirect_uri=#{redirect_uri}"
  end
  
  def access_token_url
    RESOURCE_HOST + "/oauth/access_token"
  end
end

get '/' do
  haml :home
end

get '/callback' do
  response = HTTParty.post(access_token_url, :body => {
    :client_id => CLIENT_ID, 
    :client_secret => CLIENT_SECRET, 
    :redirect_uri => redirect_uri, 
    :code => params["code"],
    :grant_type => 'authorization_code'}
  )

  session[:access_token] = request["access_token"]
  redirect '/account'
end

get '/account' do
  if access_token
    @resource_response = get_with_access_token("/account.json")
    haml :response
  else
    redirect authorize_url
  end
end