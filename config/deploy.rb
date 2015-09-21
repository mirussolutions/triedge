# config valid only for current version of Capistrano
   lock '3.4.0'
    
   
    set :application, 'triedge'
    set :repo_url, 'git@github.com:mirussolutions/triedge.git'
    set :deploy_to, '/home/mirus/webapps/trainingapp'
   
	set :use_sudo, false
	set :deploy_via, :checkout
	set :branch, "master"

	set :default_env, {
	    'PATH' => "#{deploy_to}/bin:$PATH",
	    'GEM_HOME' => "#{deploy_to}/gems",
	    'RUBYLIB' => "#{deploy_to}/lib"
	}

	set :scm, :git
	set :scm_username, "mirussolutions"
	
    set :pty, true
    
    #set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml', 'config/secrets.yml')
    
    set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
    
    set :tmp_dir, "#{deploy_to}/tmp"
    set :default_env, {'PATH' => "#{deploy_to}/bin:$PATH",'GEM_HOME' => "#{deploy_to}/gems"}
    
    namespace :deploy do
      task :restart do
        on roles(:app) do
          capture("#{deploy_to}/bin/restart")
        end
      end
    end
    
    namespace :deploy do

	  task :config_symlink do
	    run "cp #{shared_path}/../../shared/database.yml #{release_path}/config/database.yml"
	  end
	end
    after 'deploy:finishing', 'deploy:restart'