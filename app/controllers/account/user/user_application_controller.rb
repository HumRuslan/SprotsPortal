class Account::User::UserApplicationController < ApplicationController
  before_action :authenticate_user!
  layout "application-user"
end
