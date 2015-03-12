class Collection < ActiveRecord::Base

  has_and_belongs_to_many :products

  validates_presence_of :name, :message=>" Should be entered as its used in the main navigation!"
  validates_uniqueness_of :name, :message => "There is already a collection that exists with this name."

  named_scope :on_site, lambda{|on_site|{
    :conditions=>["show_on_site=?", on_site]
    } }

  named_scope :by_master, lambda{|master|{
    :conditions=>["master_collection=?", master],
    :order=>"nav_order asc"
    } }

  named_scope :masters, lambda{
    {
      :conditions=>["master_collection IS NULL"],
    :order=>"nav_order asc"
    }
  }

  named_scope :with_children, lambda{
    {
      :joins => ["INNER JOIN collections_products ON collections.id = collections_products.collection_id"],
    :order=>"nav_order asc"
    }
  }

  named_scope :by_nav_order, lambda{|nav_order|{
    :conditions=>["nav_order = ?", nav_order],
    :order=>"nav_order asc"
    } }

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
