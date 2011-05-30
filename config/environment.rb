# Load the rails application
require "rack/oauth2/rails"
require "rack/oauth2/server/admin"
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OssServer::Application.initialize!
