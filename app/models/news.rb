# coding: utf-8
class News < ActiveRecord::Base
  has_and_belongs_to_many :section
  has_many :comments, :as => :commentable
  
  def to_s
    title
  end
end
