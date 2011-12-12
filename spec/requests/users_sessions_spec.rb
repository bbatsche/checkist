require 'spec_helper'

describe "UsersSessions" do
  before(:each) do
    tempUser = {:name => "John Doe", :email => "jdoe@example.com", :password => 'john1'}
    user = User.create!(tempUser)
    authAttr = {:email => "jdoe@example.com", :password => "john1"}
    post sessions_path, :session => authAttr
    @attr = {:name => "Jane Smith", :email => "jsmith@example.com", :password => "jane1", :confirm => "jane1"}
  end
  
  describe "GET /users/new as auth user" do
    it "should disallow signed in users from trying to create a new user" do
      get signup_path
      response.should redirect_to(root_path)
    end
  end
  
  describe "POST /users as auth user" do
    it "should disallow signed in users from creating a new user" do
      lambda do
        post users_path, :user => @attr
      end.should change(User, :count).by(0)
    end
    
    it "should redirect to the root path" do
      post users_path, :user => @attr
      response.should redirect_to(root_path)
    end
  end
end
