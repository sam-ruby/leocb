class HomeController < ApplicationController
  before_action :set_locale

  def index
  end

  def list
    sector_id = params[:sector_id].to_i
    if sector_id == 0
      @companies = Company.all.order(start_date: :desc)[0, 8]
    else
      @companies = Company.where('sector_id = ?', sector_id).order(
        start_date: :desc)[0, 8]
    end
  end

  def company
    comp_id = params[:comp_id].to_i
    if comp_id == 0
      @company = Company.first
    else
      @company = Company.find(comp_id)
    end
  end

  private
  def set_locale
    if params[:locale] and params[:locale] == 'zh'
      ActiveRecord::Base.connection.schema_search_path =  'chinese'
      I18n.locale = :zh
      session[:locale] = :zh
    elsif params[:locale] and params[:locale] == 'en'
      ActiveRecord::Base.connection.schema_search_path =  'public'
      I18n.locale = :en
      session[:locale] = :en
    end
  end
end
