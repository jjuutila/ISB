# coding: utf-8
class News < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope :order => 'created_at DESC'
  
  has_and_belongs_to_many :sections
  has_many :comments, :as => :commentable
  validates_associated :sections
  
  validates_presence_of :title, :content, :slug, :sections
  validates_length_of :title, :minimum => 3, :too_short => "Otsikko on liian lyhyt (vähintään kolme merkkiä)."

  scope :recent, includes(:sections).limit(10)
  
  def to_s
    title
  end
  
  def self.in_section(section, page)
    joins(:sections).where(:sections => {:id => section.id}).page(page).per(10)
  end
end
