class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @user = User.find(current_user.id)
    @reserves = @user.reserves.order(reserve_date: 'DESC')
    require 'date'
    @today = Date.today
  end
end
