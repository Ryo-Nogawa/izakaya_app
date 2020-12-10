class BlogCommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    # 投稿に紐づいたコメントを作成
    @blog_comment = @blog.blog_comments.build(comment_params)
    if @blog_comment.save
      render :index
    end
  end

  private
  def comment_params
    params.require(:blog_comment).permit(:comment).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end