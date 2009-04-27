require File.dirname(__FILE__) + '/../../config/environment'
$LOAD_PATH << File.dirname(__FILE__) + '/../../vendor/plugins/fixture_replacement/lib'
#require "fixture_replacement"
#include FixtureReplacement

desc "Deletes all the picture files"
task :clear_pictures do 
  sh "rm -fR #{RAILS_ROOT}/data/pictures"
end

namespace :db do 
  
  desc "Generates fake data"
  task :seed_data do
    
    create_user( :login => "jschairb", 
                 :email => "joshua.schairbaum+kippler@gmail.com", 
                 :password => "kippler1", 
                 :password_confirmation => "kippler1",
                 :active => true,
                 :invite_id => 1)

    # login data instruction
    puts "\n**************\nThe following accounts are available for use:\n\n" 
    puts '  jschairb (password: kippler1)'
    puts "\n**************\n" 
  end

  desc "Regenerate db from migrations, clone structure to test env, and reload dev fixtures"
  task :do_over => ['db:migrate:reset', 'clear_pictures', 'db:seed_data', 'db:test:clone_structure']
end
