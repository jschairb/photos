namespace :db do 
  
  desc "Generates fake data"
  task :seed_data do
    users = []
    
    # login data instruction
    puts "\n**************\n\nThe following accounts are available for use:\n\n" 
    puts '  user@kipplerapp.com (password: test)'
    puts '  admin@kipplerapp.com (password: test)'
    puts "\n**************\n\n" 
  end

  desc "Regenerate db from migrations, clone structure to test env, and reload dev fixtures"
  task :do_over => ['db:migrate:reset', 'db:seed_data', 'db:test:clone_structure']

end
