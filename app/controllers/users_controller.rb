class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def account
    render :json => current_user.to_json
  end
  
  def index
  end
end