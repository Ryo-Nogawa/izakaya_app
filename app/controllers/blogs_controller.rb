class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.valid?
      @blog.save
      redirect_to blogs_path
    else
      render :new
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    if blog.valid?
      blog.destroy
      redirect_to blogs_path
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = BlogComment.new
    @comments = @blog.blog_comments.includes(:user)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :text, images: []).merge(user_id: current_user.id)
  end
end
