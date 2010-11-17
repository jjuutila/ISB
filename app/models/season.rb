# coding: utf-8
class Season < ActiveRecord::Base
  belongs_to :section
  has_many :members, :through => :affairs
  has_many :partitions
  
  validates_numericality_of :start_year, :only_integer => true, :greater_than => 2000,
    :message => 'Virheellinen aloitusvuosi.'
  validates_presence_of :division, :start_year, :section
  
  accepts_nested_attributes_for :partitions
  
  def to_s
    timespan + ', ' + division
  end
  
  def timespan
    "#{start_year}-#{start_year + 1}"
  end
end
