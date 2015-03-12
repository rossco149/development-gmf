class Quote < ActiveRecord::Base

  validates_presence_of :quote_type, :customer_name
  validates_inclusion_of :quote_type, :in =>["trade", "private"], :message=> "must be a trade or private quote"

  scope :by_type, lambda { |type| 
	where("quote_type = ? and show_on_site = ?", type, true)
	}
end
