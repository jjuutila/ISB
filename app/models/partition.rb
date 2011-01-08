# coding: utf-8
class Partition < ActiveRecord::Base
  belongs_to :season
  has_many :team_standings
  has_many :matches
  has_many :statistics
  
  validates_presence_of :name, :position, :season
  validates_numericality_of :position, :only_integer => true, :greater_than => 0
  
  scope :in_season, lambda { |id| where("season_id = ?", id) }
  
  # Gets the latest season's last partition
  def self.latest(section)
    Partition.where('season_id = ?', Season.latest(section)).order('position DESC').first
  end
  
  def to_s
    name
  end
end
