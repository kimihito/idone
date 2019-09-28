require 'google/cloud/storage'

# need ENV['HEROKU_APP_NAME']
namespace :heroku_review_apps do
  desc 'create bucket for Heroku Reivew Apps'
  task create_bucket: :environment do
    storage.create_bucket(ENV["HEROKU_APP_NAME"], location: 'us-east1')
  end

  desc 'cleanup buckets using Heroku Review Apps'
  task cleanup: :environment do
    ActiveStorage::Blob.find_each(&:purge)
    storage.bucket(ENV["HEROKU_APP_NAME"]).delete
  end
end


private

def storage
  Google::Cloud::Storage.new(credentials: credentials)
end


def credentials
  Google::Cloud::Storage::Credentials.new(
    {
      project_id: ENV.fetch('GCS_PROJECT_ID'),
      private_key: ENV.fetch('GCS_PRIVATE_KEY').gsub("\\n", "\n"),
      private_key_id: ENV.fetch('GCS_PRIVATE_KEY_ID'),
      client_email: ENV.fetch('GCS_CLIENT_EMAIL'),
      client_id: ENV.fetch('GCS_CLIENT_ID'),
      client_x509_cert_url: ENV.fetch('GCS_X509_CERT_URL')
    }
  )
end