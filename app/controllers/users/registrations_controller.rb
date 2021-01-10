# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    super
  end

  def confirm
    @user = User.new(sign_up_params)
    if @user.valid?
      render :confirm
    else
      render :new
    end
  end

  def complete
    @user = User.new(sign_up_params)
    # paramsの中にname="back"があったらnewアクションにrender
    if params[:back]
      render :new
    elsif @user.save
      render :complete
    end
  end

  # GET /resource/edit
  def edit
    @user = User.find(current_user.id)
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
    else
      render :edit
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def user_params
    params.require(:user).permit(:nickname, :name, :name_kana, :age, :phone_number, :email, :password)
  end
end
