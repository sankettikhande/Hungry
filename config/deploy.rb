
require 'bundler/capistrano'
require 'delayed/recipes'
load 'config/recipes/db'
# load "config/recipes/delayed_job"
# default_run_options[:shell] = '/bin/bash'
set :repository,  "git@bitbucket.org:pravinhmhatre/holachef.git"
set :application, 'holachef'
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, "production"
set :precompile_only_if_changed, true

task :qa do
  set :bundle_cmd, "/home/holachef/.gems/bin/bundle"
  set :default_environment, {

    'PATH' => "$PATH:/home/holachef/ruby/bin",
    'GEM_HOME'        => "/home/holachef/.gems",
    'GEM_PATH'        => "/home/holachef/.gems",
    'BUNDLE_PATH'     => "/home/holachef/.gems"
  }

  default_run_options[:pty] = true


  # be sure to change these
  set :user, 'holachef'
  set :domain, 'qa.holachef.com'

  # the rest should be good
  set :repository,  "https://pravinhmhatre@bitbucket.org/pravinhmhatre/holachef.git"
  set :deploy_to, "/home/#{user}/#{domain}"
  set :delayed_job_server_role, :worker
  set :delayed_job_args, "-n 2"

  server domain, :app, :web
  # role :db, domain, :primary => true
  after "deploy:create_symlink", "deploy:change_permission_for_fcgi"
end

task :prod do
  default_run_options[:pty] = true


  # be sure to change these
  set :user, 'root'
  set :domain, '103.13.97.227'

  # the rest should be good
  set :deploy_to, "/data/apps/#{application}"

  role :db, domain, :primary => true

  server domain, :app, :web

  after "deploy:update_code", "deploy:migrate"
  after "deploy:create_symlink", "deploy:change_permission_for_tmp"
  after "deploy:restart", "delayed_job:restart"
end


namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :change_permission_for_fcgi do
    run "chmod +x #{current_path}/public/dispatch.fcgi"
  end

  task :change_permission_for_tmp do
    run "chmod -R 777 #{current_path}/tmp"
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      logger.info "Skipping asset pre-compilation because there were no asset changes"
    end
  end
end

after "deploy:update_code", "db:symlink"


