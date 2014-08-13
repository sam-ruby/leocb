class LeoMigration
  attr_accessor :company, :sector, :lang, :file
  def initialize(file, lang='en')
    self.lang = lang
    self.file = file
  end

  def store_long_company
    line_num = 0
    while (line = file.gets) do
      line_num += 1
      next if line_num == 1 
      fields = line.split(/\t/).map {|x|x.strip}
      next if fields[0].empty?
      create_long_company(fields)
      
      start_index = 10
      10.times do |x|
        create_person(
          x+1, fields[start_index..start_index+3])
        start_index += 4
      end

      5.times do |x|
        create_investor(
          x+1, fields[start_index..start_index+2])
        start_index += 3
      end
      
      5.times do |x|
        create_product(x+1, fields[start_index..start_index+1])
        start_index += 2
      end

      # skip competitor
      # 3
      if lang == 'en'
        company['competitor_1'] = fields[start_index]
        start_index += 1
      else
        company['competitor_1'] = fields[start_index]
        start_index += 1
        company['competitor_2'] = fields[start_index]
        start_index += 1
        company['competitor_3'] = fields[start_index]
        start_index += 1 
      end

      10.times do |x|
        create_milestone(x+1, fields[start_index..start_index+1])
        start_index += 2
      end
      self.company.save
    end
  end
  
  def create_long_company(fields)
    self.company = BigTable.find_or_create_by( 
      lang: self.lang,
      sector_name: fields[7],
      company_id: fields[0],
      website: fields[1],
      name: fields[2],
      start_date: fields[3],
      location: fields[4],
      status: fields[5],
      stage: fields[6],
      tags: fields[8],
      description: fields[9])
  end

  def create_person(x, pers_fields)
    unless pers_fields.nil? or pers_fields[1].nil? or
      pers_fields[1].empty?
      company["p#{x}_name"] = pers_fields[1]
      company["p#{x}_photo_url"] = pers_fields[0]
      company["p#{x}_blog_url"] = pers_fields[3]
      company["p#{x}_position"] = pers_fields[2]
    end
  end

  def create_investor(x, inv_fields)
    unless inv_fields.nil? or inv_fields[0].nil? or
      inv_fields[0].empty?
      company["i#{x}_investment_period"] = inv_fields[0]
      company["i#{x}_investment_amount"] = inv_fields[1]
      company["i#{x}_name"] = inv_fields[2]
    end
  end

  def create_product(x, prod_fields)
    unless prod_fields.nil? or prod_fields[0].nil? or
      prod_fields[0].empty?
      company["prod#{x}_name"] = prod_fields[0]
      company["prod#{x}_description"] = prod_fields[1]
    end
  end
        
  def create_milestone(x, ms_fields)
    unless ms_fields.nil? or ms_fields[1].nil? or
      ms_fields[1].empty?
      company["milestone#{x}_name"] = ms_fields[0]
      company["milestone#{x}_date"] = ms_fields[1]
    end
  end

  def unique?(website_url)
    return false if website_url.nil? or website_url.empty?
    parts = website_url.split(/\./)
    if parts.length > 1
      uniq_str = parts[-2, 2].join('.')
    else
      uniq_str = parts.first
    end
    if (BigTable.where('website like ?', uniq_str)).size > 0
      false
    else
      true
    end
  end
end

class LeoMigrationSecond < LeoMigration
  def initialize(file, lang='en')
    self.lang = lang
    self.file = file
  end

  def store_long_company
    line_num = 0
    while (line = file.gets) do
      line_num += 1
      next if line_num == 1 
      fields = line.split(/\t/).map {|x|x.strip}
      next if fields[0].empty?
      
      if unique?(fields[1])
        create_long_company(BigTable, fields)
      else
        create_long_company(BigTableDupes, fields)
      end
      
      start_index = 14
      5.times do |x|
        create_investor(
          x+1, fields[start_index..start_index+2])
        start_index += 3
      end
      self.company.save
    end
  end

  def create_long_company(table, fields)
    self.company = table.send :find_or_create_by, 
      lang: self.lang,
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
      headquarters: fields[13]
  end
