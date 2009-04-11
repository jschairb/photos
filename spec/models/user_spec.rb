require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attrs = {
      :login => "login_1",
      :email => "login@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attrs)
  end

  it "should deliver an activation instruction email on creation" do 
    AccountMaintenance.should_receive(:deliver_activation_instructions).once
    User.create!(@valid_attrs)
  end

  describe "activate!" do 
    before(:each) do 
      @user = User.create!(@valid_attrs)
    end

    it "should make an inactive user active" do 
      @user.should_not be_active
      @user.activate!
      @user.reload.should be_active
    end

    it "should generate the perishable_token" do 
      @user.should_receive(:reset_perishable_token!)
      @user.activate!
    end

    it "should deliver the activation_completion email" do 
      AccountMaintenance.should_receive(:deliver_activation_completion)
      @user.activate!
    end
  end

  describe "reset_password!" do 
    before(:each) do 
      @user = User.create!(@valid_attrs)
    end

    it "should generate a perishable token" do 
      @user.should_receive(:reset_perishable_token!)
      @user.reset_password!
    end

    it "should deliver a password_reset email" do 
      AccountMaintenance.should_receive(:deliver_password_reset_instructions)
      @user.reset_password!
    end
  end

  describe "set_invite_limit" do 
    it "should be set before_create" do 
      @user = User.new(@valid_attrs)
      @user.invite_limit.should be_nil
      @user.save!.should == true
      @user.reload.invite_limit.should == User::DEFAULT_INVITE_LIMIT
    end
  end

  describe "has_unused_invites?" do 
    it "should return true if invite_limit is > 0" do 
      @user = User.create(@valid_attrs)
      @user.has_unused_invites?.should == true
      @user.invite_limit.should > 0
    end
  end
end
