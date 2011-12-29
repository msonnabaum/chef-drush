maintainer       "Mark Sonnabaum"
maintainer_email "mark.sonnabaum@acquia.com"
license          "Apache 2.0"
description      "Installs drush"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.9.2"
depends          "php"

recipe           "drush",             "Installs drush"
recipe           "drush::make",       "Installs drush_make, first making sure drush is installed"
recipe           "drush::dev",        "Installs master branch of drush from git"
recipe           "drush::drush4-dev", "Installs 7.x-4.x branch of drush from git"

%w{ debian ubuntu centos }.each do |os|
  supports os
end

