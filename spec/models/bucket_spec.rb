require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bucket do
  before(:each) do
    @user = mock_model(User)
    @valid_attrs = {
      :user => @user
    }
  end

  it "should create a new instance given valid attributes" do
    Bucket.create!(@valid_attrs)
  end

  it "copies the title before validation" do 
    bucket = Bucket.new(@valid_attrs.merge(:title => nil))
    bucket.should be_valid
    bucket.save.should == true
    bucket.reload.title.should == "untitled bucket"
  end

end
