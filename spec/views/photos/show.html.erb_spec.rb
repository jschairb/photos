require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/show" do
  before(:each) do
    @photo = mock_model(Photo, :title => "A Photo")
    assigns[:photo] = @photo
    render 'photos/show'
  end
  
  it "should have a title" do
    response.should have_tag('h1', @photo.title)
  end

  it "should have a link to the text" do 
    response.should have_tag("a[href=#{photos_path}]")
  end
end
