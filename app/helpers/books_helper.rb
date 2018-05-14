module BooksHelper
  def book_completed_percentage(book)
    book.chapters.completed.pages.to_f / book.chapters.pages.to_f
  end

  def book_completed_percentage_for_html(book)
    (book_completed_percentage(book) * 100).to_i
  end

  def suitable_color(book)
    color_levels = %w[danger warning info primary success]
    color_levels[(book_completed_percentage(book) * (color_levels.length - 1)).to_i]
  end
end
