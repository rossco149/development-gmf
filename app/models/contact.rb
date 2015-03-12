class Contact < ActiveRecord::Base

  acts_as_textcaptcha :questions => [{ 'question' => 'A green hat is what color?', 'answers' => 'green' },
                                     { 'question' => 'A red hat is what color?', 'answers' => 'red' },
                                     { 'question' => 'A blue hat is what color?', 'answers' => 'blue' },
                                     { 'question' => 'A pink hat is what color?', 'answers' => 'pink' }

                                     ]


  validates_presence_of :callback_method, :message=>"is required to allow us to contact you"
  validates_presence_of :name, :message=>"is required to allow us to contact you"
  validates_presence_of :created
end
