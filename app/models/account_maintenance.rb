class AccountMaintenance < ActionMailer::Base
  default_url_options[:host] = "photos.local"

  def welcome_invite(invite)
    subject "You have been invited to Betafeed"
    recipients invite.recipient_email
    from 'Betafeed Central <noreply@betafeed.com'
    
    body :signup_url => signup_url(invite.token)
    invite.update_attribute(:sent_at, Time.now)
  end

  def activation_instructions(user)
    subject    'Betafeed Account Activation Instructions'
    recipients user.email
    from       'Betafeed Central <noreply@betafeed.com>'
    
    body       :account_activation_url => register_url(user.perishable_token)
  end

  def activation_completion(user)
    subject    'Welcome to Betafeed'
    recipients user.email
    from       'Betafeed Central <noreply@betafeed.com>'
    
    body       :root_url => root_url
  end

  def password_reset_instructions(user)
    subject    'Betafeed Password Reset Instructions'
    recipients user.email
    from       'Betafeed Central <noreply@betafeed.com>'
    
    body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
