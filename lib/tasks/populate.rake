require "bcrypt"

namespace :db do
    desc "Populate all languages and repository type"
    task :populate => :environment do
    
    [Country].each(&:delete_all)
    
    File.open('lib/tasks/countries.txt', 'r').each_line do |line|
        country = Country.new({ 
            :name => line
        })
        country.save
    end
 
  end
end