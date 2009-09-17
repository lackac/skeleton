ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "ohm"
require "haml"
require "sass"
require "compass"
require 'gadgeteer'

# Getting rid of default :escape_html => true
class Monk::Glue
  def haml(*args)
    super
  end
end

class Main < Monk::Glue
  set :app_file, __FILE__
  set :public_path, root_path("public")
  set :haml, { :format => :html5 }
  use Rack::Session::Cookie

  include Gadgeteer

  configure do
    Compass.configuration do |config|
      config.project_path = root
      config.sass_dir = File.join(views, "css")
      config.css_dir = File.join(public_path, "css")
      config.output_style = if environment == :production
        :compressed
      else
        :expanded
      end
    end
  end
end

# Connect to redis database.
Ohm.connect(settings(:redis))

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

Main.run! if Main.run?
