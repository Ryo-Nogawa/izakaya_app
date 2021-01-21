# frozen_string_literal: true

class BlogLikesController < ApplicationController
  before_action :set_blog

  def create
    @blog_like = BlogLike.new(user_id: current_user.id, blog_id: @blog.id)
    @blog_like.save
  end

  def destroy
    @blog_like = BlogLike.find_by(blog_id: @blog.id, user_id: current_user.id)
    @blog_like.destroy
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
