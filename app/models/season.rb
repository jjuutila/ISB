# coding: utf-8
class Season < ActiveRecord::Base
  default_scope :order => 'start_year DESC'

  belongs_to :section
  has_many :affairs
  has_many :members, :through => :affairs
  has_many :partitions
  
  validates_numericality_of :start_year, :only_integer => true, :greater_than_or_equal_to => 2000,
    :message => 'Virheellinen aloitusvuosi.'
  validates_presence_of :division, :start_year, :section
  
  accepts_nested_attributes_for :partitions
  
  scope :in_section, lambda {|section| includes(:partitions).where(:section_id => section.id)}
  
  before_validation :configure_default_partition
  
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

  def configure_default_partition
    if partitions.length == 1
      default_partition = partitions.first
      default_partition.season = self
      default_partition.position = 1
    end
  end
end