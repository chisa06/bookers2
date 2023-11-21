class BooksController < ApplicationController
  
  def index
    @book = Book.new
    @book.user_id = current_user.id
    @books = Book.page(params[:page])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      @books = Book.all.page(params[:page])
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      @books = Book.where(id: @book.id).page(params[:page])
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
