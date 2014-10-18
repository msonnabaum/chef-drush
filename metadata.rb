name             'drush'
maintainer       "Mark Sonnabaum"
maintainer_email "mark.sonnabaum@acquia.com"
license          "Apache 2.0"
description      "Installs drush, the Drupal Shell."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.10.0"
depends          "php", ">= 0.99.0"
recommends       "git"

recipe           "drush",           "Installs Drush and dependencies."
recipe           "drush::pear",     "Installs Drush via PEAR."
recipe           "drush::composer", "Installs Drush via Composer."
recipe           "drush::git",      "Installs Drush via Git (drupal.org repository)"
recipe           "drush::make",     "Installs Drush Make via Drush. NOT required for Drush 5."

%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end
