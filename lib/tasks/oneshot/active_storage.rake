require 'google/cloud/storage'

namespace :oneshot do
  namespace :active_storage do
    desc 'activate CORS to production gcs bucket'
    task :cors, [:bucket_name] => :environment do |task, args|
      bucket = storage.bucket 'idone-today'
      bucket.cors do |c|
        c.pop
        c.add_rule ["https://idone.today"],
                   '*',
                   headers: ['Content_type', 'Content-Md5'],
                   max_age: 3600
      end
    end
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