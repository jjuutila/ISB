class LinkCategory < ActiveRecord::Base
  belongs_to :section
  has_many :links, :foreign_key => "category_id"
  validates_presence_of :section
  validates_presence_of :name
  
  scope :in_section, lambda {|section| includes(:links).where(:section_id => section.id).order("name DESC")}
  
  def to_s
    name
  end
end
