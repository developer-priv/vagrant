username = node['username']

web_app "main" do
  template "apache.conf.erb"
  server_name node['web_server']['domain']
  docroot "/vagrant/shared/web/php"
  notifies :restart, resources("service[apache2]"), :delayed
end

# Current verion of apache2::mod_php5 does load libapache2-mod-php5 that in turn creates default ini at:
# /etc/php5/apache2/php.ini
# The problem is that setting ['php']['directives'] does not work here, because on Ubuntu it influences only
# /etc/php5/cli/php.ini
# The solution would be to either prepare custom php.ini template, or a parser that modifies php.ini

# display_errors="On"
# display_startup_errors = On
# error_reporting = E_ALL | E_STRICT
# log_errors = On
# error_log = "/srv/data"
