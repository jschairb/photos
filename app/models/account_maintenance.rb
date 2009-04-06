class AccountMaintenance < ActionMailer::Base
  default_url_options[:host] = "photos.local"

  def activation_instructions(user)
    subject    'Kippler Account Activation Instructions'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    sent_on    Time.now
    
    body       :account_activation_url => register_url(user.perishable_token)
  end

  def activation_completion(user)
    subject    'Welcome to Kippler'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    sent_on    Time.now
    
    body       :root_url => root_url
  end

  def password_reset_instructions(user)
    subject    'Kippler Password Reset Instructions'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    sent_on    Time.now
    
    body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
