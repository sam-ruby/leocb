class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def get_page_list(page, total_records, limit)
    page_list = []
    total_pages = (total_records/limit.to_f).ceil
    if page - (limit/2) <= 0
      (1..page).to_a.each {|x| page_list.push x}
    else
      ((page-(limit/2))..page).to_a.each {|x| page_list.push x}
    end

    if ((limit - page_list.size) + page) > total_pages
      (page+1..total_pages).to_a.each {|x| page_list.push x}
    else
      ((page+1)..(page + (limit-page_list.size))).to_a.each {|x| page_list.push x }
    end
    [page_list, total_pages]
  end
end
