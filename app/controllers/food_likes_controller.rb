class FoodLikesController < ApplicationController

  before_action :food_params

  def create
    FoodLike.create(user_id: current_user.id, food_id: params[:food_id])
  end

  def destroy
    FoodLike.find_by(user_id: current_user.id, food_id: params[:food_id]).destroy
  end

  private
  def food_params
    @food = Food.find(params[:food_id])
  end
end
