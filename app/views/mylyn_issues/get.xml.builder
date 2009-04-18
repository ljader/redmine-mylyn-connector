xml.instruct! :xml, :encoding => "UTF-8"
xml.issue :xmlns => 'http://redmine-mylyn.sf.net/schemas/issue' do
  xml.assignedToId @issue.assigned_to_id
  xml.authorId @issue.author_id
  xml.id @issue.id
  xml.availableStatus {
#    xml << render(:partial => 'issue_status.builder', :locals => {:object => status, :collection => available_status(@issue)})
    available_status(@issue).each do |status|
      render :partial => 'issue_status.builder', :locals => {:status => status, :xml_override => xml}
    end
  }
end