class HomeController < ApplicationController
  def index
  end

  def list
    sector_id = params[:sector_id].to_i
    puts 'sector_id ', sector_id
    if sector_id == 0
      @companies = Company.all.order(start_date: :desc)[0, 8]
    else
      @companies = Company.where('sector_id = ?', sector_id).order(
        start_date: :desc)[0, 8]
    end
  end

  def company
  end
end
