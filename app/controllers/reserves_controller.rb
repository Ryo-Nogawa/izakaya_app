class ReservesController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  def index; end

  def new
    @reserve = Book.new
  end

  def confirm
    @reserve = Book.new(reserve_params)
    if @reserve.valid?
      render :confirm
    else  
      render :new
    end
  end

  def back
    @reserve = Book.new(reserve_params)
    render :new 
  end

  def create
    @reserve = Book.new(reserve_params)
    if @reserve.save
      redirect_to complete_reserves_path
    else
      render confirm_reserves_path
    end
  end

  def edit
    @reserve = Book.find(params[:id])
  end

  def update
    @reserve = Book.find(params[:id])
    if @reserve.update(reserve_params)
      redirect_to edit_complete_reserves_path
    else
      render :edit
    end
  end

  def destroy
    reserve = Book.find(params[:id])
    if reserve.destroy
      redirect_to user_path(current_user.id)
    end
  end

  private

  def reserve_params
    params.require(:book).permit(:reserve_date, :reserve_time, :number_reserve, :reserve_category_id).merge(user_id: current_user.id)
  end
end
