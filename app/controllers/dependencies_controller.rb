class DependenciesController < ApplicationController
  before_action :set_book
  
  def index

  end

  def show
    
  end

  def new
    
  end

  def create
    @book.book_children.build get_array_of_hashes_for_nested_resources(dependency_params)
    if @book.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def dependency_params
    params.permit(child_ids: [])
  end
end
