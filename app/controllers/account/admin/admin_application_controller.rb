class Account::Admin::AdminApplicationController < ApplicationController
  before_action :authenticate_user!
  layout "application-admin"
end
