class Todo < ActiveRecord::Base
  attr_accessible :content, :due_date, :complete
  
  validates :content, :presence => true
  
  belongs_to :creator, :foreign_key => 'creator', :class_name => 'User'
  
  belongs_to :owner,         :foreign_key => 'owner',         :class_name => 'User', :inverse_of => :assigned_todos
  belongs_to :pending_owner, :foreign_key => 'pending_owner', :class_name => 'User', :inverse_of => :incoming_todos
end
