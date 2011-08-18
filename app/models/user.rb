class User < ActiveRecord::Base
  has_secure_password
  
  attr_protected :last_login
  
  validates :password, 
    :length => { :minimum => 3 },
    :unless => Proc.new { |m| m.password.blank? }
    
  validates :password,
    :presence => true,
    :on => :create
  
  validates :name,
    :presence => true
    
  validates :email,
    :presence => true,
    :uniqueness => { :case_sensitive => false },
    :email_format => true
  
  def authenticate(*args, &block)
    self.update_attribute :last_login, Time.now
    super(*args, &block)
  end
end
