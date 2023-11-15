class UsersController < ApplicationController
  def index
    @user =User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.page(params[:page])
  end
  
  def create
    @user = User.find(params[:id])
    @book = Book.new(book_params)
    @book.user = @user
    
    if @book.save
     redirect_to book_path(@book.id)
    else
      @books = Book.page(params[:page])
      render template: 'books/index' 
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.valid?
    redirect_to users_path(@user.id)
  end
end
