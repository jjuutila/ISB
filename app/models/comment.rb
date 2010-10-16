# coding: utf-8
class Comment < ActiveRecord::Base
  
  cattr_reader :per_page
  @@per_page = 10
  
  attr_accessible :title, :content, :author, :email, :commentable_id
  
  validates_length_of :title, :in => 2..50, :too_long => "Liian pitkä otsikko.",
    :too_short => "Liian lyhyt otsikko."
    
  validates_length_of :content, :in => 5..160, :too_long => "Liian pitkä viesti.",
    :too_short => "Liian lyhyt viesti."
    
  validates_length_of :author, :in => 1..40, :too_long => "Liian pitkä nimimerkki.",
    :too_short => "Anna nimimerkki."
    
  validates_format_of :email, :allow_blank => true, :message => 'Epäkelpo sähköpostiosoite',
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  # Just for first state when comments acts as guestbook
  validates_inclusion_of :commentable_id, :in => Section.all.collect(&:id),
    :message => "Valitse joukkueosio."
  
  belongs_to :commentable, :polymorphic => true
  before_create :set_type
  
  scope :section, where(:commentable_type => "Section")
  
  def correct?
    state == "correct"
  end
    
  protected
  
  
  def set_type
    self.state = "correct"
    # Just for first state when comments acts as guestbook
    self.commentable_type = "Section"
  end
  
end
