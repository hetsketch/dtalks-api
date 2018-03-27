require 'shrine'

if Rails.env.development?
  require 'shrine/storage/file_system'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', host: 'http://localhost:3000', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', host: 'http://localhost:3000', prefix: 'uploads/store')
  }
elsif Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require 'shrine/storage/s3'
  s3_options = {
    access_key_id:     ENV['S3_ACCESS_KEY'],
    secret_access_key: ENV['S3_ACCESS_SECRET_KEY'],
    region:            ENV['S3_REGION'],
    bucket:            ENV['S3_BUCKET']
  }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: { acl: 'public-read' }, **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl: 'public-read' }, **s3_options),
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
