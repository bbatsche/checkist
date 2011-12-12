require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    describe "success" do
      it "returns http success" do
        get :new
        response.should be_success
      end
    
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Sign up")
      end
    end
    
    describe "failure" do
      before(:each) do
        tempUser = {:name => "John Doe", :email => "jdoe@example.com", :password => 'john1'}
        user = User.create!(tempUser)
        authAttr = {:email => "jdoe@example.com", :password => "john1"}
        post :create, :session => authAttr
      end
      
      it "should disallow signed in users from creating a new user" do
        get :new
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "POST 'create'" do
    describe "success" do
      before(:each) do
        @attr = {:name => "John Doe", :email => "jdoe@example.com", :password => "john1", :confirm => "john1"}
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the root path" do
        post :create, :user => @attr
        response.should redirect_to(root_path)
      end
    end
    
    describe "failure" do
      before(:each) do
        tempUser = {:name => "John Doe", :email => "jdoe@example.com", :password => 'john1'}
        user = User.create!(tempUser)
        authAttr = {:email => "jdoe@example.com", :password => "john1"}
        post :create, :session => authAttr
        @attr = {:name => "Jane Smith", :email => "jsmith@example.com", :password => "jane1", :confirm => "jane1"}
      end
      
      it "should disallow signed in users from creating a new user" do
        lamda do
          post :create, :user => @attr
        end.should change(User, :count).by(0)
      end
      
      it "should redirect to the root path" do
        post :create, :user => @attr
        response.should redirect_to(root_path)
      end
    end
  end
end
