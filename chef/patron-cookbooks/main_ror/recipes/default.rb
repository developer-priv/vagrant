# Remember to rbenv rehash/update PATH after installation of gem/package

username = node['username']
ruby_version = node['ruby']['version']

# Install ruby 
rbenv_ruby ruby_version do
  user "#{username}"
end

rbenv_global ruby_version do
  user "#{username}"
end

execute "Installing Bundler gem" do
  command "su #{username} -l -c 'gem install bundler'"
end

execute "Rbenv rehash (automatic shim generation)" do
  command "su #{username} -l -c 'rbenv rehash'"
end

# Due to multiple bugs in the rbenv cookbook the following 
# sometimes throws errors on "vagrant provision"
# That's why we are not using that and we install Bundler ourselves (code above)
# rbenv_gem "bundler" do
#   rbenv_version "2.2.1"
#   version "1.9"
#   user "vagrant"
#   clear_sources "0"
#   action :install
# end

# Below we are not using recursive directory creation,
# because Chef is creating directories as root instead of specified user
# Ticket: https://tickets.opscode.com/browse/CHEF-1621

directory "/home/#{username}/web" do
  owner "#{username}"
  group "#{username}"
  mode '0755'
  action :create
end

directory "/home/#{username}/web/unicorn" do
  owner "#{username}"
  group "#{username}"
  mode '0755'
  action :create
end

directory "/home/#{username}/web/unicorn/pids" do
  owner "#{username}"
  group "#{username}"
  mode '0755'
  action :create
end

# Default Unicorn configuration
template "/home/#{username}/web/unicorn.rb" do
  source "unicorn/unicorn.rb.erb"
  owner "#{username}"
  group "#{username}"
  mode 0644
end

# Shuts down Unicorn, copies application files, runs "bundler install" and starts it up again
template "/home/#{username}/unicorn-deploy.sh" do
  source "unicorn/unicorn-deploy.sh.erb"
  owner "#{username}"
  group "#{username}"
  mode 0755
end

execute "Deploying RoR application with Unicorn server" do
  command "su #{username} -l -c 'sh /home/#{username}/unicorn-deploy.sh #{username} > /home/#{username}/unicorn-deploy.log 2> /home/#{username}/unicorn-deploy-error.log'"
end

# nginx configuration
case node['web_server']['type']
when 'basic'
  nginx_template_source = "nginx/basic.conf.erb"
when 'unicorn'
  nginx_template_source = "nginx/unicorn.conf.erb"
end

template "/etc/nginx/conf.d/default.conf" do
  source nginx_template_source
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end
