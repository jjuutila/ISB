# coding: utf-8
class Partition < ActiveRecord::Base
  belongs_to :season
  has_many :team_standings
  has_many :matches
  
  validates_presence_of :name, :position
  validates_numericality_of :position, :only_integer => true, :greater_than => 0
end
