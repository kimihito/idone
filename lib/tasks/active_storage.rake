require 'google/cloud/storage'

namespace :active_storage do
  desc 'create bucket'
  task :create_bucket, [:bucket_name, :domain] => :environment do |task, args|
    storage.create_bucket(args.bucket_name, location: 'us-east1') do |b|
      b.cors.add_rule ["http://#{args.domain}", "https://#{args.domain}"],
                      '*',
                      headers: ['Content-Type', 'Content-Md5'],
                      max_age: 3600
    end
  end

  desc 'cleanup buckets'
  task :cleanup_bucket, [:bucket_name] => :environment do |task, args|
    ActiveStorage::Blob.find_each(&:purge)
    storage.bucket(args.bucket_name).delete
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