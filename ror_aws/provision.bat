REM There is an open bug for Vagrant AWS: https://github.com/mitchellh/vagrant/issues/5344
REM and https://github.com/mitchellh/vagrant/issues/5140

REM We are working around that bug by deleting the synced_folders file to force reloading of chef recipes
del .vagrant\machines\delta\aws\synced_folders

vagrant provision
