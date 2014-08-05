namespace :csvexport do
  desc "Parse the CSV file"
  task read: :environment do
    require 'debugger'
    filepath = Rails.root.join('db', 'seed.txt')
    File.readlines(filepath).each_with_index {|line, line_num|
      next if line_num == 0 
      fields = line.split(/\t/).map {|x|x.strip}
      next if fields[0].empty?
      fields.each_with_index {|f, i| puts f, i }
=begin      
      line.each_char {|c|
       i += 1
        if c == '"'
          if flag == true
            flag = false
          else
            flag = true
          end
        end
        next if flag
        if (c == ',') 
          fields_p.push(line[start_c, i])
          puts fields_p.inspect
          start_c += i + 1
        end
      }
      puts fields_p.inspect
      exit
=end
      create_sector = Proc.new {|sec_fields|
        puts 'sector ', sec_fields.inspect
        unless sec_fields[0].empty?
          sector = Sector.find_or_create_by(
            name: sec_fields[0])
        end
      }
      
      sector = create_sector.call(fields[7..7])
      company = Company.find_or_create_by(
        company_id: fields[0],
        website: fields[1],
        name: fields[2],
        start_date: Date.parse(fields[3]),
        location: fields[4],
        status: fields[5],
        stage: fields[6],
        tags: fields[8],
        description: fields[9])
      company.sector = sector
      company.save

      create_person = Proc.new {|pers_fields|
        puts 'person ', pers_fields.inspect
        unless pers_fields[1].empty?
          person = Person.find_or_create_by(
            photo_url: pers_fields[0],
            name: pers_fields[1],
            position: pers_fields[2],
            blog_url: pers_fields[3])
          person.company = company
          person.save
        end
      }

      create_investor = Proc.new {|inv_fields|
        puts 'investor ', inv_fields
        unless inv_fields[0].empty?
          investor = Investor.find_or_create_by(
            investment_period: Date.parse(inv_fields[0]),
            name: inv_fields[0]
          )
          investor.company = company
          investor.save
        end
      }

      create_product = Proc.new {|prod_fields|
        puts 'product ', prod_fields.inspect
        unless prod_fields[0].empty?
          product = Product.find_or_create_by(
            name: prod_fields[0],
            description: prod_fields[0]
          )
          product.company = company
          product.save
        end
      }
      
      create_milestone = Proc.new {|ms_fields|
        puts 'milestone ', ms_fields.inspect
        unless ms_fields[1].empty?
          ms = MileStone.find_or_create_by(
            name: ms_fields[0],
            milestone_date: Date.parse(ms_fields[1])
          )
          ms.company = company
          ms.save
        end
      }

      
      start_index = 10
      10.times do |x|
        create_person.call(fields[start_index..start_index+3])
        start_index += 4
      end

      
      5.times do |x|
        create_investor.call(fields[start_index..start_index+2])
        start_index += 3
      end
      
      5.times do |x|
        create_product.call(fields[start_index..start_index+1])
        start_index += 2
      end

      # skip competitor
      start_index += 1

      10.times do |x|
        create_milestone.call(fields[start_index..start_index+1])
        start_index += 2
      end
    }
  end
end
