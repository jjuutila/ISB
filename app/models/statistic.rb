class Statistic < ActiveRecord::Base
  belongs_to :member
  belongs_to :partition
  
  validates_presence_of :goals, :member, :partition, :assists, :pim, :matches
  
  validates_numericality_of :goals, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :assists, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :matches, :only_integer => true, :greater_than_or_equal_to => 0
  
  validates_numericality_of :pim, :only_integer => true, :greater_than_or_equal_to => 0
  
  validate :member_has_statistics?, :on => :create
  
  before_validation :set_defaults
  
  default_scope :order => 'goals + assists DESC, matches ASC'
  
  scope :in_partition, lambda { |partition| where("partition_id = ?", partition.id).
    includes(:member) }
  
  def points
    self.goals + self.assists
  end
  
  def all_0?
    self.matches == 0 && self.pim == 0 && self.assists == 0 && self.goals == 0
  end
  
  def member_has_statistics?
    matching_stats = Statistic.where :member_id => member_id, :partition_id => partition_id
    errors.add(:unique, "Member already has statistics.") if matching_stats.count != 0
  end
  
  private
  
  def set_defaults
    self.matches = 0 unless self.matches
    self.pim = 0 unless self.pim
    self.assists = 0 unless self.assists
    self.goals = 0 unless self.goals    
  end 
end
