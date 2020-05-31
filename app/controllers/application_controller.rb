class ApplicationController < ActionController::Base


  before_action :set_start_time

  def set_start_time
    @start_time = Time.now.usec
  end
end
