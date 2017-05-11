source "https://rubygems.org"

gem 'rspec'
gem 'rake'
gem 'puppetlabs_spec_helper'
gem 'puppet-blacksmith'
gem 'metadata-json-lint'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion,  :require => false
else
  gem 'puppet',                 :require => false
end
