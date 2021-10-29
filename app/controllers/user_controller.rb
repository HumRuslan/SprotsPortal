class UserController < ApplicationController
  before_action :authenticate_user!
  layout "application-user"

  def index
    @users = User.all
  end
end
