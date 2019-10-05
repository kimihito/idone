# need ENV['HEROKU_APP_NAME']
namespace :heroku_review_apps do
  desc 'create bucket for Heroku Reivew Apps'
  task setup: :environment do
    Rake::Task['active_storage:create_bucket'].invoke(ENV['HEROKU_APP_NAME'], "#{ENV['HEROKU_APP_NAME']}.herokuapp.com")
    ENV['FIXTURES'] = 'users,projects,tracks' # Workaround ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation: ERROR: insert or update on table "tracks" violates foreign key constraint "fk_rails_xxxxx"
    Rake::Task['db:fixtures:load'].invoke
  end

  desc 'cleanup buckets using Heroku Review Apps'
  task cleanup: :environment do
    Rake::Task['active_storage:cleanup_bucket'].invoke(ENV['HEROKU_APP_NAME'], "#{ENV['HEROKU_APP_NAME']}.herokuapp.com")
  end
end
