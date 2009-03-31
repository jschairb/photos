require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  describe "GET 'new'" do 
    it "should be successful" do 
      user_session = mock_model(UserSession)
      UserSession.should_receive(:new).and_return(user_session)
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create" do 
    before(:each) do 
      @session_params = { :login => "foobar", :password => "bazbuz", :remember_me => true }
      @user_session = mock_model(UserSession)
      UserSession.should_receive(:new).and_return(@user_session)
    end

    it "should redirect if logged in" do 
      @user_session.should_receive(:save).and_return(true)
      post 'create', :user_session => @session_params
      response.should be_redirect
      response.should redirect_to(root_path)
    end

    it "should render new form if fails" do 
      @user_session.should_receive(:save).and_return(false)
      post 'create', :user_session => @session_params.merge(:password => nil)
      response.should render_template("user_sessions/new")
    end
  end
end
