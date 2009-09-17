require 'ostruct'

Gadget = OpenStruct.new(YAML.load_file(root_path('config', 'gadget.yml'))[Main.environment.to_s])
