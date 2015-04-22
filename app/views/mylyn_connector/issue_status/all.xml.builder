xml.instruct! :xml, :encoding => "UTF-8"
xml.issueStatuses root_attribs do
  @issue_status.each do |status|
    xml.issueStatus :id => status.id do
      xml.name status.name
      xml.position status.position
      xml.isClosed status.is_closed
    end
  end
end
