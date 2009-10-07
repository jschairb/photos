module FixtureReplacement
  attributes_for :bucket do |b|
    b.title = "A new bucket"
    b.user = default_user
  end

  attributes_for :invite do |i|
    i.sender = default_user
    i.recipient_email = Faker::Internet.email
    i.sent_at = Time.now
  end

  attributes_for :photo do |p|
    p.title = "A New Title"
    p.user = default_user
  end

  attributes_for :user do |u|
    u.login = String.random(5)
    u.email = String.random(5) + "@" + String.random(5) + ".com"
    u.password = "abc123"
    u.password_confirmation = "abc123"
    u.invite = default_invite
  end

  attributes_for :invite do |i|
    i.recipient_email = "joe@example.com"
  end
end
