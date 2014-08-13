class AddColsCompanies < ActiveRecord::Migration
  def change
    change_table('chinese.companies') do |t|
      t.string :short_name_e
      t.string :short_name_c
      t.string "city"
      t.string "telephone"
      t.string "fax"
      t.string "postcode"
      t.string "address"
      t.string "founded"
      t.string "headquarters"
    end
    
    change_table('public.companies') do |t|
      t.string :short_name_e
      t.string :short_name_c
      t.string "city"
      t.string "telephone"
      t.string "fax"
      t.string "postcode"
      t.string "address"
      t.string "founded"
      t.string "headquarters"
    end
  end
end
