require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/password_resets/edit" do
  before(:each) do
    @user = mock_model(User, :perishable_token => "123456",
                             :password => "", :password_confirmation => "")
    assigns[:user] = @user
    render 'password_resets/edit'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Change my password")
  end

  it "should have a form" do 
    response.should have_tag("form[action=#{password_reset_path(@user.perishable_token)}]")
  end

  it "should have a submit button" do 
    response.should have_tag("input[type=submit][value=Update]")
  end
end
