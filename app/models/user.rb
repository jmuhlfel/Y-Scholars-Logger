class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :email, :password, :password_confirmation, :type, :child_email
  
  # Validations
  validates :type, :presence => true
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create, :length => {:minimum => 5}, :confirmation => true
  validates :password_confirmation, :presence => true
  
  def is_admin?
    self.is_a? Administrator
  end
  
  def is_tutor?
    self.is_a? Tutor
  end
  
  def is_student?
    self.is_a? Student
  end

  def to_s
    {
      :name => self.name,
      :email => self.email,
      :password => self.password,
      :id => self.id
    }
  end
  
end

