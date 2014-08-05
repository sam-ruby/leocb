class Company < ActiveRecord::Base
  has_many :persons
  has_many :mile_stones
  has_many :investors
  has_many :products
  belongs_to :sector
end
