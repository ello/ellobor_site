## Pretty required
source 'https://rubygems.org'
gem 'rails', '4.2.1'

## Our flavor of coding
gem 'sass-rails', '~> 5.0'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.1.0'

## Post-processors
gem 'uglifier', '>= 1.3.0'

## Db stuff
gem 'pg'

## Helpers
gem "kaminari" # adds pagination to ActiveModels

## Engines / Services / API Helpers
# gem "gibbon" ## for mailchimp
gem "sidekiq" ## bg processes
# gem "postmark-rails" ## transaction email

## Libraries
gem 'jquery-rails'
gem "jquery-ui-rails"
# gem 'jbuilder', '~> 2.0'

group :production do
  # lock stagin server
  gem 'lockup', '~> 1.3.2.1'
  
  # system tools
  # gem 'god'
end

group :development do
  ## for the rails c
  gem 'pry'
  ## for locally editing shopify theme
  # gem 'shopify_theme'
  ## for auto-reload of the browser
  gem 'guard', '>= 2.2.2', require: false
  gem 'guard-livereload',  require: false
  gem 'rb-fsevent',        require: false
  ## for better error pages
  gem 'better_errors'
  gem 'binding_of_caller'
  ## for viewing objects
  gem "awesome_print"
  # gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views

  ## Deployment
  # gem 'capistrano', '~> 3.4', require: false
  # gem 'capistrano-rails',     require: false
  # gem 'capistrano-bundler',   require: false
  # gem 'capistrano-rvm',       require: false
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc
