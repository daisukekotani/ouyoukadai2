class BooksController < ApplicationController
  before_action :login_check, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  def top
  end

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @post_comment = PostComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
     @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
        redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

 private
  def book_params
    params.require(:book).permit(:title, :body)
  end


  def login_check
    unless user_signed_in?
      redirect_to user_session_path
    end
  end
end