xml.instruct! :xml, :encoding => "UTF-8"
xml.groups root_attribs do
  @groups.each do |group|
    xml.group :id => group.id do
      xml.name group.name
    end
  end
end
