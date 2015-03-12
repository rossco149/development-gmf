class AddPaperclipColumnsToFireplace < ActiveRecord::Migration
  def self.up
    add_column :fireplaces, :image_file_name,    :string
    add_column :fireplaces, :image_content_type, :string
    add_column :fireplaces, :image_file_size,    :integer
    add_column :fireplaces, :image_updated_at,   :datetime

    remove_column :fireplaces, :large_image
    remove_column :fireplaces, :small_image
    remove_column :fireplaces, :image_type
  end

  def self.down
    remove_column :fireplaces, :fireplace_file_name
    remove_column :fireplaces, :fireplace_content_type
    remove_column :fireplaces, :fireplace_file_size
    remove_column :fireplaces, :fireplace_updated_at

    add_column :fireplaces, :large_image, :binary
    add_column :fireplaces, :small_image, :binary
    add_column :fireplaces, :image_type, :string
  end

end
