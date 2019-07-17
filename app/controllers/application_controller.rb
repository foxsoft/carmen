class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :refresh_authentication

  def refresh_authentication
    sign_in(current_user)
  end
end
