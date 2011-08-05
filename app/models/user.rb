class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :timeoutable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :first_name, :last_name
  
  belongs_to :section
  
  validates_presence_of :first_name, :last_name
  
  def to_s
    "#{first_name} #{last_name}"
  end
  
  def selected_section=(section)
    self.section = section
  end
  
  def selected_section
    self.section = Section.first if self.section.nil?
    self.section
  end
  
  protected
  
  # Overwrite password_required? to allow user creation without a password
  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
