# coding: utf-8
class Affair < ActiveRecord::Base
  belongs_to :member
  belongs_to :season
  
  validates_presence_of :member, :season, :role
  validates_inclusion_of :role, :in => ['player', 'assistant']
end
