class BlogsController < ApplicationController
  before_action :only_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @blogs = Blog.all.order(created_at: :DESC)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.valid?
      @blog.save
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
    @comments = @blog.blog_comments.includes(:user).order(created_at: :ASC)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
    else
      render :edit
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def only_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
