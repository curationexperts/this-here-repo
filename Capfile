# frozen_string_literal: true
# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Use bundler to install gem requirements
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/sidekiq'
require 'capistrano/passenger'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

require 'capistrano/honeybadger'

# use whenever to manage cron jobs
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
