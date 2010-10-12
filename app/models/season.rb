class Season < ActiveRecord::Base
  belongs_to :section
  has_many :member, :through => :affairs
  
  validates_numericality_of :start_year, :only_integer => true, :greater_than => 2000, :message => 'kebabpizza'
  validates_presence_of :division
end
