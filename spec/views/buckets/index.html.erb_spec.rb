require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/buckets/index" do
  before(:each) do
    @buckets = []
    assigns[:buckets] = @buckets
    render 'buckets/index'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Buckets")
  end
end
