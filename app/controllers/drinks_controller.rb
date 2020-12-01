class DrinksController < ApplicationController
  def index
    @drinks = Drink.all
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = Drink.new(drink_params)
    if @drink.valid?
      @drink.save
      redirect_to drinks_path
    else
      render :new
    end
  end

  private
  def drink_params
    params.require(:drink).permit(:title, :detail, :price, :drink_category_id, :image).merge(user_id: current_user.id)
  end
end
