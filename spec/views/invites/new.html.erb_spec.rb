require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/invites/new" do
  before(:each) do
    render 'invites/new'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Invite a friend")
  end

  it "should have a form" do 
    response.should have_tag("form[action=#{invites_path}]")
  end

  it "should have a button" do 
    response.should have_tag("input[type=submit]")
  end
end
