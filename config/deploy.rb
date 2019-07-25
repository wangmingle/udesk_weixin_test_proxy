# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "udesk_weixin_test_proxy"
set :user, 'webuser'
set :repo_url, "git@github.com:wangmingle/udesk_weixin_test_proxy.git"
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :deploy_to, "/srv/nginx/conf/vhosts"

namespace :udesk do

  desc 'Setup nginx file'
  task :setup_nginx_file do
    on roles(:all), in: :parallel do
      within release_path do
      	property_file = fetch(:nginx_config)
        property_path = "#{release_path}/config/nginx/#{property_file}"
        execute :rm, '/srv/nginx/conf/vhosts/wx_proxy.nginx.conf -f'
        execute :ln, '-s', "#{property_path} /srv/nginx/conf/vhosts/wx_proxy.nginx.conf"
      end
    end
  end

end

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

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
