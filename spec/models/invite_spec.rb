require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invite do
  before(:each) do
    @sender = mock_model(User, :has_unused_invites? => true, :decrement! => true)
    @valid_attrs = {
      :sender => @sender,
      :recipient_email => "value for recipient_email",
      :sent_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Invite.create!(@valid_attrs)
  end

  describe "validations" do 
    it "should require the presence of a recipient_email" do 
      invite = Invite.new(@valid_attrs.merge(:recipient_email => nil))
      invite.valid?.should == false
      invite.errors_on(:recipient_email).should_not be_empty
    end

    it "should require that an invite should not be accepted" do 
      User.should_receive(:find_by_email).at_least(:once).and_return(mock_model(User))
      invite = Invite.new(@valid_attrs)
      invite.valid?.should == false
      invite.errors_on(:recipient_email).should_not be_empty
    end

    it "should require that a user has at least 1 unsent invite" do 
      @sender.stub!(:has_unused_invites?).and_return(false)
      invite = Invite.new(@valid_attrs)
      invite.valid?.should == false
      invite.errors.on(:base).should include("You have reached your limit of invites.")
    end
  end

  describe "has_been_accepted?" do 
    it "should return true if a user has the same email as the recipient" do 
      User.should_receive(:find_by_email).at_least(:once).and_return(mock_model(User))
      invite = Invite.create(@valid_attrs)
      invite.has_been_accepted?.should == true
    end
  end

  describe "decrement_sender_invite_limit" do 
    it "should fire after create" do 
      @sender.should_receive(:decrement!).and_return(true)
      Invite.create!(@valid_attrs)
    end
  end

  describe "generate_token" do 
    it "should generate before create" do 
      invite = Invite.new(@valid_attrs)
      invite.token.should be_blank
      invite.save.should == true
      invite.reload.token.should_not be_blank
    end

    it "should generate a token using the SHA1 hexdigest" do 
      Digest::SHA1.should_receive(:hexdigest).and_return("1234567")
      invite = Invite.create!(@valid_attrs)
      invite.reload.token.should == "1234567"
    end
  end

  describe "notify_recipient" do 
    it "should notify after create" do 
      AccountMaintenance.should_receive(:deliver_welcome_invite)
      invite = Invite.create(@valid_attrs)
    end
  end
end
