class UpdateFireplaces < ActiveRecord::Migration
  def self.up
    #fireplace becomes product
    rename_table :fireplaces, :products
    #create a join table for collections_products - id of each other
    create_table "collections_products", :id=>false do |t|
      t.column :collection_id,               :integer
      t.column :product_id,                :integer
    end
  end

  def self.down
    #change product to fireplace
    rename_table :products, :fireplaces
    #drop the join table
    drop_table "collections_products"
  end
end
