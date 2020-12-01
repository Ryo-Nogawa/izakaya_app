class DrinkCommentsController < ApplicationController

  def create
    comment = DrinkComment.create(comment_params)
    redirect_to "/drinks/#{comment.drink.id}"
  end

  private
  def comment_params
    params.require(:drink_comment).permit(:comment).merge(user_id: current_user.id, drink_id: params[:drink_id])
  end
  
end
