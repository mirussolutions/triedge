# config valid only for current version of Capistrano
   lock '3.4.0'
    
   
    set :application, 'triedge'
    set :repo_url, 'git@github.com:mirussolutions/triedge.git'
    set :deploy_to, '/home/mirus/webapps/trainingapp'
    
	set :use_sudo, false
	set :deploy_via, :copy
	set :branch, "master"
    set :default_stage, "production"
	set :default_env, {
	    'PATH' => "#{deploy_to}/bin:$PATH",
	    'GEM_HOME' => "#{deploy_to}/gems",
	    'RUBYLIB' => "#{deploy_to}/lib"
	}

	set :scm, :git
	set :scm_username, "mirussolutions"
	
    set :pty, true
    
    set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
    
    set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets')
    
    set :tmp_dir, '/home/mirus/tmp'
    #set :ssh_options, { forward_agent: true, paranoid: true, keys: "~/.ssh/id_rsa" }
    #set :tmp_dir, "#{deploy_to}/tmp"
    #set :default_env, {'PATH' => "#{deploy_to}/bin:$PATH",'GEM_HOME' => "#{deploy_to}/gems"}
    
    #set :passenger_instance_registry_dir, '/home/mirus/webapps/trainingapp/tmp'
    

   # namespace :deploy do
     # task :restart do
     #   on roles(:app) do
          #execute "passenger-config restart-app --ignore-app-not-running #{deploy_to}"
      #    execute "/home/mirus/webapps/trainingapp/bin/restart"
      #  end
     ## end
  #  end
  namespace :deploy do
	desc 'Restart application'
	  task :restart do
	    on roles(:app), in: :sequence, wait: 5 do
	    	capture("#{deploy_to}/bin/restart")
	      #execute "passenger-config restart-app --ignore-app-not-running #{deploy_to}"
	  end
	end
  end
    set :config_dirs, %W{config config/environments/#{fetch(:stage)} public/uploads}
    set :config_files, %w{config/database.yml config/secrets.yml}
    namespace :deploy do
	  desc 'Copy files from application to shared directory'
	  ## copy the files to the shared directories
	  task :copy_config_files do
	    on roles(:app) do
	      # create dirs
	      fetch(:config_dirs).each do |dirname|
	        path = File.join shared_path, dirname
	        execute "mkdir -p #{path}"
	      end

	      # copy config files
	      fetch(:config_files).each do |filename|
	        remote_path = File.join shared_path, filename
	        upload! filename, remote_path
	      end

	     end
       end
      end

    namespace :bundle do

	  desc "run bundle install and ensure all gem requirements are met"
	  task :install do
	  	on roles(:app) do
	     #execute "cd ~/webapps/trainingapp2/current"
	    # execute "cd current"
	     #execute "bundle install"
	     #run "bundle install  --without=test --no-update-sources"
	     capture("cd #{current_path}")
	     capture("bundle install")
	   end
      end
	end
	#before 'deploy:restart', 'bundle:install'
    after 'deploy:finishing', 'deploy:restart'
  # after 'deploy:finishing', 'bundle:install'
    #after 'bundle:install', 'deploy:restart'
