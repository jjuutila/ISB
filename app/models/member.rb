class Member < ActiveRecord::Base
  has_many :seasons, :through => :affairs
end
