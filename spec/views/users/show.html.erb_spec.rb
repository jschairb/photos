require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show" do
  before(:each) do
    user = mock_model(User, :photos => [])
    assigns[:user] = user
    render 'users/show'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Your Account")
  end
end
