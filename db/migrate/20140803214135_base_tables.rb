class BaseTables < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up {
        ActiveRecord::Base.connection.schema_search_path = 'public'
      }
    end
    create_table(:categories) do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "entries"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :categories, :name, 
      {unique: true, name: 'category_name_index'} 
    
    create_table(:sectors) do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :sectors, :name, 
      {unique: true, name: 'sector_name_index'} 
    
    create_table(:companies) do |t|
      t.belongs_to :sector
      t.integer 'company_id'
      t.string 'website'
      t.string 'start_date'
      t.string 'location'
      t.string 'status'
      t.string 'stage'
      t.string 'tags'
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :companies, [:company_id, :name],
      {unique: true, name: 'company_name_company_id_index'} 

    create_table(:persons) do |t|
      t.belongs_to :company
      t.string 'name'
      t.string 'photo_url'
      t.string 'blog_url'
      t.string 'position'
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :persons, :company_id,
      {name: 'persons_company_id_index'} 

    create_table(:investors) do |t|
      t.belongs_to :company
      t.string 'investment_period'
      t.string 'name'
      t.string 'investment_amount'
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :investors, :company_id,
      {name: 'investors_company_id_index'} 
    
    create_table(:products) do |t|
      t.belongs_to :company
      t.string 'name'
      t.text 'description'
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :products, :company_id,
      {name: 'products_company_id_index'} 

    create_table(:mile_stones) do |t|
      t.belongs_to :company
      t.text 'name'
      t.string 'milestone_date'
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index :mile_stones, :company_id,
      {name: 'mile_stones_company_id_index'} 
    
    reversible do |dir|
      dir.up {
        ActiveRecord::Base.connection.schema_search_path = 'public'
      }
    end
  end
end
