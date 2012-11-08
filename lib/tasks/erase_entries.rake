require "bcrypt"

namespace :db do
    desc "erase all rows from db"
    task :erase_entries => :environment do
    
    [City, Comment, Country, Page, PageTypeCity, PageTypeUniversity, Section, Topic, University, User, UserType].each(&:delete_all)
 
  end
end