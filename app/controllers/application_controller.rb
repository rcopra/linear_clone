# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pagy::Backend
  include ResponseHelper
  allow_browser versions: :modern
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
