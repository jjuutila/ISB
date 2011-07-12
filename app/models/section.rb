# coding: utf-8
class Section < ActiveRecord::Base
  default_scope :order => 'id ASC'
  
  belongs_to :group, :class_name => 'SectionGroup', :foreign_key => :section_group_id
  has_and_belongs_to_many :news
  has_many :comments, :as => :commentable
  has_many :link_categories
  has_many :seasons
  
  validates_presence_of :name, :slug, :group
  validates_inclusion_of :is_visible, :in => [true, false]
  
  scope :visible, where(:is_visible => true)
  
  def to_s
    name
  end
end
