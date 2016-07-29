class Committee < ActiveRecord::Base
  has_many :rules
  
  validates :name, presence: true
end
