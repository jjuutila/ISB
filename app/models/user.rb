class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_one :section
end
