class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_is_admin?, :user_is_logged_in?

  def user_is_admin?
    @user_is_admin ||= current_user ? current_user.admin : false
  end

  def user_is_logged_in?
    puts "checking if user is logged in"
    @user_is_logged_in ||= current_user ? true : false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :city_id
  end


end
