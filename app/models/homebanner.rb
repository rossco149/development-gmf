class Homebanner < ActiveRecord::Base
  require "paperclip"
	
  
  styles = { :banner => "329x265>" }
  #styles = { :banner => "650x280"}

  if Rails.env=="development"
    has_attached_file :image, :styles => styles
  else
    has_attached_file :image, :styles => styles,
                      :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => "/:style/:filename"
  
	validates_attachment_presence :image
  end
  
  do_not_validate_attachment_file_type :image
  validates_presence_of :name
  validates_presence_of :description, :message => "text will be shown to the right of the banner."

  scope :on_site, lambda{|on_site|
    where("show_on_site=?", on_site)
    }

  scope :by_limit, lambda{|amount|
    limit(amount).order("id desc")
   }
end
