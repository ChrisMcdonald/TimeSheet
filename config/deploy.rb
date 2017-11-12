# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, "Soupcloud"
set :repo_url, "https://github.com/ChrisMcdonald/TimeSheet.git"
set :user, "chris"
set :branch, 'timesheet'
set :passenger_restart_with_touch, true
require "capistrano/scm/git"
# install_plugin Capistrano::SCM::Git



set :use_sudo, false
set :deploy_to, '/home/chris/TimeSheet'
# set :rails_env, "production"
# set :deploy_via, :copy
# set :ssh_options, { :forward_agent => true, :port => 4321 }
# set :keep_releases, 5


append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
namespace :deploy do
before :starting,     :check_revision
after  :finishing,    :compile_assets
after  :finishing,    :cleanup
after  :finishing,    :restart
	end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
