require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PicturesController do

  before(:each) do 
    login
    @photos = mock("Photos")
    @picture = fixture_file_upload("picture.jpg")
    @current_user.stub!(:photos).and_return(@photos)
    @photo = mock_model(Photo, :title => 'A new title', 
                               :picture => @picture, 
                               :picture_content_type => "bar")
    @photos.should_receive(:find).and_return(@photo)
  end

  describe "GET 'show'" do 
    xit "should be successful" do 
      # FIXME: mock path(:style) properly
      get 'show', :id => @photo.id, :style => "original"
      response.should be_success
    end
  end

end
