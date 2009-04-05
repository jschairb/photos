class AccountMaintenance < ActionMailer::Base
  

  def activation_instructions(sent_at = Time.now)
    subject    'AccountMaintenance#activation_instructions'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

  def activation_completion(sent_at = Time.now)
    subject    'AccountMaintenance#activation_completion'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
