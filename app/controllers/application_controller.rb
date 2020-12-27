class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :edit_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :name, :name_kana, :age, :phone_number])
  end

  def edit_permitted_parameters
    devise_parameter_sanitizer.permit(:edit, keys: [:nickname, :name, :name_kana, :age, :phone_number])
  end
end
