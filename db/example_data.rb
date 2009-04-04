module FixtureReplacement
  attributes_for :photo do |p|
    p.title = "A New Title"
    p.user = default_user
  end

  attributes_for :user do |u|
    u.login = String.random(5)
    u.email = String.random(5) + "@" + String.random(5) + ".com"
  end
end
