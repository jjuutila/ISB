class Link < ActiveRecord::Base
  belongs_to :category, :class_name => 'LinkCategory'
  validates_presence_of :category, :name, :url
  
  def to_s
    name
  end
end
