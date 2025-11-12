# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

gem "aws-sdk-s3", require: false

group :production do
  gem 'unicorn', '6.1.0'
end