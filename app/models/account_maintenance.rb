class AccountMaintenance < ActionMailer::Base
  default_url_options[:host] = "photos.local"

  def welcome_invite(invite)
    subject "You have been invited to Kippler"
    recipients invite.recipient_email
    from 'Kippler Central <noreply@kipplerapp.com'
    
    body :signup_url => signup_url(invite.token)
    invite.update_attribute(:sent_at, Time.now)
  end

  def activation_instructions(user)
    subject    'Kippler Account Activation Instructions'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    
    body       :account_activation_url => register_url(user.perishable_token)
  end

  def activation_completion(user)
    subject    'Welcome to Kippler'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    
    body       :root_url => root_url
  end

  def password_reset_instructions(user)
    subject    'Kippler Password Reset Instructions'
    recipients user.email
    from       'Kippler Central <noreply@kipplerapp.com>'
    
    body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
