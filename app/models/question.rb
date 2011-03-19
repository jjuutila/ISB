class Question < ActiveRecord::Base
  belongs_to :member
  validates_presence_of :content, :answer
  
  def to_s
    content
  end
end
