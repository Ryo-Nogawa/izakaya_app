class ReservesController < ApplicationController
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
      render action: :new
    end
  end

  private

  def reserve_params
    params.require(:reserve).permit(:reserve_date, :reserve_time, :number_reserve, :reserve_category_id).merge(user_id: current_user.id)
  end
end
