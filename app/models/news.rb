# coding: utf-8
class News < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  
  has_and_belongs_to_many :sections
  has_many :comments, :as => :commentable
  validates_associated :sections
  validate :news_cannot_belong_to_root_section
  
  validates_presence_of :title, :content, :slug, :sections
  validates_length_of :title, :minimum => 3, :too_short => "Otsikko on liian lyhyt (vähintään kolme merkkiä)."

  scope :recent, limit(10)
  
  before_validation :update_or_create_slug
  
  def to_s
    title
  end
  
  def self.in_section(section, page)
    joins(:sections).where(:sections => {:id => section.id}).page(page).per(10)
  end

private
  def news_cannot_belong_to_root_section
    errors.add(:sections, "Cannot belong to a root level Section") unless
      sections.detect {|s| s.parent.nil?}.nil?
  end
  
  def update_or_create_slug  
    if self.new_record? || self.title_changed? || self.slug.blank? || self.slug.nil?
      self.slug = self.title.parameterize  unless self.title.nil?
    end
  end
end
