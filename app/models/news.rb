# coding: utf-8
class News < ActiveRecord::Base
  has_and_belongs_to_many :sections
  has_many :comments, :as => :commentable
  
  scope :in_section, lambda {|section| joins(:sections).where(:sections => {:id => section.id}).order("created_at DESC")}
  
  def to_s
    title
  end
end
