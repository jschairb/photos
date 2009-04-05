require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do

  describe "GET 'new'" do
    before(:each) do 
      @user = mock_model(User, :perishable_token => "foo")
    end

    it "should find a user by perishable token" do 
      User.should_receive(:find_using_perishable_token).exactly(:once).and_return(@user)
      get 'new', :activation_code => @user.perishable_token
      assigns(:user).should_not be_nil
    end

    it "should be successful" do
      get 'new', :activation_code => @user.perishable_token
      response.should be_success
    end
  end

  describe "POST 'create'" do 
    before(:each) do 
      @user = mock_model(User, :active? => false)
      User.should_receive(:find).and_return(@user)
    end

    it "should redirect on success" do 
      @user.should_receive(:activate!).and_return(true)
      post :create, :id => @user
      response.should be_redirect
      response.should redirect_to(account_path)
    end

    it "should render new if failure" do 
      @user.should_receive(:activate!).and_return(false)
      post :create, :id => @user
      response.should render_template("activations/new")
    end
  end

  describe "GET 'instructions'" do 
    it "should be successful" do 
      get 'instructions'
      response.should be_success
    end
  end

end
