class AddSuperUser < ActiveRecord::Migration
  def self.up
    add_column :users, :super, :boolean, :default => false
    hidden_pass = Digest::MD5.hexdigest("32Linnhead")
    User.create(:username => "admin", :password => hidden_pass, :super => true)
  end

  def self.down
    User.destroy(User.last)
    remove_column :users, :super
  end
end
