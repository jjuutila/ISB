# coding: utf-8
class Section < ActiveRecord::Base
  belongs_to :parent, :class_name => "Section"
  has_many :sections, :class_name => "Section", :foreign_key => "parent_id"
  has_and_belongs_to_many :news
  has_many :comments, :as => :commentable
  
  scope :leafs, :conditions => "parent_id > 0"
  
  def self.possible_parents
    self.where(:parent_id => nil).all
  end
  
  def to_s
    name
  end
end
