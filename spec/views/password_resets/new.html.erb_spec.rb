require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_resets/new" do
  before(:each) do
    render 'password_resets/new'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Reset your password")
  end

  it "should have a form" do 
    response.should have_tag("form[action=#{password_resets_path}]")
  end

  it "should have a field for email address" do 
    response.should have_tag("input[type=text][name=email]")
  end

  it "should have a submit button" do 
    response.should have_tag("input[type=submit]")
  end
end
