class AddShowOnSiteToModels < ActiveRecord::Migration
  def self.up
    add_column :fireplaces, :show_on_site, :boolean, :default=>true
    add_column :quotes, :show_on_site, :boolean, :default => true
  end

  def self.down
    remove_column :fireplaces, :show_on_site
    remove_column :quotes, :show_on_site
  end
end
