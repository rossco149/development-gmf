class AddHomeBanner < ActiveRecord::Migration
  def self.up
    create_table "homebanners" do |t|
      t.column :name,                 :string,:null => false
      t.column :description,          :string, :limit => 255, :null => false
      t.column :image,               :string
      t.column :show_on_site,         :boolean
      t.column :image_file_name,      :string
      t.column :image_content_type,   :string
      t.column :image_file_size,      :integer
      t.column :image_updated_at,     :datetime

    end
  end

  def self.down
    drop_table "homebanners"
  end
end
