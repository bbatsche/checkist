class Todo < ActiveRecord::Base
  attr_accessible :content, :due_date
  
  validates :content, :presence => true
  
  belongs_to :creator, :foreign_key => 'creator', :class_name => 'User'
end
