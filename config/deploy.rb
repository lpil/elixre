lock '3.4.0'

set :application, 'elixre'
set :repo_url, 'https://github.com/lpil/elixre.git'

set :deploy_to, '/apps/elixre'

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5

namespace :deploy do
  desc 'Download NPM front end deps'
  task :get_asset_deps do
    on roles(:all) do
      within release_path do
        info 'This might take a while...'
        execute :npm, 'install', '--production'
      end
    end
  end
  after 'deploy:updated', 'deploy:get_asset_deps'

  desc 'Build front end app'
  task :build_assets do
    on roles(:all) do
      within release_path do
        execute './node_modules/grunt-cli/bin/grunt', 'build'
      end
    end
  end
  after 'deploy:get_asset_deps', 'deploy:build_assets'

  desc 'Get Elixir deps'
  task :get_elixir_deps do
    on roles(:all) do
      within release_path do
        execute 'mix', 'deps.get'
      end
    end
  end
  after 'deploy:build_assets', 'deploy:get_elixir_deps'

  desc 'Restart application'
  task :restart do
    on roles(:all), in: :sequence, wait: 5 do
      execute "sudo systemctl service restart"
    end
  end
  after 'deploy:publishing', 'deploy:restart'
end
