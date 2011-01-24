class LinkCategory < ActiveRecord::Base
  belongs_to :section
  has_many :links, :foreign_key => "category_id"
  validates_presence_of :section
  validates_presence_of :name
end
