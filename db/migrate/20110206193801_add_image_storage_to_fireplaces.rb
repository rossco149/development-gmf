class AddImageStorageToFireplaces < ActiveRecord::Migration
  def self.up
    remove_column :fireplaces, :large_image
    remove_column :fireplaces, :small_image

    add_column :fireplaces, :large_image, :binary
    add_column :fireplaces, :small_image, :binary
    add_column :fireplaces, :image_type, :string, :limit => 50
  end

  def self.down
    remove_column :fireplaces, :large_image
    remove_column :fireplaces, :small_image

    add_column :fireplaces, :large_image, :string
    add_column :fireplaces, :small_image, :string
    remove_column :fireplaces, :image_type
  end
end
