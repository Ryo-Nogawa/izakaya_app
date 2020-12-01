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

  def show
    @drink = Drink.find(params[:id])
  end

  def destroy
    drink = Drink.find(params[:id])
    if drink.destroy
      redirect_to drinks_path
    end
  end

  def edit
    @drink = Drink.find(params[:id])
  end

  def update
    @drink = Drink.find(params[:id])
    if @drink.valid?
      @drink.update(drink_params)
      redirect_to drink_path(params[:id])
    else
      redirect_to edit_drink_path(params[:id])
    end
  end

  private
  def drink_params
    params.require(:drink).permit(:title, :detail, :price, :drink_category_id, :image).merge(user_id: current_user.id)
  end
end