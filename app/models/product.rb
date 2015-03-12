class Product < ActiveRecord::Base
  require "paperclip"

  has_and_belongs_to_many :collections

  styles = { :large => "500x400>", :medium=>"300x200", :small => "200x100>" }

  if Rails.env=="development"
    has_attached_file :image, :styles => styles
  else
    has_attached_file :image, :styles => styles,
                      :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => "/:style/:filename"
					  
	
  end
  validates_attachment_presence :image
  do_not_validate_attachment_file_type :image
	
  MATERIALS = {"1" =>"Marble", "2" =>"Limestone", "3" => "Wooden"}
  MATERIAL_IDS = {"Marble" => "1", "Limestone" => "2", "Wooden" => "3"}

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "There is already a fireplace that exists with this name"

  scope :by_material, lambda { |type|
	where("available_materials like ?", "%#{type}%")
	}

  scope :featured_by_amount, lambda { |amount|
      where("featured = ? and show_on_site = ?", true, true).order("image_updated_at desc").limit(amount)
	 }

  scope :on_site, lambda{|on_site|
    where("show_on_site=?", on_site)
	}

  scope :by_collection, lambda{|collection|
    joins("INNER JOIN collections_products ON product_id = products.id").where("collection_id =?", collection)
	}

  before_save :strip_materials


  def strip_materials
    if not self.available_materials.instance_of?(String)
      self.available_materials = self.available_materials.join(",").strip
    end
  end
end
