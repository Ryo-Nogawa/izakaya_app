class BlogCommentsController < ApplicationController
  def create
    # Ajax
    # @blog = Blog.find(params[:blog_id])
    # # 投稿に紐づいたコメントを作成
    # @blog_comment = @blog.blog_comments.build(comment_params)
    # if @blog_comment.save
    #   render :index
    # end
    # 同期通信
    BlogComment.create(comment_params)
    redirect_to blog_path(params[:blog_id])
  end

  private

  def comment_params
    params.require(:blog_comment).permit(:comment).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end
