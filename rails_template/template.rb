def source_paths
  Array(super) + [File.expand_path(File.dirname(__FILE__))]
end

gsub_file 'Gemfile', 'https://rubygems.org', 'https://ruby.taobao.org'
gsub_file 'Gemfile', "gem 'mysql2'", "gem 'mysql2', '~> 0.3.20'"

# gem 'mysql2'
# gem 'pg'
gem 'kaminari'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'rails-i18n'
gem 'ransack'
gem 'httparty'
# gem 'pundit'
# gem 'redis'
# gem 'sidekiq'
# gem 'acts_as_enum'

gem 'unicorn'
gem 'unicorn-worker-killer'

gem_group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
end

gem_group :development, :test do
  gem 'byebug'

  # gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end


environment "config.active_record.default_timezone = :local"
environment "config.i18n.default_locale = 'zh-CN'"
environment "config.time_zone = 'Beijing'"

run "curl https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/zh-CN.yml > config/locales/zh-CN.yml"
run "curl https://raw.githubusercontent.com/ifool/dev_conf/master/rails_template/config/initializers/i18n.rb > config/initializers/i18n.rb"
run "curl https://raw.githubusercontent.com/ifool/dev_conf/master/rails_template/app/helpers/application_helper.rb > app/helpers/application_helper.rb"
run "curl https://raw.githubusercontent.com/ifool/dev_conf/master/rails_template/.gitignore > .gitignore"
run "curl https://raw.githubusercontent.com/ifool/dev_conf/master/rails_template/config.ru > config.ru"
run "curl https://raw.githubusercontent.com/ifool/dev_conf/master/rails_template/config/unicorn.rb > config/unicorn.rb"
run "bundle exec cap install"
run "cp config/database.yml config/database.yml.example"

generate :"simple_form:install", "--bootstrap"
generate :"kaminari:config"
# generate :"kaminari:views", "bootstrap3"
# usable themes for kaminari are: default bootstrap2 bootstrap3 bourbon foundation github google materialize purecss semantic_ui

after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial project' }
end
