# frozen_string_literal: true

class DrinkLikesController < ApplicationController
  before_action :set_drink

  def create
    @drink_like = DrinkLike.new(user_id: current_user.id, drink_id: @drink.id)
    @drink_like.save
  end

  def destroy
    @drink_like = DrinkLike.find_by(drink_id: @drink.id, user_id: current_user.id)
    @drink_like.destroy
  end

  private

  def set_drink
    @drink = Drink.find(params[:drink_id])
  end
end
