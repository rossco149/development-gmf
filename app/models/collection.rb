class Collection < ActiveRecord::Base

  has_and_belongs_to_many :products

  validates_presence_of :name, :message=>" Should be entered as its used in the main navigation!"
  validates_uniqueness_of :name, :message => "There is already a collection that exists with this name."

  scope :on_site, lambda{|on_site|
    where("show_on_site=?", on_site)
  }

  scope :by_master, lambda{|master|
    where("master_collection=?", master).order("nav_order asc")
	}

  scope :masters, lambda{
    where("master_collection IS NULL").order("nav_order asc")
  }

  scope :with_children, lambda{
      joins("INNER JOIN collections_products ON collections.id = collections_products.collection_id").order("nav_order asc")
  }

  scope :by_nav_order, lambda{|nav_order|
    where("nav_order = ?", nav_order).order("nav_order asc")
    }

  def display_name
    (self.ismaster?) ? (self.name.downcase.pluralize) : (self.name.downcase+" #{self.master.name.downcase.pluralize}")
  end

  def children
    Collection.by_master(self)
  end

  def master
    Collection.find(self.master_collection)
  end

  def ismaster?
    (self.master_collection.blank? and not self.id.blank?) ? true : false
  end
end
