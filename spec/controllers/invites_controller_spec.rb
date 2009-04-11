require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitesController do

  before(:each) do 
    login
    @invites = mock("invites")
    @current_user.stub!(:sent_invites).and_return(@invites)
  end

  describe "GET 'new'" do
    before(:each) do 
      @invites.stub!(:build).and_return(mock_model(Invite))
    end
    
    it "should instantiate a new invite for the user" do 
      get 'new'
      assigns(:invite).should_not be_nil
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do 
    before(:each) do 
      @invite = mock_model(Invite)
      @invites.stub!(:build).and_return(@invite)
    end

    it "should redirect on success" do 
      @invite.should_receive(:save).and_return(true)
      post :create, :invite => { }
      response.should be_redirect
      response.should redirect_to(user_path(@current_user))
    end

    it "should render new if failure" do 
      @invite.should_receive(:save).and_return(false)
      post :create, :invite => { }
      response.should render_template("invites/new")
    end
  end
end
