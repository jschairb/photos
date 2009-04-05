require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activations/new" do
  before(:each) do
    @user = mock_model(User, :perishable_token => "foobarbah")
    assigns[:user] = @user
    render 'activations/new'
  end
  
  it "should have a title" do
    response.should have_tag('h1', "Activate your account")
  end

  it "should have a form to activate" do 
    response.should have_tag("form[action=#{activate_path(@user.id)}][method=post]")
  end

  it "should have an input to submit" do 
    response.should have_tag("input[type=submit][value=Activate]")
  end
end
