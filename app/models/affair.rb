# coding: utf-8
class Affair < ActiveRecord::Base
  belongs_to :member
  belongs_to :season
  
  validates_presence_of :member, :season, :role
  validates_inclusion_of :role, :in => ['player', 'assistant']
  
  scope :players_on_season, lambda { |id| where("season_id = ? AND role = ?", id, 'player') }
end
