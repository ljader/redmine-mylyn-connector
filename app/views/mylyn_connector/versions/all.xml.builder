xml.instruct! :xml, :encoding => "UTF-8"
xml.versions :xmlns => 'http://redmin-mylyncon.sf.net/api', :api=>api_version do
  @versions.each do |version|
    xml.version :id => version.id do
      xml.name version.name
      xml.status  version.status
    end
  end
end
