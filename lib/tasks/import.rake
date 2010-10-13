namespace :db do
  desc "Load YAML seed data from db/data"
  task :import => :environment do
    require 'yaml'
    yml = YAML::load(File.open(File.join( RAILS_ROOT, 'db', 'data', 'sections.yml' )))
    yml.each do |section|
     Section.create(:name => section["name"], :slug => section["slug"], :parent_id => section["parent_id"])
    end
     #Section.create(section) 

     
  end

  desc "This drops the db, builds the db, and seeds the data."
  task :reseed => [:environment, 'db:reset', 'db:seed']
end