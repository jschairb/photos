require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new" do
  before(:each) do
    mock_errors
    @user = mock_model(User, :new_record? => true, :login => "", :password => "", :email => "",
                             :password_confirmation => "", :invite_token => "123456", :errors => @errors)
    assigns[:user] = @user
    render 'users/new'
  end
  
  it "should have a form to submit" do
    response.should have_tag("form[action=#{users_path}]")
  end

  it "should have a login field" do 
    response.should have_tag("input#user_login[type=text]")
  end

  it "should have a email field" do 
    response.should have_tag("input#user_email[type=text]")
  end

  it "should have a password field" do 
    response.should have_tag("input#user_password[type=password]")
  end

  it "should have a password_confirmation field" do 
    response.should have_tag("input#user_password_confirmation[type=password]")
  end

  it "should have a submit button" do 
    response.should have_tag("input[type=submit][value=Create]")
  end
  
end
