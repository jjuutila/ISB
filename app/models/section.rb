# coding: utf-8
class Section < ActiveRecord::Base
  default_scope :order => 'id ASC'
  
  belongs_to :parent, :class_name => "Section"
  has_many :sections, :class_name => "Section", :foreign_key => "parent_id"
  has_and_belongs_to_many :news
  has_many :comments, :as => :commentable
  has_many :link_categories
  has_many :seasons
  
  validates_presence_of :name, :slug
  
  scope :leafs, :conditions => "parent_id > 0"
  scope :top_level, where(:parent_id => nil).includes(:sections)
  
  def self.possible_parents
    self.where(:parent_id => nil).all
  end
  
  def self.first_leaf!
    first_leaf = leafs.first
    raise ActiveRecord::RecordNotFound if first_leaf.nil?
    first_leaf
  end
  
  def self.find_leaf_by_slug slug
    Section.leafs.find_by_slug! slug
  end
  
  def to_s
    name
  end
  
  def leaf?
    !(parent_id.blank? and parent.blank?)
  end
end
