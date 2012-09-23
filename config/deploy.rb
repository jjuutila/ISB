# Capistrano database.yml task
require File.expand_path('../deploy/capistrano_database', __FILE__)

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-p290@isb'             # RVM gemset
set :rvm_type, :user                                    # Deploying to user's home directory

set :application, "isb"
set :repository,  "git://github.com/jaskaj/ISB.git"

set :scm, :git
set :git_shallow_clone, 1

set :user, "isb"

role :web, "kirsikka.kapsi.fi"                    # Your HTTP server, Apache/etc
role :app, "kirsikka.kapsi.fi"                    # This may be the same as your `Web` server
role :db,  "kirsikka.kapsi.fi", :primary => true  # This is where Rails migrations will run

set :deploy_to, "/home/users/isb/isb-web"
set :use_sudo, false

require 'bundler/capistrano'

namespace :deploy do
  desc "Custom ISB deployment: stop."
  task :stop, :roles => :app do
    invoke_command "thin stop -C #{current_path}/config/thin.yml"
  end

  desc "Custom ISB deployment: start."
  task :start, :roles => :app do
    invoke_command "thin start -C #{current_path}/config/thin.yml"
  end

  desc "Custom ISB deployment: restart."
  task :restart, :roles => :app do
    invoke_command "thin restart -C #{current_path}/config/thin.yml"
  end
end

namespace :logs do
  task :production do
    stream("tail -f /home/users/isb/isb-web/current/log/production.log")
  end
end
