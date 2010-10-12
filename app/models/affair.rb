class Affair < ActiveRecord::Base
  belongs_to :member
  belongs_to :season
end
