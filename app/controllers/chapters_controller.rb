class ChaptersController < ApplicationController
  before_action :set_chapter, only: %i[show edit update destroy toggle_read]
  before_action :set_book

  def index
    @chapters = @book.chapters
  end

  def new
    @chapter = Chapter.new
    session[:redirect_to] = request.referrer || root_url
  end

  def create
    @chapter = @book.chapters.build chapter_params
    if @chapter.save
      redirect_to session[:redirect_to] || @book
    else
      render 'new'
    end
  end

  def edit;end

  def update
    @chapter.update_attributes chapter_params
    if @chapter.errors.blank?
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @chapter.delete
    redirect_to @book
  end

  def toggle_read
    @chapter.toggle_read
    redirect_back fallback_location: root_url
  end

  private

  def set_book
    @book = Book.find params[:book_id]
  end

  def set_chapter
    @chapter = Book.find(params[:book_id]).chapters.find(params[:id])
  end

  def chapter_params
    params.require(:chapter).permit(:name, :number_of_chapter, :number_of_pages)
  end
end
