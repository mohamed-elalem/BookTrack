class BooksController < ApplicationController
  include BooksHelper

  before_action :set_book, only: %i[show edit edit update destroy reading_path]

  def index
    paginate(Book.all, params[:page]) do |books|
      @books = books
      respond_to do |format|
        format.html
        format.json { json(@books) }
      end
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

  def reading_path
    graph = load_inverted_dependency_graph_for(@book)
    graph.set_traversal(DfsTraversal.new)
    graph.set_prioritizer GraphFactory.make_prioritizer(:dag_dfs)
    graph.prioritizer.starting_point = @book.id
    needed_vertices = Set.new graph.traverse(@book.id)
    graph.graph = clean_graph(graph.graph, needed_vertices)
    @priorities = get_priorities_from(graph)
    @priorities = get_book_models_from @priorities
  end

  private

  def set_book
    @book = Book.find params[:id]
  end

  def book_params
    params.require(:book).permit(:name, :description)
  end
end
