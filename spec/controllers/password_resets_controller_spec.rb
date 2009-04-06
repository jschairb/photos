require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do

  before(:each) do 
    @user = mock_model(User, :email => "joe@example.com", :perishable_token => "1234567")
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do 

    it "should redirect if successful" do 
      User.should_receive(:find_by_email).and_return(@user)
      @user.should_receive(:reset_password!)
      post :create, :email => @user.email
      response.should be_redirect
      response.should redirect_to(new_user_session_path)
    end

    it "should render if unsuccessful" do 
      User.should_receive(:find_by_email).and_return(nil)
      @user.should_not_receive(:reset_password!)
      post :create, :email => nil
      response.should render_template("password_resets/new")
    end

  end

  describe "GET 'edit'" do
    it "should be successful" do
      User.should_receive(:find_using_perishable_token).and_return(@user)
      get 'edit', :id => @user.perishable_token
      response.should be_success
    end

    it "should redirect if no user found" do
      User.should_receive(:find_using_perishable_token).and_return(nil)
      get 'edit', :id => "foo"
      response.should be_redirect
      response.should redirect_to(new_password_reset_path)
    end
  end

  describe "POST 'update'" do 
    it "should redirect if successful" do 
      User.should_receive(:find_using_perishable_token).and_return(@user)
      @user.should_receive(:save).and_return(true)
      @user.stub!(:password=)
      @user.stub!(:password_confirmation=)
      put :update, :id => @user.perishable_token, 
                   :user => { :password => "foobar1", 
                              :password_confirmation => "foobar1"}
      assigns(:user).should_not be_nil
      response.should be_redirect
      response.should redirect_to(account_path)
    end

    it "should render if could not be saved" do 
      User.should_receive(:find_using_perishable_token).and_return(@user)
      @user.should_receive(:save).and_return(false)
      @user.stub!(:password=)
      @user.stub!(:password_confirmation=)
      put :update, :id => "foo", 
                   :user => { :password => nil, 
                              :password_confirmation => nil}
      assigns(:user).should_not be_nil
      response.should render_template("password_resets/edit")
    end

    it "should render if unsuccessful" do 
      User.should_receive(:find_using_perishable_token).and_return(nil)
      put :update, :id => "foo", 
                   :user => { :password => "foobar1", 
                              :password_confirmation => "foobar1"}
      assigns(:user).should be_nil
      response.should render_template("password_resets/edit")
    end
  end
end
