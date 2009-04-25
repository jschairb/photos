require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/buckets/show" do
  before(:each) do
    @bucket = mock_model(Bucket, :photos => [], :title => "title")
    assigns[:bucket] = @bucket
    render 'buckets/show'
  end
  
  it "should have a title" do
    response.should have_tag('h1', @bucket.title)
  end
end
