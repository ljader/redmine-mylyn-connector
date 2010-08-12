xml.issue({:id => issue.id, :editAllowed => edit_allowed?(issue)}.merge(attr||={}) ) do

  #Ticket
  xml.subject issue.subject
  xml.updatedOn issue.updated_on.xmlschema, :unixtime => issue.updated_on.to_i

  #References
  xml.projectId issue.project_id
  xml.statusId issue.status_id
  xml.priorityId issue.priority_id

end

