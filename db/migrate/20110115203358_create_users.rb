class CreateUsers < ActiveRecord::Migration
  def self.up
  create_table "users" do |t|
      t.column :username,          :string,:null => false
      t.column :password,          :string,:null => false
      t.column :last_login,        :datetime
  end

    hidden_pass = Digest::MD5.hexdigest("mcalpine")
    User.create(:username => "admin", :password => hidden_pass)
  end

  def self.down
    drop_table "users"
  end
end
