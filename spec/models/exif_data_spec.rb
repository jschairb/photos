require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExifData do 
  before(:each) do 
    @valid_attrs = { :aperture => "blah" }
  end

  it "sets instance variable data" do 
    exif = ExifData.new(@valid_attrs)
    @valid_attrs.each do |key, value|
      exif.instance_variable_get("@#{key}".intern).should == value
    end
  end

  it "does not allow anything other than ATTRIBUTES" do 
    exif = ExifData.new(@valid_attrs.merge(:foo => "bar"))
    exif.instance_variable_get(:@foo).should be_nil
  end

  describe "empty?" do 
    it "returns true if the fields are all blank" do 
      exif_data = ExifData.new({ })
      exif_data.should be_empty
    end

    it "returns false if even one field isn't blank" do 
      exif_data = ExifData.new(@valid_attrs)
      exif_data.should_not be_empty
    end
  end
end
