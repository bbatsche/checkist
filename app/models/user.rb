require 'digest'

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 50}
  
  validates :email, :presence => true,
                    :format   => { :with => email_regexp },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password, :presence => true,
                       :confirmation => true,
                       :format   => { :with => /(?:\d\D)|(?:\D\d)/ },
                       :length   => { :minimum => 5 }
  
  before_save :encrypt_password
  
  has_many :assigned_todos, :foreign_key => 'owner', :class_name => 'Todo'
  has_many :incoming_todos, :foreign_key => 'pending_owner', :class_name => 'Todo'
  
  def has_password?(submitted_password)
    password == encrypt(submitted_password)
  end
  
  private
  
  def encrypt_password
    self.password = encrypt(password)
  end
  
  def encrypt(string)
    Digest::MD5.hexdigest(string)
  end
end
