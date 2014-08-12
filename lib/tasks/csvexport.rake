class LeoMigration
  attr_accessor :company, :sector, :lang
  def initialize(file, lang='en')
    line_num = 0
    self.lang = lang
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
          fields[start_index..start_index+1])
        start_index += 2
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
    unless pers_fields.nil? or pers_fields[1].nil? or
      pers_fields[1].empty?
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
    unless inv_fields.nil? or inv_fields[0].nil? or
      inv_fields[0].empty?
      if self.lang == 'en'
        investor = Investor.find_or_create_by(
          investment_period: Date.parse(inv_fields[0]),
          name: inv_fields[2]
        )
      else
        investor = Investor.find_or_create_by(
          name: inv_fields[2]
        )
      end
      investor.company = self.company
      investor.save
    end
  end

  def create_product(prod_fields)
    unless prod_fields.nil? or prod_fields[0].nil? or
      prod_fields[0].empty?
      product = Product.find_or_create_by(
        name: prod_fields[0],
        description: prod_fields[1]
      )
      product.company = self.company
      product.save
    end
  end
        
  def create_milestone(ms_fields)
    unless ms_fields.nil? or ms_fields[1].nil? or
      ms_fields[1].empty?
      if self.lang == 'en'
        ms = MileStone.find_or_create_by(
          name: ms_fields[0],
          milestone_date: Date.parse(ms_fields[1])
        )
      else
        ms = MileStone.find_or_create_by(
          name: ms_fields[0]
        )
      end
      ms.company = self.company
      ms.save
    end
  end
end

class LeoMigrationSecond < LeoMigration
  def initialize(file, lang='en')
    line_num = 0
    self.lang = lang
    while (line = file.gets) do
      line_num += 1
      next if line_num == 1 
      fields = line.split(/\t/).map {|x|x.strip}
      next if fields[0].empty?
      create_company(fields)
    end
  end
  
  def create_sector(sec_fields)
    unless sec_fields[0].empty?
      self.sector = CSector.find_or_create_by(
        name: sec_fields[0])
    end
  end
        
  def create_company(fields)
    self.company = CCompany.find_or_create_by(
      company_id: fields[0],
      website: fields[1],
      name: fields[2],
      short_name_e: fields[3],
      short_name_c: fields[4],
      description: fields[5],
      city: fields[6],
      telephone: fields[7],
      fax: fields[8],
      postcode: fields[9],
      address: fields[10],
      sector_name: fields[11],
      founded: fields[12],
      headquarters: fields[13],
      investment_period_1: fields[14],
      investment_amount_1: fields[15],
      investment_tag_1: fields[16],
      investment_period_2: fields[17],
      investment_amount_2: fields[18],
      investment_tag_2: fields[19],
      investment_period_3: fields[20],
      investment_amount_3: fields[21],
      investment_tag_3: fields[22],
      investment_period_4: fields[23],
      investment_amount_4: fields[24],
      investment_tag_4: fields[25],
      investment_period_5: fields[26],
      investment_amount_5: fields[27],
      investment_tag_5: fields[28])
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
  
  desc "Parse the Second Data set"
  task read_second: :environment do
    filepath = Rails.root.join('db', 'leo_second.txt')
    ActiveRecord::Base.connection.schema_search_path = 
      'chinese'
    file = File.open(filepath, 'r:utf-16')
    leoMigration = LeoMigrationSecond.new(file, :zh)
    ActiveRecord::Base.connection.schema_search_path = 'public'
  end

end
