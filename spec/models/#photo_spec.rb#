require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attrs = { :title => "A New Photo" }
  end

  it "creates a new instance given valid attributes" do
    Photo.create!(@valid_attrs)
  end

  it "requires a title" do 
    photo = Photo.new(@valid_attrs.merge(:title => nil))
    photo.should_not be_valid
    photo.errors_on(:title).should include("can't be blank")
  end
end
