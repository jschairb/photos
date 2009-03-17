# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_photos_session',
  :secret      => '53f088e16c3f936e2cf57121a7ce88c92b233d958cb68a4d504c7045f814f2e9a3113b622bccdc96708481a8f3bfe549ae72a43aea6a2394f668f471181bb640'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
