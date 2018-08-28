namespace :db do
  task dump_config: :environment do
    File.open("#{Rails.root}/config/dev_database.yml", "w") do |f|
      f.write ActiveRecord::Base.configurations[Rails.env].to_yaml
    end
  end

  task apply: :dump_config do
    sh "bundle exec convergence apply #{Rails.root}/db/schema/schema.rb -c #{Rails.root}/config/dev_database.yml"
  end

  task migrate: :apply

  task dryrun: :dump_config do
    sh "bundle exec convergence apply #{Rails.root}/db/schema/schema.rb -c #{Rails.root}/config/dev_database.yml --dry-run"
  end

  task :overhaul do
    %w(db:drop db:create db:migrate db:seed).each do |t|
      Rake::Task[t].invoke
    end
  end
end
