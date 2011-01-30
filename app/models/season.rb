# coding: utf-8
class Season < ActiveRecord::Base
  default_scope :order => 'start_year DESC'

  belongs_to :section
  has_many :members, :through => :affairs
  has_many :partitions
  
  validates_numericality_of :start_year, :only_integer => true, :greater_than => 2000,
    :message => 'Virheellinen aloitusvuosi.'
  validates_presence_of :division, :start_year, :section
  
  accepts_nested_attributes_for :partitions
  
  scope :in_section, lambda {|section| includes(:partitions).where(:section_id => section.id)}
  
  # Gets the latest season in section
  def self.latest(section)
    latest_season = Season.where("section_id = ?", section.id).order('start_year DESC').first
    raise ActiveRecord::RecordNotFound if latest_season.nil?
    latest_season
  end
  
  def to_s
    timespan + ', ' + division
  end
  
  def timespan
    "#{start_year}-#{start_year + 1}"
  end
end
