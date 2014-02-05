def initialize(*args)
  super
  @action = :enable
end

action :enable do
  directory "/etc/drush" do
    mode 00777
    action :create
  end

  t = template "/etc/drush/#{new_resource.name}.alias.drushrc.php" do
    cookbook "drush"
    source "alias.erb"
    mode 0644
    variables(:alias => new_resource)
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :disable do
  file "/etc/drush/#{new_resource.name}.alias.drushrc.php" do
    action :delete
  end
  new_resource.updated_by_last_action(true)
end
