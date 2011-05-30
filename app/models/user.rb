class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :timeoutable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  belongs_to :section
  
  validates_presence_of :first_name, :last_name
  validate :section_must_be_leaf, :unless => Proc.new { |u| u.section.nil? }
  
  def to_s
    "#{first_name} #{last_name}"
  end
  
  def selected_section=(section)
    self.section = section
  end
  
  def selected_section
    self.section = Section.first_leaf! if self.section.nil?
    self.section
  end
  
  def section_must_be_leaf
    errors.add(:section, "Section must be a leaf section.") unless section.leaf?
  end
  
  protected
  
  # Overwrite password_required? to allow user creation without a password
  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
