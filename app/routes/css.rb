class Main
  get "/css/:stylesheet.css" do
    content_type "text/css", :charset => "UTF-8"
    css = sass(:"css/#{params[:stylesheet]}", Compass.sass_engine_options)
    if Sinatra::Application.environment == :production
      File.open(Compass.configuration.css_dir.join("#{params[:stylesheet]}.css"), "w") do |f|
        f.write(css)
      end
    end
    css
  end
end
