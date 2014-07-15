
require 'bundler/capistrano'
load 'deploy/assets'
load 'config/recipes/db'

# default_run_options[:shell] = '/bin/bash'

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
  set :application, 'holachef'

  # the rest should be good
  set :repository,  "https://pravinhmhatre@bitbucket.org/pravinhmhatre/holachef.git"
  set :deploy_to, "/home/#{user}/#{domain}"
  set :deploy_via, :remote_cache
  set :scm, 'git'
  set :branch, 'master'
  set :git_shallow_clone, 1
  set :scm_verbose, true
  set :use_sudo, false

  server domain, :app, :web
  # role :db, domain, :primary => true
  after "deploy:create_symlink", "deploy:change_permission_for_fcgi"
end

task :prod do
  default_run_options[:pty] = true


  # be sure to change these
  set :user, 'root'
  set :domain, '103.13.97.227'
  set :application, 'holachef'

  # the rest should be good
  set :repository,  "https://pravinhmhatre@bitbucket.org/pravinhmhatre/holachef.git"
  set :deploy_to, "/data/apps/#{application}"
  set :deploy_via, :remote_cache
  set :scm, 'git'
  set :branch, 'master'
  set :git_shallow_clone, 1
  set :scm_verbose, true
  set :use_sudo, false

  role :db, domain, :primary => true

  server domain, :app, :web

  after "deploy:update_code", "deploy:migrate"
  after "deploy:migrate", "deploy:change_permission_for_tmp"
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
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile, :roles => :web, :except => { :no_release => true } do
      %x{bundle exec rake assets:precompile}
      %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{domain}:#{shared_path}}
      %x{bundle exec rake assets:clean}
    end
  end
end

after "deploy:update_code", "db:symlink"
before "deploy:assets:update_asset_mtimes", "db:symlink"


