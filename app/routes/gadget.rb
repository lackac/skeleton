class Main
  get '/gadget.xml' do
    content_type :xml, :charset => 'UTF-8'
    haml :"gadget/gadget", :layout => false, :format => :xhtml
  end
end
