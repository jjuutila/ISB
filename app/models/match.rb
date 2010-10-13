# coding: utf-8
class Match < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'TeamStanding'
  belongs_to :visitor_team, :class_name => 'TeamStanding'
  belongs_to :partition
  
  validates_associated :visitor_team, :home_team, :partition
  validates_presence_of :visitor_team, :home_team, :partition
end
