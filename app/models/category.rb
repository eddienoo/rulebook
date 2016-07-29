class Category < ActiveRecord::Base
  has_many :line_items
  has_many :rules,through: :line_items
  
  validates :name, presence: true
end
