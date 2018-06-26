class ApplicationController < ActionController::Base
  include ApplicationHelper
  include JsonResponse

  protect_from_forgery with: :null_session

  def paginate(resource, page)
    yield resource.page(page)
  end

end
