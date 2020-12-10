class DrinkCommentsController < ApplicationController

  def create
    @drink = Drink.find(params[:drink_id])
    @drink_comment = @drink.drink_comments.build(comment_params)
    if @drink_comment.save
      render :index
    end
  end

  private
  def comment_params
    params.require(:drink_comment).permit(:comment).merge(user_id: current_user.id, drink_id: params[:drink_id])
  end
  
end
