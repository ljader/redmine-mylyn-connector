xml.instruct! :xml, :encoding => "UTF-8"
xml.version root_attribs do
  xml.plugin(MylynConnector::Version,
    :major => @data[0],
    :minor => @data[1],
    :tiny => @data[2])
  xml.redmine Redmine::VERSION
  #xml.rails	Gem.loaded_specs["rails"].version
 #xml.rails RAILS_GEM_VERSION
 xml.rails Rails::VERSION::STRING
end
