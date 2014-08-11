class HomeController < ApplicationController
  before_action :set_locale

  def index
  end

  def list
    sector_id = params[:sector_id].to_i
    page = params[:page].to_i == 0 ? 1 : params[:page].to_i
    limit = 10
    if sector_id == 0
      @companies = Company.all.order(start_date: :desc).limit(limit).offset((page-1)*limit)
      @c_size = Company.count
    else
      @companies = Company.where('sector_id = ?', sector_id).order(
        start_date: :desc).limit(limit).offset((page-1)*limit)
      @c_size = Company.where('sector_id = ?', sector_id).count
    end
    @page = page
    @limit = limit
    @sector_id = sector_id
    @total_pages = (@c_size/@limit.to_f).round
    page_list = []

    if page - 5 <= 0
      (1..page).to_a.each {|x| page_list.push x}
    else
      ((page-5)..page).to_a.each {|x| page_list.push x}
    end

    if ((10 - page_list.size) + page) > @total_pages
      (page+1..@total_pages).to_a.each {|x| page_list.push x}
    else
      ((page+1)..(page + (10-page_list.size))).to_a.each {|x| page_list.push x }
    end
    @page_list = page_list
  end

  def company
    comp_id = params[:c_id].to_i
    if comp_id == 0
      @company = Company.first
    else
      @company = Company.find(comp_id)
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

  private
  def set_locale
    if params[:locale] and params[:locale] == 'zh'
      ActiveRecord::Base.connection.schema_search_path =  'chinese'
      I18n.locale = :zh
    elsif params[:locale] and params[:locale] == 'en'
      ActiveRecord::Base.connection.schema_search_path =  'public'
      I18n.locale = :en
    end
  end
end
