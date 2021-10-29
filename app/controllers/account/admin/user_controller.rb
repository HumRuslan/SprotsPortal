class Account::Admin::UserController < ApplicationController
  before_action :authenticate_user!
  layout "application-admin"

  def index
    @users = User.all
  end
end
