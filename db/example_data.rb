module FixtureReplacement
  attributes_for :photo do |p|
    p.title = "A New Title"
    p.user = default_user
  end

  attributes_for :user do |u|
    u.login = String.random(5)
    u.email = String.random(5) + "@" + String.random(5) + ".com"
    u.password = "abc123"
    u.password_confirmation = "abc123"
  end

  attributes_for :invite do |i|
    i.recipient_email = "joe@example.com"
  end
end
