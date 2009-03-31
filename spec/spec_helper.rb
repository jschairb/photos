ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  include ActionController::TestProcess
  include Authlogic::TestCase
end

def current_user(stubs = {})
  @current_user ||= mock_model(User, stubs)
end
 
def user_session(stubs = {}, user_stubs = {})
  @current_user ||= mock_model(UserSession, {:user => current_user(user_stubs)}.merge(stubs))
end
 
def login(session_stubs = {}, user_stubs = {})
  UserSession.stub!(:find).and_return(user_session(session_stubs, user_stubs))
end
 
def logout
  @user_session = nil
end
