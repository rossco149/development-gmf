class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table "quotes" do |t|
      t.column :quote_type,                     :string, :limit => 10,:default => "private"
      t.column :customer_name,            :string, :limit => 255, :null => false
      t.column :quote_text,               :string
    end
  end

  def self.down
    drop_table "quotes"
  end
end
