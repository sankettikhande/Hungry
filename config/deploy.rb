
require 'bundler/capistrano'
require 'delayed/recipes'
load 'config/recipes/db'
# load "config/recipes/delayed_job"
# default_run_options[:shell] = '/bin/bash'
set :repository,  "git@bitbucket.org:pravinhmhatre/holachef.git"
set :application, 'holachef'
set :deploy_via, :remote_cache
set :scm, 'git'

set :scm_verbose, true
set :use_sudo, false
set :keep_releases, 2
set :rails_env, "production"
set :precompile_only_if_changed, true

task :qa do
  default_run_options[:pty] = true
  set :branch, 'paymentcodeMaster'

  # be sure to change these
  set :user, 'root'
  set :domain, '103.13.97.227'
  set :deploy_env, 'qa'

  # the rest should be good
  set :deploy_to, "/data/apps/#{application}-qa"

  role :db, domain, :primary => true

  server domain, :app, :web

  after "deploy:update_code", "deploy:migrate"
  after "deploy:create_symlink", "deploy:change_permission_for_tmp"
  ##after "deploy:restart", "delayed_job:restart"
end

task :prod do
  default_run_options[:pty] = true
  set :branch, 'master'

  # be sure to change these
  set :user, 'root'
  set :domain, '103.13.97.227'
  set :deploy_env, 'prod'

  # the rest should be good
  set :deploy_to, "/data/apps/#{application}"

  role :db, domain, :primary => true

  server domain, :app, :web

  after "deploy:update_code", "deploy:migrate"
  after "deploy:create_symlink", "deploy:change_permission_for_tmp"
  ##after "deploy:restart", "delayed_job:restart"
end


namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :copy_newrelic do
    run "cp #{release_path}/config/newrelic.yml.#{deploy_env} #{release_path}/config/newrelic.yml"
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

after "deploy:update_code", "db:symlink", "deploy:copy_newrelic"
after "deploy:update", "deploy:cleanup"




