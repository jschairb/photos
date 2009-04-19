RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  config.gem 'authlogic', :version => '2.0.5', :source => "http://gems.rubyforge.org"
  config.gem "thoughtbot-factory_girl", :lib => "factory_girl",
                                        :source => "http://gems.github.com"
  config.gem 'faker', :version => "0.3.1", :source => "http://gems.rubyforge.org"
  config.gem 'mms2r', :version => "2.2.0", :source => "http://gems.rubyforge.org"
  config.gem 'thoughtbot-paperclip', :version => '2.2.7', 
                                     :lib => 'paperclip', :source => "http://gems.github.com"
  config.gem 'rmagick', :version => '2.9.1'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  config.frameworks -= [ :active_resource ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

# ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "<span class=\"fieldWithErrors\">#{html_tag}</span>" }
