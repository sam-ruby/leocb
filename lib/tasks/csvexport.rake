class LeoMigration
  attr_accessor :company, :sector
  def initialize(file, lang='en')
    line_num = 0
    while (line = file.gets) do
      line_num += 1
      next if line_num == 1 
      fields = line.split(/\t/).map {|x|x.strip}
      next if fields[0].empty?
      create_sector(fields[7,8])
      create_company(fields)

      start_index = 10
      10.times do |x|
        create_person(
          fields[start_index..start_index+3])
        start_index += 4
      end

      5.times do |x|
        create_investor(
          fields[start_index..start_index+2])
        start_index += 3
      end
      
      5.times do |x|
        create_product(
          fields[start_index..start_index+1])
        start_index += 2
      end

      # skip competitor
      # 3
      if lang == 'en'
        start_index += 1
      else
        start_index += 3
      end

      10.times do |x|
        create_milestone(
          fields[start_index..start_index+2])
        start_index += 3
      end
    end
  end

  def create_sector(sec_fields)
    unless sec_fields[0].empty?
      self.sector = Sector.find_or_create_by(
        name: sec_fields[0])
    end
  end
        
  def create_company(fields)
    self.company = Company.find_or_create_by(
      company_id: fields[0],
      website: fields[1],
      name: fields[2],
      #start_date: Date.parse(fields[3]),
      location: fields[4],
      status: fields[5],
      stage: fields[6],
      tags: fields[8],
      description: fields[9])
    self.company.sector = sector
    self.company.save
  end

  def create_person(pers_fields)
    unless pers_fields.nil? or pers_fields[1].nil? or pers_fields[1].empty?
      person = Person.find_or_create_by(
        photo_url: pers_fields[0],
        name: pers_fields[1],
        position: pers_fields[2],
        blog_url: pers_fields[3])
      person.company = self.company
      person.save
    end
  end

  def create_investor(inv_fields)
    unless inv_fields.nil? or inv_fields[0].nil? or inv_fields[0].empty?
      investor = Investor.find_or_create_by(
        #investment_period: Date.parse(inv_fields[0]),
        name: inv_fields[0]
      )
      investor.company = self.company
      investor.save
    end
  end

  def create_product(prod_fields)
    unless prod_fields.nil? or prod_fields[0].nil? or prod_fields[0].empty?
      product = Product.find_or_create_by(
        name: prod_fields[0],
        description: prod_fields[0]
      )
      product.company = self.company
      product.save
    end
  end
        
  def create_milestone(ms_fields)
    unless ms_fields.nil? or ms_fields[2].nil? or ms_fields[2].empty?
      ms = MileStone.find_or_create_by(
        name: ms_fields[2],
        #milestone_date: Date.parse(ms_fields[1])
      )
      ms.company = self.company
      ms.save
    end
  end
end

namespace :csvexport do
  desc "Parse the CSV file"
  task read: :environment do
    filepath = Rails.root.join('db', 'leo_chn.txt')
    ActiveRecord::Base.connection.schema_search_path = 'chinese'
    file = File.open(filepath, 'r:utf-16')
    leoMigration = LeoMigration.new(file, :zh)
    
    ActiveRecord::Base.connection.schema_search_path = 'public'
    filepath = Rails.root.join('db', 'seed.txt')
    file = File.open(filepath)
    leoMigration = LeoMigration.new(file)
    ActiveRecord::Base.connection.schema_search_path = 'public'
  end
end
