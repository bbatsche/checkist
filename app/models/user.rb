class User < ActiveRecord::Base
  attr_accessible :name, :email, :password
  
  email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 50}
  
  validates :email, :presence => true,
                    :format   => { :with => email_regexp },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password, :presence => true,
                       :format   => { :with => /(?:\d\D)|(?:\D\d)/ },
                       :length   => { :minimum => 5 }
end
