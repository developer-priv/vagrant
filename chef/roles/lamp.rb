name "lamp"

# We are activating mpm_prefork - otherwise php will not work
# Unfortunately apache2 cookbook attributes default to mpm_event on Ubuntu 14.04
# With no regard for the apache version
# That's why we need to run recipe[apache::mpm_prefork] manually below

run_list %W(
  recipe[apt]
  recipe[openssl]
  recipe[apache2]
  recipe[apache2::mpm_prefork]
  recipe[apache2::mod_php5]
  recipe[php]
  recipe[php::module_mysql]

  recipe[main_common]
  recipe[main_lamp]
)
