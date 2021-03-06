class Company2 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.schema_search_path =  'chinese'
      end
      
      dir.down do
        ActiveRecord::Base.connection.schema_search_path =  'public'
      end
    end
    create_table('big_table') do |t|
      t.string   "sector_name"
      t.string   'lang'
      t.integer 'company_id'
      t.string 'website'
      t.string 'start_date'
      t.string 'location'
      t.string 'status'
      t.string 'stage'
      t.string 'tags'
      t.string "name"
      t.string "short_name_e"
      t.string "short_name_c"
      t.text   "description"
      t.string 'p1_name'
      t.string 'p1_photo_url'
      t.string 'p1_blog_url'
      t.string 'p1_position'
      t.string 'p2_name'
      t.string 'p2_photo_url'
      t.string 'p2_blog_url'
      t.string 'p2_position'
      t.string 'p3_name'
      t.string 'p3_photo_url'
      t.string 'p3_blog_url'
      t.string 'p3_position'
      t.string 'p4_name'
      t.string 'p4_photo_url'
      t.string 'p4_blog_url'
      t.string 'p4_position'
      t.string 'p5_name'
      t.string 'p5_photo_url'
      t.string 'p5_blog_url'
      t.string 'p5_position'
      t.string 'p6_name'
      t.string 'p6_photo_url'
      t.string 'p6_blog_url'
      t.string 'p6_position'
      t.string 'p7_name'
      t.string 'p7_photo_url'
      t.string 'p7_blog_url'
      t.string 'p7_position'
      t.string 'p8_name'
      t.string 'p8_photo_url'
      t.string 'p8_blog_url'
      t.string 'p8_position'
      t.string 'p9_name'
      t.string 'p9_photo_url'
      t.string 'p9_blog_url'
      t.string 'p9_position'
      t.string 'p10_name'
      t.string 'p10_photo_url'
      t.string 'p10_blog_url'
      t.string 'p10_position'
      t.string 'i1_investment_period'
      t.string 'i1_name'
      t.string 'i1_investment_amount'
      t.string 'i2_investment_period'
      t.string 'i2_name'
      t.string 'i2_investment_amount'
      t.string 'i3_investment_period'
      t.string 'i3_name'
      t.string 'i3_investment_amount'
      t.string 'i4_investment_period'
      t.string 'i4_name'
      t.string 'i4_investment_amount'
      t.string 'i5_investment_period'
      t.string 'i5_name'
      t.string 'i5_investment_amount'
      t.string 'prod1_name'
      t.text 'prod1_description'
      t.string 'prod2_name'
      t.text 'prod2_description'
      t.string 'prod3_name'
      t.text 'prod3_description'
      t.string 'prod4_name'
      t.text 'prod4_description'
      t.string 'prod5_name'
      t.text 'prod5_description'
      t.string 'competitor_1'
      t.string 'competitor_2'
      t.string 'competitor_3'
      t.text 'milestone1_name'
      t.string 'milestone1_date'
      t.text 'milestone2_name'
      t.string 'milestone2_date'
      t.text 'milestone3_name'
      t.string 'milestone3_date'
      t.text 'milestone4_name'
      t.string 'milestone4_date'
      t.text 'milestone5_name'
      t.string 'milestone5_date'
      t.text 'milestone6_name'
      t.string 'milestone6_date'
      t.text 'milestone7_name'
      t.string 'milestone7_date'
      t.text 'milestone8_name'
      t.string 'milestone8_date'
      t.text 'milestone9_name'
      t.string 'milestone9_date'
      t.text 'milestone10_name'
      t.string 'milestone10_date'
      t.string "city"
      t.string "telephone"
      t.string "fax"
      t.string "postcode"
      t.string "address"
      t.string "founded"
      t.string "headquarters"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index 'big_table', [:company_id, :lang, :name],
      {unique: true, name: 'big_table_name_company_id_lang_index'} 
    
    add_index 'big_table', [:website],
      {name: 'big_table_website_index'} 

    create_table('big_table_dupes') do |t|
      t.string   "sector_name"
      t.integer 'company_id'
      t.string 'lang'
      t.string 'website'
      t.string'start_date'
      t.string 'location'
      t.string 'status'
      t.string 'stage'
      t.string 'tags'
      t.string "name"
      t.string "short_name_e"
      t.string "short_name_c"
      t.text   "description"
      t.string 'p1_name'
      t.string 'p1_photo_url'
      t.string 'p1_blog_url'
      t.string 'p1_position'
      t.string 'p2_name'
      t.string 'p2_photo_url'
      t.string 'p2_blog_url'
      t.string 'p2_position'
      t.string 'p3_name'
      t.string 'p3_photo_url'
      t.string 'p3_blog_url'
      t.string 'p3_position'
      t.string 'p4_name'
      t.string 'p4_photo_url'
      t.string 'p4_blog_url'
      t.string 'p4_position'
      t.string 'p5_name'
      t.string 'p5_photo_url'
      t.string 'p5_blog_url'
      t.string 'p5_position'
      t.string 'p6_name'
      t.string 'p6_photo_url'
      t.string 'p6_blog_url'
      t.string 'p6_position'
      t.string 'p7_name'
      t.string 'p7_photo_url'
      t.string 'p7_blog_url'
      t.string 'p7_position'
      t.string 'p8_name'
      t.string 'p8_photo_url'
      t.string 'p8_blog_url'
      t.string 'p8_position'
      t.string 'p9_name'
      t.string 'p9_photo_url'
      t.string 'p9_blog_url'
      t.string 'p9_position'
      t.string 'p10_name'
      t.string 'p10_photo_url'
      t.string 'p10_blog_url'
      t.string 'p10_position'
      t.string 'i1_investment_period'
      t.string 'i1_name'
      t.string 'i1_investment_amount'
      t.string 'i2_investment_period'
      t.string 'i2_name'
      t.string 'i2_investment_amount'
      t.string 'i3_investment_period'
      t.string 'i3_name'
      t.string 'i3_investment_amount'
      t.string 'i4_investment_period'
      t.string 'i4_name'
      t.string 'i4_investment_amount'
      t.string 'i5_investment_period'
      t.string 'i5_name'
      t.string 'i5_investment_amount'
      t.string 'prod1_name'
      t.text 'prod1_description'
      t.string 'prod2_name'
      t.text 'prod2_description'
      t.string 'prod3_name'
      t.text 'prod3_description'
      t.string 'prod4_name'
      t.text 'prod4_description'
      t.string 'prod5_name'
      t.text 'prod5_description'
      t.string 'competitor_1'
      t.string 'competitor_2'
      t.string 'competitor_3'
      t.text 'milestone1_name'
      t.string 'milestone1_date'
      t.text 'milestone2_name'
      t.string 'milestone2_date'
      t.text 'milestone3_name'
      t.string 'milestone3_date'
      t.text 'milestone4_name'
      t.string 'milestone4_date'
      t.text 'milestone5_name'
      t.string 'milestone5_date'
      t.text 'milestone6_name'
      t.string 'milestone6_date'
      t.text 'milestone7_name'
      t.string 'milestone7_date'
      t.text 'milestone8_name'
      t.string 'milestone8_date'
      t.text 'milestone9_name'
      t.string 'milestone9_date'
      t.text 'milestone10_name'
      t.string 'milestone10_date'
      t.string "city"
      t.string "telephone"
      t.string "fax"
      t.string "postcode"
      t.string "address"
      t.string "founded"
      t.string "headquarters"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index 'big_table_dupes', [:company_id, :lang, :name],
      {unique: true, name: 'big_table_dupes_name_company_id_lang_index'} 
      
    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.schema_search_path =  'public'
      end
      
      dir.down do
        ActiveRecord::Base.connection.schema_search_path =  'chinese'
      end
    end
  end
end
