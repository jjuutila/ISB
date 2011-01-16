# coding: utf-8
class Member < ActiveRecord::Base
  has_many :affairs
  has_many :seasons, :through => :affairs
  has_many :statistics
  
  validates_presence_of :first_name, :last_name, :number
  
  validates_inclusion_of :gender, :in => [true, false]
  
  validates_numericality_of :number, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99,
    :message => 'Numero tulee olla väliltä 0-99.'
    
  validates_numericality_of :all_time_assists, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999,
    :message => 'Syötöt tulee olla väliltä 0-99.'
    
  validates_numericality_of :all_time_goals, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 999,
    :message => 'Maalit tulee olla väliltä 0-99.'
  
  validates_numericality_of :birth_year, :greater_than_or_equal_to => 1900,
    :less_than_or_equal_to => DateTime::now().year(),
    :message => "Syntymävuosi tulee olla väliltä 1900-.#{DateTime::now().year()}"
  
  after_initialize :set_defaults
  
  def all_time_points
    2 * all_time_goals + all_time_assists
  end
  
  def to_s
    first_name + ' ' + last_name
  end
  
  protected
  
  def set_defaults
    self.all_time_assists = 0 unless self.all_time_assists
    self.all_time_goals = 0 unless self.all_time_goals
  end 
end
