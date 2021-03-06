# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
# lock '~> 3.11.0'

set :application, 'TimeSheet'
set :repo_url, 'https://github.com/ChrisMcdonald/TimeSheet.git'
set :user, 'chris'
set :branch, 'timesheet'
set :ruby_version, '/home/chris/.rbenv/shims/ruby'
set :default_env, -> {{ path: [fetch(:ruby_version), "#{release_path}/bin", "$PATH"].join(":") }}

API = {}


# install_plugin Capistrano::SCM::Git
set :keep_releases, 1

set :use_sudo, false
set :deploy_to, '/home/chris/TimeSheet'
# set :rails_env, "production"
# set :deploy_via, :copy
# set :ssh_options, { :forward_agent => true, :port => 4321 }
# set :keep_releases, 5

append :linked_files, 'config/database.yml', 'config/application.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'


desc 'Restart Passenger app'
task :restart do
  run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
end
#
# after "deploy", "deploy:symlink_config_files"
# after "deploy", "deploy:restart"
# after "deploy", "deploy:cleanup"

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
