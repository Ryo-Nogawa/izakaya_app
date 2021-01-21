# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index; end

  def new
    @book = Book.new
  end

  def confirm
    @book = Book.new(book_params)
    if @book.valid?
      render :confirm
    else
      render :new
    end
  end

  def back
    @book = Book.new(book_params)
    render :new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to complete_books_path
    else
      render confirm_books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to edit_complete_books_path
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:reserve_date, :reserve_time, :number_reserve, :reserve_category_id).merge(user_id: current_user.id)
  end
end
