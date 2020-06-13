class ApplicationController < ActionController::Base
  before_action :set_start_time
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_start_time
    @start_time = Time.now.usec
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
