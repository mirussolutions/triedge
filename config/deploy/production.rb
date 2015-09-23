#server "mirus@web300.webfaction.com", user: "mirus", roles: %w{web app db}, ssh_options: {
#keys: %w(~/.ssh/id_rsa),
#forward_agent: true }

server "mirus@web300.webfaction.com", user: "mirus", roles: %w{web app db}