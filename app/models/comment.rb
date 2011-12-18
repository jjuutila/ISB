# coding: utf-8
class Comment < ActiveRecord::Base
  HONEYPOT_SECRET = 'tasty honey'

  attr_accessor :honeypot
  attr_accessible :honeypot
  
  default_scope :order => 'created_at DESC'
  
  attr_accessible :title, :content, :author, :email
  
  validates_presence_of :commentable
  
  validates_length_of :title, :maximum => 60, :too_long => "Liian pitkä otsikko.",
    :too_short => "Liian lyhyt otsikko."
    
  validates_length_of :content, :minimum => 2, :too_short => "Liian lyhyt viesti."
    
  validates_length_of :author, :in => 1..40, :too_long => "Liian pitkä nimimerkki.",
    :too_short => "Anna nimimerkki."
  
  validates_length_of :email, :maximum => 256, :message => 'Virheellinen sähköpostiosoite.'
    
  validates_format_of :email, :allow_blank => true, :message => 'Virheellinen sähköpostiosoite.',
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  validate :honeypot_check, :on => :create 
  
  belongs_to :commentable, :polymorphic => true
  before_create :set_type
  
  def self.messages(section, page)
    Comment.where(['commentable_type = (?) AND commentable_id = (?)', "Section", section.id]).page(page).per(10)
  end
  
  def to_s
    title
  end
  
  protected
  
  def set_type
    # Just for first state when comments acts as guestbook
    self.commentable_type = "Section"
  end
  
  def honeypot_check
    unless honeypot == HONEYPOT_SECRET
      errors.add :honeypot, 'Honeypot check failed, are you a spam bot?.'
    end
  end
end
