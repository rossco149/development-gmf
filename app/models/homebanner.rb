class Homebanner < ActiveRecord::Base
  require "paperclip"

  styles = { :banner => "329x265>" }
  #styles = { :banner => "650x280"}

  if RAILS_ENV=="development"
    has_attached_file :image, :styles => styles
  else
    has_attached_file :image, :styles => styles,
                      :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                      :path => "/:style/:filename"
  end
  
  validates_attachment_presence :image
  validates_presence_of :name
  validates_presence_of :description, :message => "text will be shown to the right of the banner."

  named_scope :on_site, lambda{|on_site|{
    :conditions=>["show_on_site=?", on_site]
    } }

  named_scope :limit, lambda{|amount|{
    :limit=>amount,
    :order=>"id desc"
    } }
end
