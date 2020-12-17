class Admin::BooksController < ApplicationController
  before_action :only_admin

  def index
    @books = Book.includes(:user).order(reserve_date: :ASC)
  end


  private
  def only_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end