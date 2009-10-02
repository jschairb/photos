require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/edit" do
  before(:each) do
    login
    @current_user.should_receive(:buckets).and_return([])
    mock_errors
    @photo = mock_model(Photo, :new_record? => false, :title => "a photo", :picture_url => nil,
                               :buckets => [], :tag_list => "", :errors => @errors)
    assigns[:photo] = @photo    
    render 'photos/edit'
  end
  
  it "should have a form tag" do 
    response.should have_tag("form[action=#{photo_path(@photo)}][enctype=multipart/form-data]")
  end

  it "should have a file_field" do 
    response.should have_tag("input[type=file]")
  end

  it "has a submit button" do 
    response.should have_tag('input[value=Save]')
  end
end
