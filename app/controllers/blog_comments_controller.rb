class BlogCommentsController < ApplicationController

  def create
    comment = BlogComment.create(comment_params)
    redirect_to "/blogs/#{comment.blog.id}"
  end

  private
  def comment_params
    params.require(:blog_comment).permit(:comment).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end