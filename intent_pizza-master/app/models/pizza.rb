class Pizza < ActiveRecord::Base
  has_many :toppings
  belongs_to :user
  
  def order
    self.ordered = true
    self.save!
  end
end
