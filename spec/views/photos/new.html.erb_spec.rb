require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/new" do
  before(:each) do
    @photo = mock_model(Photo, :new_record? => true, 
                               :title => nil,
                               :tag_list => "", 
                               :picture_url => "")
    assigns[:photo] = @photo
    render 'photos/new'
  end
  
  it "should have a form tag" do 
    response.should have_tag("form[action=#{photos_path}][enctype=multipart/form-data]")
  end

  it "should have a file_field" do 
    response.should have_tag("input[type=file]")
  end

  it "has a submit button" do 
    response.should have_tag('input[value=Create]')
  end
end
