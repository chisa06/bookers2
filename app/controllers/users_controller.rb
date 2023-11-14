class UsersController < ApplicationController
  def index
    @user =User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
  end
  
  def create
    @user = User.find(params[:user_id])
    @book = @user.books.build(book_params)
    @book.save
    redirect_to book_path(@book.id)
    puts @book.errors.full_messages
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path(@user.id)
    puts @book.errors.full_messages
  end
end
