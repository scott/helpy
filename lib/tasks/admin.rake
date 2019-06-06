# RAILS_ENV=production rake admin:set_password password=xyz123 

namespace :admin do
    task :set_password => :environment do
        User.admins.first.update_attribute(:password, ENV['password'])
    end
end