class SectionGroup < ActiveRecord::Base
  has_many :sections
  validates_presence_of :name, :slug
  validates_inclusion_of :are_players_male, :in => [true, false]
  
  scope :all, includes(:sections)
  
  def to_s
    name
  end
end
