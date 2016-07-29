class Rule < ActiveRecord::Base
  has_many :line_items
  has_many :categories,through: :line_items
  belongs_to :committee

validates :title, presence: true
validates :content, presence: true
validates :committee_id, presence: true
validates :category_ids, presence: true



def self.search(search)
  where("title LIKE :search OR content LIKE :search OR id LIKE :search", search: "%#{search}%") 
end


end


