require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activations/instructions" do
  before(:each) do
    render 'activations/instructions'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Activation Instructions")
  end
end