end

class BaseTable 
  attr_accessor :big_company, :company, :sector, :lang
  def store(lang)
    BigTable.where('lang = ? ', lang).each do |big_c|
      self.big_company = big_c
      create_sector
      create_company
      
      10.times do |x|
        j = x + 1
        create_person(
          [big_company["p#{j}_photo_url"], big_company["p#{j}_name"],
           big_company["p#{j}_position"], big_company["p#{j}_blog_url"]]
        )
      end

      5.times do |x|
        j = x + 1
        create_investor(
          [big_company["i#{j}_investment_period"],
          big_company["i#{j}_investment_amount"],
          big_company["i#{j}_name"]]
        )
      end
      
      5.times do |x|
        j = x + 1
        create_product(
          [big_company["prod#{j}_name"],
          big_company["prod#{j}_description"]]
        )
      end

      10.times do |x|
        j = x + 1
        create_milestone(
          [big_company["milestone#{j}_name"],
          big_company["milestone#{j}_date"]]
        )
      end
      self.company.save
    end
  end

  def create_sector
    unless big_company.sector_name.nil? or big_company.sector_name.empty?
      self.sector = Sector.find_or_create_by(
        name: big_company.sector_name)
    end
  end
        
  def create_company
    self.company = Company.find_or_create_by(
      company_id: big_company.company_id,
      website: big_company.website,
      name: big_company.name,
      start_date: big_company.start_date,
      location: big_company.location,
      status: big_company.status,
      stage: big_company.stage,
      tags: big_company.tags,
      description: big_company.description,
      short_name_e: big_company.short_name_e,
      short_name_c: big_company.short_name_c,
      city: big_company.city,
      telephone: big_company.telephone,
      fax: big_company.fax,
      postcode: big_company.postcode,
      address: big_company.address,
      founded: big_company.founded,
      headquarters: big_company.headquarters)
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
      investor = Investor.find_or_create_by(
        investment_period: inv_fields[0],
        name: inv_fields[2])
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
      ms = MileStone.find_or_create_by(
        name: ms_fields[0],
        milestone_date: ms_fields[1])
      ms.company = self.company
      ms.save
    end
  end
end


namespace :csvexport do
  desc "Base Data sources"
  task base_ds: :environment do
    filepath = Rails.root.join('db', 'leo_chn.txt')
    file = File.open(filepath, 'r:utf-16')
    ActiveRecord::Base.connection.schema_search_path = 'chinese'
    leoMigration = LeoMigration.new(file, :zh)
    leoMigration.store_long_company()
    
    filepath = Rails.root.join('db', 'seed.txt')
    file = File.open(filepath)
    leoMigration = LeoMigration.new(file)
    leoMigration.store_long_company()
    ActiveRecord::Base.connection.schema_search_path = 'public'
  end
  
  desc "Load the Second Data set"
  task second_ds: :environment do
    filepath = Rails.root.join('db', 'leo_second.txt')
    file = File.open(filepath, 'r:utf-16')
    ActiveRecord::Base.connection.schema_search_path = 
      'chinese'
    leoMigration = LeoMigrationSecond.new(file, :zh)
    leoMigration.store_long_company()
    ActiveRecord::Base.connection.schema_search_path = 'public'
  end
  
  desc "Load Data from Big tables"
  task base_data: :environment do
    ActiveRecord::Base.connection.schema_search_path = 'chinese'
    BaseTable.new.store(:zh)
    ActiveRecord::Base.connection.schema_search_path = 
      'public'
    BaseTable.new.store(:en)
  end

  desc "Seed data"
  task seed_data: [:environment, :base_ds, :second_ds, :base_data]
end
