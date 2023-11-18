class UsersController < ApplicationController
  def index
    @user =User.all
    @user = current_user.name
    @book = Book.new    
  end

  def show
    @user = current_user.name
    @book = Book.new
    @books = Book.page(params[:page])
  end
  
  def create
    @user = User.find(params[:id])
    
    if @user.save
      redirect_to user_path(@user.id), success: 'Welcome! You have signed up successfully.'
    else
      render 'new_user_registration'
    end
    
    if @user = current_user.name
      flash[:notice] = "ログインに成功しました！"
      redirect_to user_path(@user.id)
    else
      render 'sessions/new'
    end
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
    redirect_to users_path(@user.id)
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
