class BooksService
  def add_book(book_params)
    book = Book.create book_params
  end

  def update_book(book_params)
    @book.update_attributes book_params
    @book
  end

  def set_book(id)
    @book = Book.find(id)
  end
end