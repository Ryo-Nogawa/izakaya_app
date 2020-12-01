class FoodCommentsController < ApplicationController

  def create
    comment = FoodComment.create(comment_params)
    redirect_to "/foods/#{comment.food.id}"
  end

  private
  def comment_params
    params.require(:food_comment).permit(:comment).merge(user_id: current_user.id, food_id: params[:food_id])
  end

end
