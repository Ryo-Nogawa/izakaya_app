class DrinksController < ApplicationController
  before_action :search_product, only: [:index, :search]
  before_action :only_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @drinks = Drink.all.order(drink_category_id: :ASC)
  end

  def search
    @results = @p.result.all.order(drink_category_id: :ASC)
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = Drink.new(drink_params)
    if @drink.valid?
      @drink.save
    else
      render :new
    end
  end

  def show
    @drink = Drink.find(params[:id])
    @comment = DrinkComment.new
    @comments = @drink.drink_comments.includes(:user).order(created_at: :ASC)
  end

  def destroy
    drink = Drink.find(params[:id])
    drink.destroy
  end

  def edit
    @drink = Drink.find(params[:id])
  end

  def update
    @drink = Drink.find(params[:id])
    if @drink.update(drink_params)
    else
      render :edit
    end
  end

  private

  def drink_params
    params.require(:drink).permit(:title, :detail, :price, :drink_category_id, :image, :free_drink).merge(user_id: current_user.id)
  end

  def search_product
    @p = Drink.ransack(params[:q])
  end

  def only_admin
    redirect_to root_path unless current_user.admin?
  end
end
