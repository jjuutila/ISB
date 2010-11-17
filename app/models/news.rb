# coding: utf-8
class News < ActiveRecord::Base
  has_and_belongs_to_many :sections
  has_many :comments, :as => :commentable
  
  validates_presence_of :title, :content, :slug
  
  scope :in_section, lambda {|section| joins(:sections).where(:sections => {:id => section.id}).order("created_at DESC")}
  
  before_validation :update_or_create_slug
  
  def to_s
    title
  end

private
  
  def update_or_create_slug  
    if self.new_record? || self.title_changed? || self.slug.blank? || self.slug.nil?
      self.slug = self.title.parameterize  unless self.title.nil?
    end
  end
  
end
