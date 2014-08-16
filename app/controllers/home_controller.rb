class HomeController < ApplicationController
  before_action :set_locale

  def index
    page = params[:page].to_i == 0 ? 1 : params[:page].to_i
    limit = 12
    @sectors = Company.select('sector_id, count(*) company_count').group('sector_id').order('company_count').reverse_order.limit(limit).offset((page-1)*limit)
    sector_count = Sector.count
    
    @page = page
    @limit = limit
    @page_list, @total_pages = get_page_list(@page, sector_count, @limit)
  end

  def list
    sector_id = params[:sector_id].to_i
    page = params[:page].to_i == 0 ? 1 : params[:page].to_i
    limit = 10
    if sector_id == 0
      @companies = Company.all.order(start_date: :desc).limit(limit).offset((page-1)*limit)
      c_size = Company.count
    else
      @companies = Company.where('sector_id = ?', sector_id).order(
        start_date: :desc).limit(limit).offset((page-1)*limit)
      c_size = Company.where('sector_id = ?', sector_id).count
    end
    @sector_id = sector_id
    
    @page = page
    @limit = limit
    @page_list, @total_pages = get_page_list(@page, c_size, @limit)
  end

  def company
    comp_id = params[:c_id].to_i
    if comp_id == 0
      @company = Company.first
    else
      @company = Company.where(company_id: comp_id).first
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
