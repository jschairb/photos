require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  describe "GET 'new'" do
    it "should instantiate an @user variable" do 
      user = mock_model(User, :new_record? => true)
      User.should_receive(:new).and_return(user)
      get 'new'
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do 
    before(:each) do 
      @user = mock_model(User)
      User.should_receive(:new).and_return(@user)
      @user_attrs = { :login => "foobar", :email => "foobar@example.com",
                      :password => "foobar", :password_confirmation => "foobar" }
    end

    it "should save a User and redirect, if valid" do 
      @user.should_receive(:save).and_return(true)
      post :create, :user => @user_attrs
      response.should be_redirect
      response.should redirect_to(user_path(@user))
    end

    it "should render new template, if not valid" do 
      @user.should_receive(:save).and_return(false)
      post :create, :user => @user_attrs
      response.should render_template("users/new")
    end
  end

  describe "GET 'show'" do
    before do 
      login
    end

    it "should be successful" do
      # FIXME: should just be @current_user, problem w/ spec_helper methods
      get 'show', :id => @current_user.user.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    before(:each) do 
      login
    end

    it "should be successful" do
      get 'edit', :id => @current_user.user.id
      response.should be_success
    end

    it "should set a variable @user to @current_user" do 
      get 'edit', :id => @current_user.user.id
      assigns(:current_user).should == @current_user.user
      assigns(:user).should == assigns(:current_user)
    end
  end
end
