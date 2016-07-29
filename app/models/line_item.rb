class LineItem < ActiveRecord::Base
  belongs_to :rule
  belongs_to :category
end
