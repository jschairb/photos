require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @user = mock_model(User)
    @valid_attrs = { 
      :picture => fixture_file_upload('picture.jpg', 'image/jpeg'),
      :user => @user
    }
  end

  it "creates a new instance given valid attributes" do
    Photo.create!(@valid_attrs)
  end

  it "copies the title before validation" do 
    photo = Photo.new(@valid_attrs.merge(:title => nil))
    photo.should be_valid
    photo.save.should == true
    photo.reload.title.should == "untitled photo"
  end

  describe "exif_data" do 
    before(:each) do 
      @photo = Photo.create(@valid_attrs)
    end

    it "returns an ExifData object" do 
      @photo.exif_data.should be_kind_of(ExifData)
    end
  end

  describe "set_exif_data" do 
    before(:each) do 
      @photo = Photo.new(@valid_attrs)
    end

    xit "sets after save" do 
      @photo.exif_data.should be_empty
      @photo.save.should == true
      @photo.set_exif_data.should == true
      @photo.reload.exif_data.should_not be_empty
    end
  end

end
