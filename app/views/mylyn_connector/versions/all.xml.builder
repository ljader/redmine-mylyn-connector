xml.instruct! :xml, :encoding => "UTF-8"
xml.versions root_attribs do
  @versions.each do |version|
    xml.version :id => version.id do
      xml.name version.name
      xml.status  version.status
    end
  end
end
