class ReservesController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  def index; end

  def new
    @reserve = Reserve.new
  end

  def create
    @reserve = Reserve.new(reserve_params)
    if @reserve.valid?
      @reserve.save
      redirect_to root_path
    else
      render new_reserve_path
    end
  end

  def edit
    @reserve = Reserve.find(params[:id])
  end

  def update
    @reserve = Reserve.find(params[:id])
    if @reserve.update(reserve_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    reserve = Reserve.find(params[:id])
    if reserve.destroy
      redirect_to user_path(current_user.id)
    end
  end

  private

  def reserve_params
    params.require(:reserve).permit(:reserve_date, :reserve_time, :number_reserve, :reserve_category_id).merge(user_id: current_user.id)
  end
end
