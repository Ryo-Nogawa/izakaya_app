class FoodsController < ApplicationController
  before_action :search_product, only: [:index, :search]
  before_action :only_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @foods = Food.all

  end

  def search
    # @results = @p.result.includes(:food_category)
    @results = @p.result.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.valid?
      @food.save
    else
      render :new
    end
  end

  def show
    @food = Food.find(params[:id])
    @comment = FoodComment.new
    @comments = @food.food_comments.includes(:user).order(created_at: :ASC)
  end

  def destroy
    food = Food.find(params[:id])
    if food.destroy
      redirect_to foods_path
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      redirect_to food_path(params[:id])
    else
      render :edit
    end
  end


  private
  def food_params
    params.require(:food).permit(:title, :detail, :price, :image, :food_category_id).merge(user_id: current_user.id)
  end

  def search_product
    @p = Food.ransack(params[:q])
  end

  def only_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

end
