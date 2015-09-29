#server "mirus@web300.webfaction.com", user: "mirus", roles: %w{web app db}, ssh_options: {
#keys: %w(~/.ssh/id_rsa),
#forward_agent: true }
set :bundle_gemfile,  'Gemfile'
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
server "mirus@web300.webfaction.com", user: "mirus", roles: %w{web app db}