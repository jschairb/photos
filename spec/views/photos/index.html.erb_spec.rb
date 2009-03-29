require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/index" do
  before(:each) do
    photo1 = mock_model(Photo, :title => "A photo")
    @photos = [photo1]
    assigns[:photos] = @photos
    render 'photos/index'
  end
  
  it "should have a list of photos" do 
    response.should have_tag("ul#photos")
  end

  it "should have a link to add a new photo" do 
    response.should have_tag("a[href=#{new_photo_path}]", "New Photo")
  end

  describe "an individual photo item" do 
    before do 
      @photo = @photos.first      
    end

    it "should have an li with the id of the photo" do 
      response.should have_tag("li#photo_#{@photo.to_param}")
    end

    it "should have a link to show the photo" do 
      response.should have_tag("a[href=#{photo_path(@photo)}]", @photo.title)
    end
  end
end
