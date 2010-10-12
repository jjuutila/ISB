class Partition < ActiveRecord::Base
  belongs_to :season
  has_many :team_standings
  has_many :matches
end
