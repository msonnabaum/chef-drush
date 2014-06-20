actions :enable, :disable

attribute :name, :kind_of => String, :name_attribute => true
attribute :variables, :kind_of => Hash, :default => {}

def initialize(*args)
  super
  @action = :enable
end
