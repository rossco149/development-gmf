class CreateFireplaces < ActiveRecord::Migration
  def self.up
    create_table "fireplaces" do |t|
      t.column :name,                 :string,:null => false
      t.column :description,          :string, :limit => 255, :null => false
      t.column :available_materials,  :string
      t.column :large_image,          :string
      t.column :small_image,          :string
      t.column :featured,             :boolean
    end
  end

  def self.down
    drop_table "fireplaces"
  end
end
