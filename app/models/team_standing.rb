# coding: utf-8
class TeamStanding < ActiveRecord::Base
  belongs_to :partition
  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :visitor_matches, :class_name => 'Match', :foreign_key => 'visitor_team_id'
  
  validates_presence_of :name, :partition
  
  validates_numericality_of :wins, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :losses, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :overtimes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_for, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :goals_against, :only_integer => true, :greater_than_or_equal_to => 0
  
  after_initialize :set_defaults
  
  def set_defaults
    self.wins = 0 unless self.wins
    self.losses = 0 unless self.losses
    self.overtimes = 0 unless self.overtimes
    self.goals_for = 0 unless self.goals_for
    self.goals_against = 0 unless self.goals_against
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
