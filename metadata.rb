maintainer       "Mark Sonnabaum"
maintainer_email "mark.sonnabaum@acquia.com"
license          "Apache 2.0"
description      "Installs drush"
version          "0.9.1"
depends          "php"
recipe "drush", "Installs drush"

%w{ debian ubuntu arch }.each do |os|
  supports os
end

