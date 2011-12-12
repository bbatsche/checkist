class Todo < ActiveRecord::Base
  attr_accessible :content, :due_date, :complete
  
  validates :content, :presence => true
  
  belongs_to :creator, :foreign_key => 'creator', :class_name => 'User'
  
  has_one :owner, :foreign_key => 'owner', :class_name => 'User'
end
