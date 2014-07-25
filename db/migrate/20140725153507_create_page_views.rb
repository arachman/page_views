class CreatePageViews < ActiveRecord::Migration
  def up
    create_table :page_views do |t|
      t.string :api_key, null: false
      t.string :ip_address, null: false
      t.string :page_url, null: false
      t.timestamps
    end
  end

  def down
    drop_table :page_views
  end
end
