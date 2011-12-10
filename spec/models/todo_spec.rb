require 'spec_helper'

describe Todo do
  before (:each) do
    @creator_user = User.create!({ :name => 'John Doe', :email => 'jdoe@cs.utsa.edu', :password => 'john1' })
    @attr = { :content => 'Todo item' }
  end
  
  it "should create a todo with valid content" do
    @creator_user.assigned_todos.create(@attr)
  end
  
  it "should require content" do
    no_content_todo = @creator_user.assigned_todos.create(@attr.merge(:content => ''))
    no_content_todo.should_not be_valid
  end
end
