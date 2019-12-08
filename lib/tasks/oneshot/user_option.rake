namespace :oneshot do
  namespace :user_option do
    desc 'create user_option to existing user'
    task create: :environment do
      puts 'Going to create UserOpition to exist User'
      User.find_each(&:create_user_option)
      puts 'All done now'
    end
  end
end