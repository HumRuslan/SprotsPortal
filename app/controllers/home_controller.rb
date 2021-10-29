class HomeController < ApplicationController
  before_action :authenticate_user!
  layout "application-user"

  def index
    @title = "User page"
  end
end
