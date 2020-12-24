class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def show
    @user = User.find(current_user.id)
    @books = @user.books.order(reserve_date: :ASC)
    require 'date'
    @today = Date.today
  end
end
