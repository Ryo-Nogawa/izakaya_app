class FoodsController < ApplicationController

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.valid?
      @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  private
  def food_params
    params.require(:food).permit(:title, :detail, :price, :image, :food_category_id).merge(user_id: current_user.id)
  end
end
