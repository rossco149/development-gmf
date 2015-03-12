class AddOrderToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :nav_order, :integer
    
	count = 1
    Collection.masters.each do |master|
      
      master.nav_order = count

      child_count = 1
      master.children.each do |child|
        child.nav_order= child_count

        child_count += 1
        child.save
      end
      master.save
      count += 1
    end
	
  end

  def self.down
    remove_column :collections, :nav_order
  end
end
