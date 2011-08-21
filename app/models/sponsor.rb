# coding: utf-8

class Sponsor < ActiveRecord::Base
  acts_as_list
  
  has_attached_file :logo, :styles => { :normal => "190x190>" }
  validates_presence_of :name, :position
  
  validates_numericality_of :position, :greater_than_or_equal_to => 0
  validates_uniqueness_of :position
  
  validates_attachment_presence :logo
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_size :logo, :less_than => 2.megabytes
  
  after_post_process :save_logo_dimensions
  
  validates_format_of :url, :with =>
    /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix,
    :message => "Epäkelpo osoite.",
    :allow_blank => true
    
  before_validation :set_to_last_position, :if => Proc.new { |s| s.position.nil? and s.new_record? }
  
  default_scope :order => 'position ASC'
  
  def set_to_last_position
    if Sponsor.last
      self.position = Sponsor.last.position + 1
    else
      self.position = 1
    end
  end
  
  def to_s
    name
  end

  def save_logo_dimensions
    if valid? then
      geo = Paperclip::Geometry.from_file(logo.queued_for_write[:normal])
      self.logo_width = geo.width
      self.logo_height = geo.height
    end
  end
  
  def logo_dimensions
    "#{logo_width}x#{logo_height}"
  end
  
  def self.set_positions(sponsor_ids)
    raise ArgumentError.new('sponsor_ids can only be given in an array') unless sponsor_ids.is_a? Array

    sponsors = self.all
    position = 1
    self.transaction do
      sponsor_ids.each do |sponsor_id|
        found_sponsor = sponsors.find {|s| s.id == sponsor_id.to_i}
        
        if found_sponsor then
          found_sponsor.insert_at position
          sponsors.delete(found_sponsor)
          position = position + 1
        end
      end
    end
  end
end
