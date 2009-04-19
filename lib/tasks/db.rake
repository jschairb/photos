namespace :db do 
  
  desc "Generates fake data"
  task :seed_data do
    sh "ruby script/seed-data"
  end

  desc "Regenerate db from migrations, clone structure to test env, and reload dev fixtures"
  task :do_over => ['db:migrate:reset', 'db:seed_data', 'db:test:clone_structure']

end
