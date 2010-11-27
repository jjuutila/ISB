class Statistic < ActiveRecord::Base
  belongs_to :member
  belongs_to :partition
  
  validates_presence_of :goals, :member, :partition, :assists, :pim, :matches
  
  validates_numericality_of :goals, :only_integer => true, :greater_than => 0
  
  validates_numericality_of :assists, :only_integer => true, :greater_than => 0
  
  validates_numericality_of :matches, :only_integer => true, :greater_than => 0
  
  validates_numericality_of :pim, :only_integer => true, :greater_than => 0
  
end
