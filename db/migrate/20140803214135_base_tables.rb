class BaseTables < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "entries"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table(:sectors) do |t|
      t.string   "name"
      t.text     "description"
      t.integer  "entries"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table(:companies) do |t|
      t.string   "name"
      t.text     "description"
      t.string   "thumbnail"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
