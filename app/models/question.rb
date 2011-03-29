class Question < ActiveRecord::Base
  belongs_to :member
  validates_presence_of :content, :answer
  
  scope :unique, select("DISTINCT(content)")
  
  def to_s
    content
  end
end
