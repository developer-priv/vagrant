name "ror"

run_list %W(
  recipe[apt]
  recipe[nodejs]
  recipe[ruby_build]
  recipe[rbenv::user_install]
  recipe[rbenv::vagrant]
  recipe[vim]
  recipe[nginx]

  recipe[main_common]
  recipe[main_ror]
)
