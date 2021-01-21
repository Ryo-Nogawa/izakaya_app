# frozen_string_literal: true

class FoodCommentsController < ApplicationController
  def create
    # Ajax
    # @food = Food.find(params[:food_id])
    # @food_comment = @food.food_comments.build(comment_params)
    # if @food_comment.save
    #   render :index
    # end
    # 同期通信
    FoodComment.create(comment_params)
    redirect_to food_path(params[:food_id])
  end

  private

  def comment_params
    params.require(:food_comment).permit(:comment).merge(user_id: current_user.id, food_id: params[:food_id])
  end
end
