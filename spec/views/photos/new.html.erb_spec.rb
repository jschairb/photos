require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/new" do
  before(:each) do
    render 'photos/new'
  end
  
  it "should have a form tag" do 
    response.should have_tag('form')
  end

  it "should have a file_field" do 
    response.should have_tag("input[type=file]")
  end

  it "has a submit button" do 
    response.should have_tag('input[value=Create]')
  end
end