# coding: utf-8
class TeamStanding < ActiveRecord::Base
  belongs_to :partition
  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :visitor_matches, :class_name => 'Match', :foreign_key => 'visitor_team_id'
end
