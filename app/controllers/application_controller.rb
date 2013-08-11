class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :profile_name, :password, :password_confirmation, :email) }
	end

	protect_from_forgery with: :exception
end
