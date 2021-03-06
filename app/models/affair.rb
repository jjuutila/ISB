# coding: utf-8
class Affair < ActiveRecord::Base
  belongs_to :member
  belongs_to :season
  
  validates_presence_of :member, :season, :role
  validates_inclusion_of :role, :in => ['player', 'assistant', 'coach', 'manager']
  validate :is_member_already_assigned, :on => :create
  
  scope :players_on_season, lambda { |id| where("season_id = ? AND role = ?", id, 'player') }
  
  def is_member_already_assigned
    number_of_matching_affairs = Affair.where(:member_id => member_id, :season_id => season_id).count
    errors.add(:unique, "Member already assigned to season.") if number_of_matching_affairs > 0
  end
end
