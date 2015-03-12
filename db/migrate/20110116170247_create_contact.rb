class CreateContact < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.column :name,      :string, :null => false
      t.column :address,   :string
      t.column :enquiry,   :string
      t.column :phone,     :string
      t.column :email,     :string, :null=>false
      t.column :fire_type,      :string
      t.column :callback_method,  :string
      t.column :viewed, :boolean, :default => false
      t.column :created, :timestamp, :null => false #datetime
    end
  end

  def self.down
    drop_table :contacts
  end
end