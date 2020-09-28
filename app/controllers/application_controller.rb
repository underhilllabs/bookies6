class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  before_action :set_start_time
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_start_time
    @start_time = Time.now.usec
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to user_session_path
  end

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

	def after_sign_in_path_for(resource_or_scope)
		stored_location_for(resource_or_scope) || super
	end

end
