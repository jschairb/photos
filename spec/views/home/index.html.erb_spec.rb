require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index" do
  before(:each) do
    render 'home/index'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Welcome")
  end
end
