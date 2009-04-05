require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :login => "login_1",
      :email => "login@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  describe "activate!" do 
    it "makes an inactive user active" do 
      user = User.create!(@valid_attributes)
      user.should_not be_active
      user.activate!
      user.reload.should be_active
    end
  end
end
