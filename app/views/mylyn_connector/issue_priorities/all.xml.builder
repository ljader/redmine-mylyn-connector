xml.instruct! :xml, :encoding => "UTF-8"
xml.issuePriorities root_attribs do
  @priorities.each do |priority|
    xml.issuePriority :id => priority.id do
      xml.name priority.name
      xml.position  priority.position
      xml.isDefault  priority.is_default
    end
  end
end
