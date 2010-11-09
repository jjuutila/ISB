# coding: utf-8
class Season < ActiveRecord::Base
  belongs_to :section
  has_many :member, :through => :affairs
  
  validates_numericality_of :start_year, :only_integer => true, :greater_than => 2000, :message => 'kebabpizza'
  validates_presence_of :division
  
  def to_s
    timespan + ', ' + division
  end
  
  def timespan
    "#{start_year}-#{start_year + 1}"
  end
end
