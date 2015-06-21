# This file is used by Rack-based servers to start the application.

#rails "Ruby version: #{RUBY_VERSION}"
require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
