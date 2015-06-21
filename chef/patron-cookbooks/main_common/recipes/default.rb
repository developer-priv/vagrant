# Install mysql using LWRP
mysql_service 'main' do
  port node['mysql']['port']
  version node['mysql']['version']
  initial_root_password node["mysql"]["password"]
  action [:create, :start]
end

# We're not using mc cookbook since it's doing exactly the same thing under the hood
package 'mc'
