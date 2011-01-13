# coding: utf-8
class Partition < ActiveRecord::Base
  belongs_to :season
  has_many :team_standings
  has_many :matches
  has_many :statistics
  
  validates_presence_of :name, :position, :season
  validates_numericality_of :position, :only_integer => true, :greater_than => 0
  
  scope :in_season, lambda { |id| where("season_id = ?", id) }
  
  before_validation :set_position
  
  # Gets the latest season's last partition
  def self.latest(section)
    Partition.where('season_id = ?', Season.latest(section)).order('position DESC').first
  end
  
  def to_s
    name
  end
  
  def set_position
    if self.position.nil? and !self.season_id.nil?
      largest_position = Partition.where(:season_id => self.season_id).maximum(:position)
      if largest_position.nil?
        self.position = 1
      else
        self.position = largest_position + 1
      end
    end
  end
end
