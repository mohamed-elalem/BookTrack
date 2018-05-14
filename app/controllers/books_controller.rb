class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit edit update destroy]

  def index
    paginate(Book.all, params[:page]) do |books|
      @books = books
    end
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to books_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @book.update_attributes book_params
    if @book.errors.blank?
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.delete
    redirect_to root_path
  end

  private

  def set_book
    @book = Book.find params[:id]
  end

  def book_params
    params.require(:book).permit(:name, :description)
  end
end
