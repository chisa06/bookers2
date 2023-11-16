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
      redirect_to books_path(@book.id)
    else
      @books = Book.page(params[:page])
      render template: 'books/index' 
    end
  end

  def show
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    @books = Book.where(id: @book.id).page(params[:page])
  end

  def edit
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
