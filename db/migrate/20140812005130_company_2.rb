class Company2 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up {
        ActiveRecord::Base.connection.schema_search_path = 'chinese'
      }
      dir.down {
        ActiveRecord::Base.connection.schema_search_path = 'public'
      }
    end
    
    create_table(:c_companies) do |t|
      t.string   "sector_name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer 'company_id'
      t.string 'website'
      t.date 'start_date'
      t.string 'location'
      t.string 'status'
      t.string 'stage'
      t.string 'tags'
      t.string "name"
      t.string "short_name_e"
      t.string "short_name_c"
      t.text   "description"
      t.string "city"
      t.string "telephone"
      t.string "fax"
      t.string "postcode"
      t.string "address"
      t.string "founded"
      t.string "headquarters"
      t.string "investment_period_1"
      t.string "investment_amount_1"
      t.string "investment_tag_1"
      t.string "investment_period_2"
      t.string "investment_amount_2"
      t.string "investment_tag_2"
      t.string "investment_period_3"
      t.string "investment_amount_3"
      t.string "investment_tag_3"
      t.string "investment_period_4"
      t.string "investment_amount_4"
      t.string "investment_tag_4"
      t.string "investment_period_5"
      t.string "investment_amount_5"
      t.string "investment_tag_5"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :c_companies, [:company_id, :name],
      {unique: true, name: 'c_company_name_company_id_index'} 


    reversible do |dir|
      dir.up {
        ActiveRecord::Base.connection.schema_search_path = 'public'
      }
      dir.down {
        ActiveRecord::Base.connection.schema_search_path = 'chinese'
      }
    end
  end
end
