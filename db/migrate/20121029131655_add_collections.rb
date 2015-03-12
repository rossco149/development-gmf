class AddCollections < ActiveRecord::Migration
  def self.up
    create_table "collections" do |t|
      t.column :name,                     :string, :null=>false
      t.column :show_on_site,             :boolean
      t.column :description,              :string
      t.column :master_collection,        :integer
    end
  end

  def self.down
    drop_table "collections"
  end
end
