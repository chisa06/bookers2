class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update]
  def index
    @user =User.all
    @user = current_user
    @book = Book.new    
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
  
  def correct_user                           #現在ログインしているユーザーと他のユーザーとの 違い を判断する!!
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
