class ApplicationController < ActionController::Base
  def paginate(resource, page)
    yield resource.page(page)
  end
end
