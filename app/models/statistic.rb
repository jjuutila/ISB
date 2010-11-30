class Statistic < ActiveRecord::Base
  belongs_to :member
  belongs_to :partition
  
  validates_presence_of :goals, :member, :partition, :assists, :pim, :matches
  
  validates_numericality_of :goals, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :assists, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :matches, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :pim, :only_integer => true, :greater_than_or_equal_to => 0
  
  before_validation :set_defaults
  
  def points
    self.goals + self.assists
  end
  
  private
  
  def set_defaults
    self.matches = 0 unless self.matches
    self.pim = 0 unless self.pim
    self.assists = 0 unless self.assists
    self.goals = 0 unless self.goals    
  end 
end
