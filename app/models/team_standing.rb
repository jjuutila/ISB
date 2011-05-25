# coding: utf-8
class TeamStanding < ActiveRecord::Base
  default_scope :order => 'rank ASC'
  
  belongs_to :partition
  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :visitor_matches, :class_name => 'Match', :foreign_key => 'visitor_team_id'
  
  validates_presence_of :name, :partition
  
  validates_numericality_of :wins, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :losses, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :overtimes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_for, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_against, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :rank, :only_integer => true, :greater_than_or_equal_to => 1
  
  after_initialize :set_defaults
  before_validation :set_rank, :if => Proc.new { |team| team.rank.nil? and team.partition and team.new_record? }
  
  scope :in_partition, lambda { |partition| where(:partition_id => partition.id) }
  
  def set_defaults
    self.wins = 0 unless self.wins
    self.losses = 0 unless self.losses
    self.overtimes = 0 unless self.overtimes
    self.goals_for = 0 unless self.goals_for
    self.goals_against = 0 unless self.goals_against
  end
  
  def set_rank
    if self.partition.team_standings.blank?
      self.rank = 1
    else
      self.rank = self.partition.team_standings.last.rank + 1
    end
  end
  
  def points
    2 * wins + overtimes
  end
  
  def games_played
    wins + overtimes + losses
  end
  
  def to_s
    name
  end
end
