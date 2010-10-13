# coding: utf-8
class Member < ActiveRecord::Base
  has_many :seasons, :through => :affairs
end
