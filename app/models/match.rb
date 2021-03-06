# coding: utf-8
class Match < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'TeamStanding'
  belongs_to :visitor_team, :class_name => 'TeamStanding'
  belongs_to :partition
  
  validates_associated :visitor_team, :home_team, :partition
  validates_presence_of :visitor_team, :home_team, :partition, :location, :start_time
  
  validates_numericality_of :home_goals, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_numericality_of :visitor_goals, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
  
  validates_inclusion_of :additional_info, :in => %w(shootout overtime), :allow_nil => true
  
  validate :teams_cannot_be_equal
  
  default_scope :order => 'start_time ASC'
  
  scope :upcoming, where(:start_time => (DateTime.now.at_beginning_of_day)..(DateTime.now.advance(:days => 30))).
    includes(:visitor_team, :home_team, :partition => [{:season => :section}]).order(:start_time)
  
  def result
    "#{home_goals}-#{visitor_goals}"
  end
  
  def teams_cannot_be_equal
    errors[:base] << "Joukkueet eivät voi olla samat." if home_team == visitor_team and home_team != nil
  end
  
  def to_s
    "#{home_team} - #{visitor_team}"
  end
end
