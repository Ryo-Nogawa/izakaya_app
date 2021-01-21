# frozen_string_literal: true

class FoodLikesController < ApplicationController
  before_action :set_food

  def create
    @food_like = FoodLike.new(user_id: current_user.id, food_id: @food.id)
    @food_like.save
  end

  def destroy
    @food_like = FoodLike.find_by(food_id: @food.id, user_id: current_user.id)
    @food_like.destroy
  end

  private

  def set_food
    @food = Food.find(params[:food_id])
  end
end
