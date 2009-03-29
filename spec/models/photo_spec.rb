require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attrs = { 
      :title => "A New Photo",
      :picture => fixture_file_upload('picture.jpg', 'image/jpeg')
    }
  end

  it "creates a new instance given valid attributes" do
    Photo.create!(@valid_attrs)
  end

  it "requires a title" do 
    photo = Photo.new(@valid_attrs.merge(:title => nil))
    photo.should_not be_valid
    photo.errors_on(:title).should include("can't be blank")
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

    it "sets after save" do 
      @photo.exif_data.should be_empty
      @photo.save.should == true
      @photo.set_exif_data.should == true
      @photo.reload.exif_data.should_not be_empty
    end

  end

end
