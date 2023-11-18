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
    if @book.user_id == current_user.id
      @books = Book.where(id: @book.id).page(params[:page])
    end
  end

  def edit
      @book = Book.find_by(params[:id])
    if @book.nil?
      redirect_to edit_book_path(:id)
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
       redirect_to book_path(book.id)
    else
      render template: 'books/edit'
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
