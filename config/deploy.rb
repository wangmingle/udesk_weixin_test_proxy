# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "udesk_weixin_test_proxy"
set :user, 'webuser'
set :repo_url, "git@github.com:wangmingle/udesk_weixin_test_proxy.git"
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :deploy_to, "/srv/www/#{fetch :application}"
set :ssh_options, {user: fetch(:user), forward_agent: true}
set :linked_dirs, %w{log}

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

  desc 'nginx reload'
  task :nginx_reload do
    on roles(:all), in: :parallel do
      within release_path do
        execute("sudo /srv/nginx/sbin/nginx -s reload")
      end
    end
  end

end

after 'deploy:publishing', 'udesk:setup_nginx_file'
after 'deploy:publishing', 'udesk:nginx_reload'