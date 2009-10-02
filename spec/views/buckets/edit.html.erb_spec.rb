require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/buckets/edit" do
  before(:each) do
    mock_errors
    @bucket = mock_model(Bucket, :new_record? => false, :title => "a bucket", :picture_url => nil,
                               :tag_list => "", :errors => @errors)
    assigns[:bucket] = @bucket    
    render 'buckets/edit'
  end
  
  it "should have a form tag" do 
    response.should have_tag("form[action=#{bucket_path(@bucket)}]")
  end

  it "has a submit button" do 
    response.should have_tag('input[value=Save]')
  end

end
