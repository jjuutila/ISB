# coding: utf-8
class Member < ActiveRecord::Base
  UNASSIGNED = 0
  ATTACKER = 1
  DEFENDER = 2
  GOALIE = 3
  
  has_attached_file :photo, :styles => { :normal => "300x400>" }
  
  has_many :affairs
  has_many :seasons, :through => :affairs
  has_many :statistics
  has_many :questions
  
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
    :message => "Syntymävuosi tulee olla väliltä 1900-#{DateTime::now().year()}"
    
  validates_numericality_of :position, :only_integer => true, :less_than_or_equal_to => GOALIE,
    :greater_than_or_equal_to => UNASSIGNED, :message => "Epäkelpo pelipaikka."

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  after_initialize :set_defaults
  
  accepts_nested_attributes_for :questions, :allow_destroy => true
  
  scope :in_season, lambda { |season| joins(:affairs).where(:affairs => {:season_id => season.id}).order("last_name ASC") }
  scope :not_in_season, lambda { |season| joins("LEFT JOIN affairs ON affairs.member_id = members.id AND affairs.season_id = #{season.id}").where(:affairs => {:member_id => nil}).order("last_name DESC") }
  scope :with_role, lambda { |role| joins(:affairs).where(:affairs => {:role => role})}  
  
  def self.players_with_points_in_any_season
    # In PostreSQL all selected columns (except aggregated ones) must appear in the group-by clause.
    Member.group(self.col_list).joins(:affairs).
      where("affairs.role = 'player' AND (all_time_goals + all_time_assists > 0)").
      order("all_time_goals + all_time_assists DESC, all_time_goals DESC")
  end
  
  def self.with_role_in_season(role, season)
    with_role(role).in_season(season)
  end
  
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
  
  # Creates a comma separeted list of columns in 'members' table
  def self.col_list
    Member.column_names.collect {|c| "members.#{c}"}.join(",")
  end
end
