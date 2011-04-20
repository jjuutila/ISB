class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  belongs_to :section
  
  validates_presence_of :first_name, :last_name
  
  def to_s
    "#{first_name} #{last_name}"
  end
end
