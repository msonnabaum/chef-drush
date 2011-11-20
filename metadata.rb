maintainer       "Mark Sonnabaum"
maintainer_email "mark.sonnabaum@acquia.com"
license          "Apache 2.0"
description      "Installs drush"
version          "0.9.2"
depends          "php"
recipe "drush", "Installs drush"

%w{ debian ubuntu arch centos }.each do |os|
  supports os
end

