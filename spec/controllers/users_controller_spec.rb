require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  describe "GET 'new'" do
    it "should also map to /signup" do 
      params_from(:get, "/signup/123456").should == {:controller => "users", :action => "new",
                                                     :invite_token => "123456"}
    end

    it "should instantiate an @user variable" do 
      invite = mock_model(Invite, :recipient_email => "joe@example.com")
      user = mock_model(User, :new_record? => true, :invite => invite)
      User.should_receive(:new).and_return(user)
      user.should_receive(:email=)
      get 'new'
    end
    
    it "should set the invite_token" do 
      invite = mock_model(Invite, :recipient_email => "joe@example.com", :token => "123456")
      user = mock_model(User, :new_record? => true, :invite => invite, :invite_token => "123456")
      User.should_receive(:new).and_return(user)
      user.should_receive(:email=)
      get 'new', :invite_token => "123456"
      assigns[:user].invite_token.should == invite.token
    end

    it "should be successful" do
      invite = mock_model(Invite, :recipient_email => "joe@example.com", :token => "123456")
      user = mock_model(User, :new_record? => true, :invite => invite, :invite_token => "123456")
      User.should_receive(:new).and_return(user)
      user.should_receive(:email=)
      get 'new', :invite_token => "123456"
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
      @user.should_receive(:save_without_session_management).and_return(true)
      post :create, :user => @user_attrs
      response.should be_redirect
      response.should redirect_to(instructions_activations_path)
    end

    it "should render new template, if not valid" do 
      @user.should_receive(:save_without_session_management).and_return(false)
      post :create, :user => @user_attrs
      response.should render_template("users/new")
    end
  end

  describe "GET 'show'" do
    before do 
      login
    end

    it "should be successful" do
      get 'show', :id => @current_user.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    before(:each) do 
      login
    end

    it "should be successful" do
      get 'edit', :id => @current_user.id
      response.should be_success
    end

    it "should set a variable @user to @current_user" do 
      get 'edit', :id => @current_user.id
      assigns(:current_user).should == @current_user
      assigns(:user).should == assigns(:current_user)
    end
  end
end
